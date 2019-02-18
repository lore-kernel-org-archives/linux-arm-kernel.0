Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0ECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:04:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE8D20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DQK/Ultu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpiz3aAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE8D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UfhI3DioM47lhgGU1E64dX+xAFkxE2NTj90sgnmGVKI=; b=DQK/UltuUYvrAH
	t1QfYTy+8ZTy5CIMoODJ92MasMtFj/Ju6LC98o1r6yvfrm7wnMCEjudwHA02VwPJBFT1XUbYWow1n
	t3uzROToFs4lzQ4Ojl3QOt0qaSJ7OusRRHnu1QRwcJhAW0qzDNCv2SU3jmxBIEUMh0qbdQigNgR55
	QmXZiZQf5w3xAoC7Vh/iSNh040uEmknFfRJkmZoqkTZY5iRZZEIlrTh9BBduvO3bKUib+yYHyqzUA
	zsdBSA2F6Je4x2Fh/Fm+VJOpLj+7OlN8uzgatK9XoPH5SyPsi4iBUHunZZpdHuonHgkzgDLV+Y2XP
	cIGq/+l82K21loG2FdxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvlP0-0002rw-J0; Mon, 18 Feb 2019 16:04:18 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvlOw-0002rc-Ik
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 16:04:16 +0000
Received: by mail-ot1-x343.google.com with SMTP id i5so29039898oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=m+lidQw3+CwGVLVVkUFOmOJusJPLo4FhCDb4zUr+4K4=;
 b=fpiz3aAW8nHDHMJAu6WHVdxOgqunzkE7bf9gkunuHa/BM8tRNKxQRowZ99w5PB4NKV
 cgMi/jSVuK8sdW5HeZdt86IbMsatEX7xf7nag1YsBdiPZggJZk8FiAecR0D2IzVqkWA7
 nSD9Cxy3RDKFd6TPaMM3P033/H5uq5AIXcyGqvLZnzo2rdgg6q7d/MXfZRMUZvmWMnvv
 jyoWcOIgUPyB1XwonfgLFVlQgaUKqZEFGoGtal1nZpksshKqfEKuGgrnT6OB6wHzyCXM
 9gD4TGbDpMbSrUphCG/J5zoAbRYx1SZgVYFQLcw20mP7zklJ7DxRBQw1GkjswOXBsCrI
 eCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=m+lidQw3+CwGVLVVkUFOmOJusJPLo4FhCDb4zUr+4K4=;
 b=KR12i6dlQ0TGS+jV+iq/OUYQc6HRPNkd16S8v1NJdwhfTJkyoA8aOUGpj3SE1WW3Vw
 xciqxH3HzG3ZHlHIvLS/PnGiKVW7plS2HHceLNC00Vr2FeBJpnxRcBk9gVSYQEDf1QU9
 1AG2cBHKXSY0/+731Rw55pn0c3ZcGd9tBCt9CuVHsRoolOhAa2f0Cx4euYnLJfDsh7J3
 NYC6LbsBZI+bhMdyXWMrHen9Z2k7on5eX5W5mGnwhkgeQGOqEznMYL++xgunesGQfXZ1
 JvahubDKZgOqD+yjEGg+fE6W2Bk6OPmPYjfJWaD+o6Sy17U2SvKAPIQdD8ou8kcgFOhb
 OW7w==
X-Gm-Message-State: AHQUAuagdxSWcPZozcXZxQiZCDGDYD4Q1OQCXJ2B1zxa2LFTa4rkciF4
 23IS4ORWqV+4JJ07Y8X2SYWcWJn1TCQ/4nfld57I7A==
X-Google-Smtp-Source: AHgI3Ibe3FvpE2nMhR/pmTjFU7Ghac0QgtFhBCfHVPTEU9Oe8rO/Tq2OD8kLthLdSyCea0wWkivfU/rQy10PK3qO0f8=
X-Received: by 2002:aca:d509:: with SMTP id m9mr13940235oig.64.1550505853166; 
 Mon, 18 Feb 2019 08:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20190128142313.17036-1-benjamin.gaignard@st.com>
 <20190128142313.17036-2-benjamin.gaignard@st.com>
In-Reply-To: <20190128142313.17036-2-benjamin.gaignard@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 18 Feb 2019 17:04:02 +0100
Message-ID: <CA+M3ks4S3y9=VvAu1Vah9crd-g_Ri3T4szS-FkwiNP6rfXqO1g@mail.gmail.com>
Subject: Re: [RFC v2 1/7] devicetree: bindings: Document domains controller
 bindings
To: Benjamin Gaignard <benjamin.gaignard@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_080414_625429_A94B5CC7 
X-CRM114-Status: GOOD (  19.17  )
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
Cc: Rob Herring <robh@kernel.org>, Loic PALLARDY <loic.pallardy@st.com>,
 Arnd Bergmann <arnd@arndb.de>, s.hauer@pengutronix.de,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-imx@nxp.com, kernel@pengutronix.de,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgbHVuLiAyOCBqYW52LiAyMDE5IMOgIDE1OjIzLCBCZW5qYW1pbiBHYWlnbmFyZAo8YmVuamFt
aW4uZ2FpZ25hcmRAc3QuY29tPiBhIMOpY3JpdCA6Cj4KPiBEb2N1bWVudCBjb21tb25zIGRvbWFp
bnMgY29udHJvbGxlciBiaW5kaW5ncyBmb3IgY29udHJvbGxlcgo+IGFuZCBjbGllbnQgZGV2aWNl
cy4KCkdlbnRsZSBwaW5nIHRvIGdldCBjb21tZW50cyBvbiB0aG9zZSBiaW5kaW5ncywKClRoYW5r
cywKQmVuamFtaW4KPgo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1p
bi5nYWlnbmFyZEBzdC5jb20+Cj4gLS0tCj4gdmVyc2lvbiAyOgo+IC0gY29tcGxldGUgcmV3b3Jr
IG9mIGJpbmRpbmdzIGRlc2NyaXB0aW9uIHRvIHRyeSB0byBnaXZlIGEgYmV0dGVyIGRlZmluaXRp
b24KPiAgIG9mIHdoYXQgYnVzIGRvbWFpbnMgY291bGQgYmUuCj4gIC4uLi9iaW5kaW5ncy9idXMv
ZG9tYWlucy9kb21haW5zY3RybC50eHQgICAgICAgICAgIHwgNTUgKysrKysrKysrKysrKysrKysr
KysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2J1cy9kb21haW5zL2RvbWFp
bnNjdHJsLnR4dAo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9idXMvZG9tYWlucy9kb21haW5zY3RybC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYnVzL2RvbWFpbnMvZG9tYWluc2N0cmwudHh0Cj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLmEzZmNlZDkxODQyZAo+IC0tLSAvZGV2L251bGwK
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYnVzL2RvbWFpbnMvZG9t
YWluc2N0cmwudHh0Cj4gQEAgLTAsMCArMSw1NSBAQAo+ICtDb21tb24gRG9tYWlucyBDb250cm9s
bGVyIGJpbmRpbmdzIHByb3BlcnRpZXMKPiArCj4gK0J1cyBkb21haW5zIGNvbnRyb2xsZXJzIGFs
bG93IHRvIGRpdmlkZWQgc3lzdGVtIG9uIGNoaXAgaW50byBtdWx0aXBsZSBkb21haW5zCj4gK3Ro
YXQgY2FuIGJlIHVzZWQgdG8gc2VsZWN0IGJ5IHdobyBoYXJkd2FyZSBibG9ja3MgY291bGQgYmUg
YWNjZXNzZWQuCj4gK0EgZG9tYWluIGNvdWxkIGJlIGEgY2x1c3RlciBvZiBDUFVzIChvciBjb3By
b2Nlc3NvcnMpLCBhIHJhbmdlIG9mIGFkZHJlc3NlcyBvcgo+ICthIGdyb3VwIG9mIGhhcmR3YXJl
IGJsb2Nrcy4KPiArCj4gK1RoaXMgZGV2aWNlIHRyZWUgYmluZGluZ3MgY2FuIGJlIHVzZWQgdG8g
YmluZCBidXMgZG9tYWluIGNvbnN1bWVyIGRldmljZXMgd2l0aAo+ICt0aGVpciBidXMgZG9tYWlu
cyBwcm92aWRlZCBieSBidXMgZG9tYWlucyBjb250cm9sbGVycy4gQSBidXMgZG9tYWluIHByb3Zp
ZGVyCj4gK2NhbiBiZSByZXByZXNlbnRlZCBieSBhbnkgbm9kZSBpbiB0aGUgZGV2aWNlIHRyZWUg
YW5kIGNhbiBwcm92aWRlIG9uZSBvciBtb3JlCj4gK2J1cyBkb21haW5zLiBBIGNvbnN1bWVyIG5v
ZGUgY2FuIHJlZmVyIHRvIHRoZSBwcm92aWRlciBieSBhIHBoYW5kbGUgYW5kIGEgc2V0Cj4gK29m
IHBoYW5kbGUgYXJndW1lbnRzIG9mIGxlbmd0aCBzcGVjaWZpZWQgYnkgdGhlICNkb21haW5jdHJs
LWNlbGxzIHByb3BlcnR5IGluCj4gK3RoZSBidXMgZG9tYWluIHByb3ZpZGVyIG5vZGUuCj4gKwo+
ICs9PUJ1cyBkb21haW4gcHJvdmlkZXI9PQo+ICsKPiArUmVxdWlyZWQgcHJvcGVydGllczoKPiAr
LSAjZG9tYWluY3RybC1jZWxscyAgICA6IE51bWJlciBvZiBjZWxscyBpbiBhIGJ1cyBkb21haW4g
c3BlY2lmaWVyOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgQ2FuIGJlIGFueSB2YWx1ZSBh
cyBzcGVjaWZpZWQgYnkgZGV2aWNlIHRyZWUgYmluZGluZwo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgZG9jdW1lbnRhdGlvbiBvZiBhIHBhcnRpY3VsYXIgcHJvdmlkZXIuCj4gKwo+ICs9PUJ1
cyBkb21haW4gY29uc3VtZXI9PQo+ICsKPiArUmVxdWlyZWQgcHJvcGVydGllczoKPiArLSBkb21h
aW5zY3RybC1YICAgICAgICAgICAgICAgIDogQSBsaXN0IG9mIGJ1cyBkb21haW4gc3BlY2lmaWVy
cywgYXMgZGVmaW5lZCBieQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgYmluZGluZ3Mgb2Yg
dGhlIGJ1cyBkb21haW4gY29udHJvbGxlciB0aGF0IGlzIHRoZQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgYnVzIGRvbWFpbiBwcm92aWRlci4KPiArCj4gK09wdGlvbmFsIHByb3BlcnRpZXM6
Cj4gKy0gZG9tYWluc2N0cmwtbmFtZXMgICAgOiBBIGxpc3Qgb2YgYnVzIGRvbWFpbiBuYW1lIHN0
cmluZyBzb3J0ZWQgaW4gdGhlIHNhbWUKPiArICAgICAgICAgICAgICAgICAgICAgICAgIG9yZGVy
IGFzIHRoZSBkb21haW5zY3RybC1YIHByb3ByZXJ0aWVzLiBDb25zdW1lcgo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgZHJpdmVycyB3aWxsIHVzZSBkb21haW5zY3RybC1uYW1lcyB0byBtYXRj
aCBidXMKPiArICAgICAgICAgICAgICAgICAgICAgICAgIGRvbWFpbnMgd2l0aCBidXMgZG9tYWlu
cyBzcGVjaWZpZXJzLgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgTm90ZSB0aGF0ICJkZWZh
dWx0IiBhbmQgInVuYmluZCIgYXJlIHJlc2VydmVkIG5hbWVzCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICB1c2VkIGJ5IHRoZSBmcmFtZXdvcmsuCj4gKwo+ICtFeGFtcGxlIG9mIHVzYWdlIHdp
dGg6Cj4gKy0gYSBkb21haW5zIGNvbnRyb2xsZXIgd2l0aCBhIDIgcGFyYW1ldGVycyBjZWxsCj4g
Ky0gYSBkb21haW5zIGNvbnRyb2xsZXIgd2l0aCBhIDMgcGFyYW1ldGVycyBjZWxsCj4gKy0gYSBj
bGllbnQgZGV2aWNlIG5vZGUgdXNpbmcgdGhlIGJvdGggY29udHJvbGxlcnMgYW5kIDIgY29uZmln
dXJhdGlvbnMKPiArICBuYW1lZCAiZGVmYXVsdCIgYW5kICJ1bmJpbmQiCj4gKwo+ICtjdHJsMDog
Y3RybEAwIHsKPiArICAgICAgICNkb21haW5jdHJsLWNlbGxzID0gPDI+Owo+ICt9Owo+ICsKPiAr
Y3RybDE6IGN0cmxAMSB7Cj4gKyAgICAgICAjZG9tYWluY3RybC1jZWxscyA9IDwzPjsKPiArfTsK
PiArCj4gK2Zvb0AwIHsKPiArICAgICAgIGRvbWFpbnMtbmFtZXMgPSAiZGVmYXVsdCIsICJ1bmJp
bmQiOwo+ICsgICAgICAgZG9tYWluY3RybC0wID0gPCZjdHJsMCAxIDI+LCA8JmN0cmwxIDMgNCA1
PjsKPiArICAgICAgIGRvbWFpbmN0cmwtMSA9IDwmY3RybDAgNiA3PiwgPCZjdHJsMSA4IDkgMD47
Cj4gK307Cj4gLS0KPiAyLjE1LjAKPgoKCi0tIApCZW5qYW1pbiBHYWlnbmFyZAoKR3JhcGhpYyBT
dHVkeSBHcm91cAoKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBT
b0NzCgpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
