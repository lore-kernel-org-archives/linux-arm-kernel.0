Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA282C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:44:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22F720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lhHncI3Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqyNUgd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22F720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YkrdlPE3znAnpXBcgGMu8RKXHvEn2U0a2yWW2tM4FXY=; b=lhHncI3Z1EuIwY
	YpDoKOIzFADVFYkESznNrdEf/44PoLdEOmiBTQOV64XH1knFP8+DSc3FIT1dy7AdkE1mjHduhA1Wa
	bVGhe8sLBPa5T7O3VU23HaScyW9wCMseVTIKyiPXred8+9xqC8oRiC1Fb31yfepVHLuMLI6VK64n9
	PGxCiDDu1I6J6u/ahr+CxKHiKNP09EKXAZvdfS+N7l2pylQ91xNrppkwbP0Y/bQRqrmYjjX390/hX
	SJRZXvWVRmycXYEt0rg0Fkws++1aJ9wST4WmXU/loa9B0VPCF08eU3kGP5ICUg1iBIQgptuVwDtvO
	epNM+sCFiYG9VcLUBI8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkYZ-0001jr-7J; Wed, 16 Jan 2019 12:44:31 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkYV-0001jC-Cr
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:44:28 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so6738935wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=YI/hMv2Ykfpzsha58avQfgbQuOAe4wiKzvr58KA+C/4=;
 b=bqyNUgd0gfeRk1x1ONPXAxtmtgtkVIZQ4vTcWAaR4cjSIbk6sbAjhEa4a8gAFmSTUm
 0WTosVm+mjFAcid3iCNfaYDVE85/dPnxvAGRy6vrfRCe9YbtgvjeIalIoORPHXVtv2xE
 IUZ3c0unFCSlNppo8UYeXEZsDPlqoskBmxb30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=YI/hMv2Ykfpzsha58avQfgbQuOAe4wiKzvr58KA+C/4=;
 b=TFVVz1wNdcYygjJwSPlhdq0phINxTwChYSnONl/m0HZ5xdSsv1GJOKGF5XPJwlP+c2
 sl8KSLI9kt0V1eNgLaQrkhSd9Rf2RVAKtPW3Q+ILTYj1Li3zrYHOCDtlST9+ZezQoQVt
 alZcfC8l7Cd3BHAsoEUJsYOmZe6WFVXIozGGqQE70A9sfAK56knnDrj6A88cwckwfSFb
 RuaEBbc8b6+mbBRwD5vyx3l1P3DhiYQKsKN6nRb5enl7j0JTcywkfjAoHJL4SuAMFs7k
 jKnyAYl64N4aOthDRkLAI1LEg5Xgea2oMNWoIFUyxlBOO+7kJjbQ8fE9SjHs3DXP2FLY
 HOiw==
X-Gm-Message-State: AJcUukeJpq3qLSWxyk8pDP+9tnKZJSJ2z+rzMD6lqpTsjS+2WKAoUBsp
 nTplVv4LioOnfiAiVdplAzmDvw==
X-Google-Smtp-Source: ALg8bN6DdBq+X2nTLgwh2v+QzLpv9b8DGxQUfKcMDxj2cVxfqvcPm3IOUOrAn3yXMgVZdzcsdlxr9g==
X-Received: by 2002:adf:e407:: with SMTP id g7mr7222174wrm.277.1547642664949; 
 Wed, 16 Jan 2019 04:44:24 -0800 (PST)
Received: from dell ([2.27.35.149])
 by smtp.gmail.com with ESMTPSA id f130sm33103811wme.41.2019.01.16.04.44.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 04:44:24 -0800 (PST)
Date: Wed, 16 Jan 2019 12:44:21 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: [GIT PULL] Immutable branch between MFD, IIO and Input due for the
 v5.1 merge window
Message-ID: <20190116124421.GD23399@dell>
References: <20181221134638.20600-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_044427_449365_FCA9F044 
X-CRM114-Status: GOOD (  13.63  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, dmitry.torokhov@gmail.com,
 Max Krummenacher <max.krummenacher@toradex.com>, linux-iio@vger.kernel.org,
 stefan@agner.ch, thierry.reding@gmail.com,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, digetx@gmail.com,
 Freeman Liu <freeman.liu@spreadtrum.com>,
 linux-stm32@st-md-mailman.stormreply.com, robh@kernel.org,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Hunter <jonathanh@nvidia.com>,
 marcel.ziswiler@toradex.com, Geert Uytterhoeven <geert@linux-m68k.org>,
 NXP Linux Team <linux-imx@nxp.com>, linux-input@vger.kernel.org,
 coquelin.stm32@gmail.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Siddartha Mohanadoss <smohanad@codeaurora.org>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Eugen Hristev <eugen.hristev@microchip.com>, shawnguo@kernel.org,
 jic23@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGFrZW4gYWxsIGJ1dCB0aGUgQVJNIHBhdGNoZXMuCgpUaGVzZSBuZWVkIHRvIGJlIHJldmlld2Vk
IGFuZCBnbyBpbiB2aWEgQVJNLVNvQy4KClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21t
aXQgYmZlZmZkMTU1MjgzNzcyYmJlNzhjNmEwNWRlYzdjMDEyOGVlNTAwYzoKCiAgTGludXggNS4w
LXJjMSAoMjAxOS0wMS0wNiAxNzowODoyMCAtMDgwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdp
dCByZXBvc2l0b3J5IGF0OgoKICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvbGVlL21mZC5naXQgaWItbWZkLWlpby1pbnB1dC12NS4xCgpmb3IgeW91IHRvIGZl
dGNoIGNoYW5nZXMgdXAgdG8gODFjZGFiNzk4MTg5ODhkMjdkOGFlYjE2MmI3OTg4YzllNmRkZTkz
NjoKCiAgaWlvOiBhZGM6IGFkZCBTVE1QRSBBREMgZGV2aWNldHJlZSBiaW5kaW5ncyAoMjAxOS0w
MS0xNiAxMjozNzozNiArMDAwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW1tdXRhYmxlIGJyYW5jaCBiZXR3ZWVuIE1G
RCwgSUlPIGFuZCBJbnB1dCBkdWUgZm9yIHRoZSB2NS4xIG1lcmdlIHdpbmRvdwoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpQ
aGlsaXBwZSBTY2hlbmtlciAoMyk6CiAgICAgIGR0LWJpbmRpbmdzOiBzdG1wZTogUmVmb3JtYXR0
aW5nIHBhcmFtZXRlciBsaXN0IGFuZCB1c2UgdGFicyBvbmx5CiAgICAgIG1mZDogc3RtcGU6IE1v
dmUgQURDIHJlbGF0ZWQgZGVmaW5lcyB0byBNRkQgaGVhZGVyCiAgICAgIElucHV0OiBzdG1wZS10
czogcHJlcGFyYXRpb25zIGZvciBTVE1QRSBBREMgZHJpdmVyCgpTdGVmYW4gQWduZXIgKDMpOgog
ICAgICBtZmQ6IHN0bXBlOiBQcmVwYXJhdGlvbnMgZm9yIFNUTVBFIEFEQyBkcml2ZXIKICAgICAg
aWlvOiBhZGM6IGFkZCBTVE1QRSBBREMgZHJpdmVyIHVzaW5nIElJTyBmcmFtZXdvcmsKICAgICAg
aWlvOiBhZGM6IGFkZCBTVE1QRSBBREMgZGV2aWNldHJlZSBiaW5kaW5ncwoKIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2lpby9hZGMvc3RtcGUtYWRjLnR4dCAgICAgIHwgIDIxICsrCiAuLi4vYmlu
ZGluZ3MvaW5wdXQvdG91Y2hzY3JlZW4vc3RtcGUudHh0ICAgICAgICAgICB8IDExNiArKysrKy0t
CiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3N0bXBlLnR4dCAgICB8ICAy
OCArLQogZHJpdmVycy9paW8vYWRjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDcgKwogZHJpdmVycy9paW8vYWRjL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKwogZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jICAgICAgICAgICAgICAgICAg
ICAgICAgfCAzNjMgKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2lucHV0L3RvdWNoc2Ny
ZWVuL3N0bXBlLXRzLmMgICAgICAgICAgICAgICB8ICA2NiArLS0tCiBkcml2ZXJzL21mZC9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQogZHJpdmVycy9tZmQv
c3RtcGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNjggKysrKwogaW5jbHVk
ZS9saW51eC9tZmQvc3RtcGUuaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjEgKysKIDEw
IGZpbGVzIGNoYW5nZWQsIDYxMCBpbnNlcnRpb25zKCspLCA4NCBkZWxldGlvbnMoLSkKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9z
dG1wZS1hZGMudHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9paW8vYWRjL3N0bXBlLWFk
Yy5jCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwg
TGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9s
bG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
