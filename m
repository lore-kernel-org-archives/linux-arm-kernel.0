Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC83C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:40:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD982081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kC6vUYqP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpyDzMaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD982081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GjXfTf5E2RaIDztbeCNNtCQOQOohhQ76AsJrR6aBfms=; b=kC6vUYqPJvUZYq
	oJaXvEUk+B/AQnB9ut1PIIQ4hwBeRamBeg3Wwu1DgDgRvpKaM8E6VskI7qA0+pvhRv3mXincW8PR4
	AVuI3jqS+FoILpg16YbyWkhS7cqwZMQL9QjKQgdKFEQFR4FqyKbDNJuwwQhWVnyC/5aybMbF1LhT5
	NKz9e+wRLpkxoDs+2JJAjJ7/YcgYP7525UqRsZacMBy5wTk7F2EJ1jo2iPRpE530OKG4YU9NJcayJ
	LKfoe1Pr8GPuSfmxfu888z1BF9mdMeArgvR/q9QkOZsATpyo/yeTmXSntHHyk6ZYNk7jkEnHjWAjW
	1ZxyBVwxH4jkGyO+QWDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJAz-0003jW-3r; Fri, 07 Dec 2018 16:40:29 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJAv-0003j5-Sw
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:40:27 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so4388424wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 08:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=YfpuPNStR7Bbh4U1vz1z4scj5aPvsB3ueMLGaS3b+QQ=;
 b=UpyDzMaEEuLoL0duppyiruFPYMHlKdOtyexjk/qoHFkb8HYqKNlxZaj/lKk80Xlp+i
 rZliBEiTYAyMqLFhgDPx9Q/FTznRTc9xWm2U0MGej3iVFiImuL2T4/Lqb05c62VzHrqr
 lB4EIe6CaIPOrMvgPD6AcPip7Q8jH2wjii9aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=YfpuPNStR7Bbh4U1vz1z4scj5aPvsB3ueMLGaS3b+QQ=;
 b=TnsGLhWwIOBEA09dkEU3kEAp9cSXzMnUfURDzK4PWqt6S3mbHtp8nxjPldv6FZnew1
 WcwQD9Gd7gkQHHRHLgIV6XDk+IMshtL//sksZZlmhNcEEB68jaJ7uRP7/aO+40aY2MoT
 ADZDEeyINvVhQVurLXzVOqT5z9vxQx20FB6mi7tIhE2ShdPb8q5Fx+8k9VA7AhAxt8S7
 giTL+2MXUOpb08Hxst1OslLAF9k9MdCgZfkLhaXURz0+fAAB47vxFGpcrOqAU+QRRw9Q
 jU7PrScsfvrve8GTDNYbK+PMGne02UhLhjDbdQ08feYfIyzjQMgUbS/qDAW0nh4iZDof
 HNKA==
X-Gm-Message-State: AA+aEWaV5iOYNBWNE+NpUv7h1TOdBhcT+kJ8A+nqZ8/Km0SYY83p7m7D
 LFB4HeKDYTjjrnR2K49lh9be5g==
X-Google-Smtp-Source: AFSGD/Ua/OsGSsNSJ6wV7LEC0pLEZVCEYLnmp6b/efW4rugFl5Y/QqPn8+/FwVbOfxWqNwrcqG0b0Q==
X-Received: by 2002:adf:e891:: with SMTP id d17mr2589982wrm.140.1544200813980; 
 Fri, 07 Dec 2018 08:40:13 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id x8sm10189697wmd.45.2018.12.07.08.40.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 08:40:13 -0800 (PST)
Date: Fri, 7 Dec 2018 16:40:11 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Oskari Lemmela <oskari@lemmela.net>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181207164011.GI26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181120175211.3913-9-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_084026_162158_587C8B3C 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Quentin Schulz <quentin.schulz@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMCBOb3YgMjAxOCwgT3NrYXJpIExlbW1lbGEgd3JvdGU6Cgo+IFBhcnRzIG9mIHRo
ZSBBWFA4MDMgYXJlIGNvbXBhdGlibGUgd2l0aCB0aGVpciBjb3VudGVycGFydHMgb24gdGhlIEFY
UDgxMy4KPiBUaGVzZSBpbmNsdWRlIHRoZSBHUElPLCBBREMsIEFDIGFuZCBiYXR0ZXJ5IHBvd2Vy
IHN1cHBsaWVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE9za2FyaSBMZW1tZWxhIDxvc2thcmlAbGVt
bWVsYS5uZXQ+Cj4gUmV2aWV3ZWQtYnk6IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz4KPiBU
ZXN0ZWQtYnk6IFZhc2lseSBLaG9ydXpoaWNrIDxhbmFyc291bEBnbWFpbC5jb20+Cj4gLS0tCj4g
IGRyaXZlcnMvbWZkL2F4cDIweC5jIHwgMTUgKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2F4cDIw
eC5jIGIvZHJpdmVycy9tZmQvYXhwMjB4LmMKPiBpbmRleCBkZmMzY2ZmMWQwOGIuLmU0MTViOTY3
ZDM4YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL21mZC9heHAyMHguYwo+ICsrKyBiL2RyaXZlcnMv
bWZkL2F4cDIweC5jCj4gQEAgLTcyOCwxMSArNzI4LDI2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bWZkX2NlbGwgYXhwMjg4X2NlbGxzW10gPSB7Cj4gIAo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG1m
ZF9jZWxsIGF4cDgwM19jZWxsc1tdID0gewo+ICAJewo+ICsJCS5uYW1lCQk9ICJheHAyMHgtZ3Bp
byIsCj4gKwkJLm9mX2NvbXBhdGlibGUJPSAieC1wb3dlcnMsYXhwODEzLWdwaW8iLAo+ICsJfSwg
ewo+ICAJCS5uYW1lCQkJPSAiYXhwMjIxLXBlayIsCj4gIAkJLm51bV9yZXNvdXJjZXMJCT0gQVJS
QVlfU0laRShheHA4MDNfcGVrX3Jlc291cmNlcyksCj4gIAkJLnJlc291cmNlcwkJPSBheHA4MDNf
cGVrX3Jlc291cmNlcywKPiAgCX0sCj4gIAl7CS5uYW1lCQkJPSAiYXhwMjB4LXJlZ3VsYXRvciIg
fSwKPiArCXsKPiArCQkubmFtZQkJPSAiYXhwODEzLWFkYyIsCj4gKwkJLm9mX2NvbXBhdGlibGUJ
PSAieC1wb3dlcnMsYXhwODEzLWFkYyIsCj4gKwl9LCB7Cj4gKwkJLm5hbWUJCT0gImF4cDIweC1i
YXR0ZXJ5LXBvd2VyLXN1cHBseSIsCj4gKwkJLm9mX2NvbXBhdGlibGUJPSAieC1wb3dlcnMsYXhw
ODEzLWJhdHRlcnktcG93ZXItc3VwcGx5IiwKPiArCX0sIHsKPiArCQkubmFtZQkJPSAiYXhwMjB4
LWFjLXBvd2VyLXN1cHBseSIsCj4gKwkJLm9mX2NvbXBhdGlibGUJPSAieC1wb3dlcnMsYXhwODEz
LWFjLXBvd2VyLXN1cHBseSIsCj4gKwkJLm51bV9yZXNvdXJjZXMJPSBBUlJBWV9TSVpFKGF4cDIw
eF9hY19wb3dlcl9zdXBwbHlfcmVzb3VyY2VzKSwKPiArCQkucmVzb3VyY2VzCT0gYXhwMjB4X2Fj
X3Bvd2VyX3N1cHBseV9yZXNvdXJjZXMsCj4gKwl9LAo+ICB9OwoKTXkgT0NELWRhciBpcyBnb2lu
ZyBjcmF6eS4KCldoeSBoYXZlbid0IHlvdSB1c2VkIHRoZSBzYW1lIGFsaWdubWVudCBhcyBpcyBh
bHJlYWR5IHRoZXJlPwoKSWYgaXQgc3RhcnRzIHRvIHJ1biBvdmVyIDgwLWNoYXJzIHRoZW4gYnJp
bmcgdGhlIG90aGVycyBiYWNrLgoKQWxzbyB3aHkgaXMgdGhlcmUgYSBzaW5nbGUgbGluZXIgc2hv
dmVkIGluIHRoZSBtaWRkbGUgb2YgdGhlCm11bHRpLWxpbmUgZW50cmllcz8gIFBsZWFzZSBtb3Zl
IHRoZSBzaW5nbGVzIHRvIHRoZSB0b3Agb3IgdGhlCmJvdHRvbS4KCi0tIApMZWUgSm9uZXMgW+ad
jueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9w
ZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8
IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
