Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E00C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:44:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3AF2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IBxWhil3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFfVKaHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3AF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q4dGnXwAEibuonnvW20AmnedDVHbN7+IWIXU4bPSpxU=; b=IBxWhil3L0GF5Z
	wJa0YSBorRPSB7GwHXTEXPltkP9yJz2cw5ADoexpwr2jJAWIdYENGlFCWBofWZeM+USUD7bSIcQgx
	1zIke5IYCZQ7X29Dnm1Dnw6fz3xFXs/MFdhKxpiBst9YeLsjNVWNJYj3pyBkMK9/nczzspH9RomD3
	yR+DXbO8Jz5iaXvTll+XRgRsC0GWdzLopnLoqMdL1O26CdEMWdGwEVBzNdxycyxHY2IipYvURzjas
	iL/zTmANn1+2UN/gNBzLDDjXXRbLgl56eVqvr/RH+hFLGNZ7R8vrvqPiXytrAdoLy8ZOv/xADxHLx
	AT0eSipQOP0ep0kOpooQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdvzz-0002jq-9G; Mon, 31 Dec 2018 11:44:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdvzw-0002jU-4Z
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 11:44:45 +0000
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74A01218A1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546256683;
 bh=KtbHy2NcN9vE1DB4rHXVdpM8ttC1Xu7qdVEPrBBIaD8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EFfVKaHctd6UiV7OvDnomHb9KGhS/a5uYdWyE1pw28t8KJrpn+wDTIIIau+Dftxfk
 b3biAnZlu/jSTlnJcboOKSx2fHRmhN+tiE+YrTA4Q5QQ5IQGXFnvy8OXdUJ0239Z25
 BFtnnEVnrTmdFNlAb01hGHlNhufePxkPZ62MCzjE=
Received: by mail-lj1-f177.google.com with SMTP id l15-v6so23442211lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 03:44:43 -0800 (PST)
X-Gm-Message-State: AJcUukeuWqhj9Ztl+Bb7O1SufjS6t1ejraHVMitsQgZzouEY9SQybOFo
 TRNmZKl9pqQvkdgF0ZEPsDUYGVPZsfQWnizU1Yc=
X-Google-Smtp-Source: ALg8bN5VSAr3Zw9Le0NspEtRgdIgX7F19JSX6+66G2elsSz+QAN3uLMz0tu3PJ4OEMai3X7KQlovHMSHUItjWXWodrc=
X-Received: by 2002:a2e:6503:: with SMTP id
 z3-v6mr20430411ljb.153.1546256681550; 
 Mon, 31 Dec 2018 03:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-5-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228161819.18931-5-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 31 Dec 2018 12:44:30 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdWt1A=RPzzbv+DBJj6z1gUPF3OofGthYeyOCYcCiYwAQ@mail.gmail.com>
Message-ID: <CAJKOXPdWt1A=RPzzbv+DBJj6z1gUPF3OofGthYeyOCYcCiYwAQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: s5pv210: aries: Add reserved memory for mfc
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_034444_215483_E3931137 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 xc-racer2@live.ca, linux@armlinux.org.uk, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyOCBEZWMgMjAxOCBhdCAxNzoxOCwgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoaXMgY29tbWl0IGFkZHMgbWVtb3J5IHJl
c2VydmF0aW9uIHJlcXVpcmVkIGJ5IE1GQyB0byBydW4uCj4gT24gUzVQVjIxMCBib3RoIHJlZ2lv
bnMgbmVlZHMgdG8gYmUgb24gc2VwYXJhdGUgbWVtb3J5IGJhbmtzLgo+IFNpemUgb2YgYm90aCBy
ZWdpb25zIGlzIHRha2VuIGZyb20gc3RvY2sgc291cmNlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFBh
d2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiAtLS0KPiAgYXJj
aC9hcm0vYm9vdC9kdHMvczVwdjIxMC1hcmllcy5kdHNpIHwgMjIgKysrKysrKysrKysrKysrKysr
KysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRz
L3M1cHYyMTAtYXJpZXMuZHRzaQo+IGluZGV4IDU3NTA5NGVhNzAyNC4uMzViYTAwOWExYTMzIDEw
MDY0NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaQo+ICsrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaQo+IEBAIC0yMyw2ICsyMywyNCBA
QAo+ICAgICAgICAgICAgICAgICAgICAgICAgIDB4NTAwMDAwMDAgMHgwODAwMDAwMD47Cj4gICAg
ICAgICB9Owo+Cj4gKyAgICAgICByZXNlcnZlZC1tZW1vcnkgewo+ICsgICAgICAgICAgICAgICAj
YWRkcmVzcy1jZWxscyA9IDwxPjsKPiArICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47
Cj4gKyAgICAgICAgICAgICAgIHJhbmdlczsKPiArCj4gKyAgICAgICAgICAgICAgIG1mY19sZWZ0
OiByZWdpb25fbWZjX2xlZnRANDMwMDAwMDAgewoKQWx0aG91Z2ggeW91IHVzZWQgdGhlIHNhbWUg
bmFtaW5nIGNvbnZlbnRpb24gYXMgZXhpc3RpbmcKZXh5bm9zLW1mYy1yZXNlcnZlZC1tZW1vcnku
ZHRzaSwgdGhlIG5hbWUgb2Ygbm9kZXMgc2hvdWxkIGJlIGdlbmVyaWMsCnNvOgptZmNfbGVmdDog
cmVnaW9uQDQzMDAwMDAwCgpCZXN0IHJlZ2FyZHMsCktyenlzenRvZgoKCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIG5vLW1hcDsKPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHg0
MzAwMDAwMCAweDIwMDAwMDA+Owo+ICsgICAgICAgICAgICAgICB9Owo+ICsKPiArICAgICAgICAg
ICAgICAgbWZjX3JpZ2h0OiByZWdpb25fbWZjX3JpZ2h0QDUxMDAwMDAwIHsKPiArICAgICAgICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNoYXJlZC1kbWEtcG9vbCI7Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgbm8tbWFwOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
eDUxMDAwMDAwIDB4MjAwMDAwMD47Cj4gKyAgICAgICAgICAgICAgIH07Cj4gKyAgICAgICB9Owo+
ICsKPiAgICAgICAgIHdpZmlfcHdyc2VxOiB3aWZpLXB3cnNlcSB7Cj4gICAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAibW1jLXB3cnNlcS1zaW1wbGUiOwo+ICAgICAgICAgICAgICAgICByZXNl
dC1ncGlvcyA9IDwmZ3BnMSAyIEdQSU9fQUNUSVZFX0xPVz47Cj4gQEAgLTMyOSw2ICszNDcsMTAg
QEAKPiAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsKPiAgfTsKPgo+ICsmbWZjIHsKPiArICAgICAg
IG1lbW9yeS1yZWdpb24gPSA8Jm1mY19sZWZ0PiwgPCZtZmNfcmlnaHQ+Owo+ICt9Owo+ICsKPiAg
JnBpbmN0cmwwIHsKPiAgICAgICAgIHdsYW5fYnRfZW46IHdsYW4tYnQtZW4gewo+ICAgICAgICAg
ICAgICAgICBzYW1zdW5nLHBpbnMgPSAiZ3BiLTUiOwo+IC0tCj4gMi4xNy4xCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
