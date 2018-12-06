Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC2FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:59:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AF820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KlWO2rI4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZBSBaHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AF820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K+GTUxoSy8ttAf1UlXO7CpMVVzbRQrAlnzA9GeeuMHI=; b=KlWO2rI4wbWvg/
	RpTeyk+LiWWcuWbvczu/11W8ANnzfyTevvyTyD3WtWqHqgGAGUhKovm4b/7G7hVR28C1XZJiUOp6a
	X3syAE9x3CzHhKZilqzs9fo+Whr63tlTFfvulixb+kIHBmT4nQcIyyEww/FbIoLxapBWEKlsWVYza
	UfkoBW9d5AyNM5dGTQRinOEpnegX5Y8GJeq3RcTzG2U/6N7jHns/TJPdc9KsgXqBb9kOdD/qA7zaB
	gCf1bbfWtSB2A1GWoYgj0sjCHzZh0jW6BrORdgNqAtm92hc9E2ZWs4PqHphFHCCAdtFXMgNzbEMKk
	48DQ7yUDfakr2Zi/mcRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqRi-0005XI-6p; Thu, 06 Dec 2018 09:59:50 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqRe-0005Vu-Th
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:59:48 +0000
Received: by mail-ot1-x341.google.com with SMTP id 81so21500129otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 01:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7LEJEujb6GyN4xuQXSs5pit1CSJln1G0tHvlP+Qf5bQ=;
 b=QZBSBaHVk34qUZcwtGyiNKBHH+Bzfw/R2PXy0SA3dcHRSY0HYhA8ii1chnpUP+nCVC
 jS9ZTzrKvgqrw6MWvMJcrmoE/T8MYX4H+FcLyOikzyY6lZ9TueGHak0xMzY1LF3R5EY1
 fiCT42iLgw/WpLx4MZUsHN3Z6DyiQybWyyMgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7LEJEujb6GyN4xuQXSs5pit1CSJln1G0tHvlP+Qf5bQ=;
 b=pZtNc31ZH60H9nmtZoD9PXtCM+rigkppOXRJ55gZMACqlyLy4ngwtiNhZoZtyvq7JZ
 9osYlhKevGep/6f9VwqI+GoY6yiLFzmVVyYVebAUCc+yJnXg00kRVzrUCfauSjIpjSPZ
 iFLQOFIHwcFMq3zVdrGiuk6NJajWyiYJOzedYTHiYVVCmS8WatQzcLRFi5EX3+OqexdU
 FwxbgWs5UIsj4jE5VWzTgx5uXDu13j8J+3T+3XT7+1wjQVMrNPbYhZceQt3TW+G+airY
 G+ju+8lNJYFnykR28Mahqc2nHvgbsaR2mZYNC91qXVvKbZChvqd9W3aRbZd9m7X4o5hn
 oGhQ==
X-Gm-Message-State: AA+aEWZpfItDKR97aBALCTiM+GhmPNaIF8WJxYXlg/8Iw2Dyfsd3NagY
 9qZcccPh12UDU1UTbd0SB56Doqh5xru7bsEoR8k/XQ==
X-Google-Smtp-Source: AFSGD/UYBU+Lx580vsBsUV31//DE6lTVtGrexolu87rXO2viopjNqlRDplZ2HAsNKjClsh+OhM2h8DtyEDll29BiyvU=
X-Received: by 2002:a9d:72e:: with SMTP id 43mr18299579ote.207.1544090376005; 
 Thu, 06 Dec 2018 01:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
 <20181114090027.7580-4-benjamin.gaignard@linaro.org>
In-Reply-To: <20181114090027.7580-4-benjamin.gaignard@linaro.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 6 Dec 2018 10:59:25 +0100
Message-ID: <CA+M3ks6Qk9rjnBHUkPRT8KNnBaG-wBAMOQek0Du39OhYYoDUfg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ARM: dts: stm32: Add hwspinlock node for
 stm32mp157 SoC
To: Ohad Ben Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandre Torgue <alexandre.torgue@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_015946_956522_155D3524 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: devicetree@vger.kernel.org, Benjamin GAIGNARD <benjamin.gaignard@st.com>,
 linux-remoteproc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgbWVyLiAxNCBub3YuIDIwMTggw6AgMTA6MDAsIEJlbmphbWluIEdhaWduYXJkCjxiZW5qYW1p
bi5nYWlnbmFyZEBsaW5hcm8ub3JnPiBhIMOpY3JpdCA6Cj4KPiBGcm9tOiBCZW5qYW1pbiBHYWln
bmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPgo+Cj4gRGVjbGFyZSBod3NwaW5sb2NrIGRl
dmljZSBmb3Igc3RtMzJtcDE1NyBTb0MKCkkgYWJhbmRvbiB0aGlzIHBhdGNoIGFuZCBJIHdpbGwg
c2VuZCBhIG9uZSB0aGF0IGZpeGVzIHRoZSBpc3N1ZXMuCgo+Cj4gU2lnbmVkLW9mZi1ieTogQmVu
amFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAbGluYXJvLm9yZz4KPiAtLS0K
PiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaSB8IDkgKysrKysrKysrCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9zdG0zMm1wMTU3Yy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2Mu
ZHRzaQo+IGluZGV4IDE4NTU0MWE1YjY5Zi4uOThmODI0ZDhiMGYwIDEwMDY0NAo+IC0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kKPiArKysgYi9hcmNoL2FybS9ib290L2R0
cy9zdG0zMm1wMTU3Yy5kdHNpCj4gQEAgLTgwMyw2ICs4MDMsMTUgQEAKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ICAgICAgICAgICAgICAgICB9Owo+Cj4g
KyAgICAgICAgICAgICAgIGhzZW06IGh3c3BpbmxvY2tANGMwMDAwMDAgewo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic3Qsc3RtMzItaHdzcGlubG9jayI7Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgI2h3bG9jay1jZWxscyA9IDwxPjsKPiArICAgICAgICAgICAgICAg
ICAgICAgICByZWcgPSA8MHg0YzAwMDAwMCAweDQwMD47Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgY2xvY2tzID0gPCZyY2MgSFNFTT47Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2st
bmFtZXMgPSAiaHdzZW0iOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNh
YmxlZCI7Cj4gKyAgICAgICAgICAgICAgIH07Cj4gKwo+ICAgICAgICAgICAgICAgICByY2M6IHJj
Y0A1MDAwMDAwMCB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzdCxz
dG0zMm1wMS1yY2MiLCAic3lzY29uIjsKPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8
MHg1MDAwMDAwMCAweDEwMDA+Owo+IC0tCj4gMi4xNS4wCj4KCgotLSAKQmVuamFtaW4gR2FpZ25h
cmQKCkdyYXBoaWMgU3R1ZHkgR3JvdXAKCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3
YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxv
ZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
