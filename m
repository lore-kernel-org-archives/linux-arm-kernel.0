Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FF7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:34:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A727820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="awCcUTRX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i9lhClr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A727820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gKkiWp4NZQKbfVSQ9z6DGZ8cvFN2i4Szuz6KMiBbUNI=; b=awCcUTRXZN9Vqu
	Ski79YJm4hXKcWXIqQZjIaKRif217blkYMfGBbdxCL8uuVBbOJyW1Tzy5N7lfiGhLU+NvvSbmNy6I
	igxfFpRGDfc3uy43Y1wQ07g4RKBq9gjMdHNN4yu8x8bH0oM+TXgHfEdl1qZErejCw+8kO0UZASn8E
	eFOBB2kKonvxdjSwCR/BOdxUobtC2hYznyYL5riHYVII/MEozQRd/CKsFqRCbddrTxeuwEDKMyYOI
	LQjo1Qk0o6P9yvn2UN6RPUMRXQ47pV/uKO5O/L4yJwmAM4fpwTTYrFmpVTI7WfUE9LTPvwBpZLmaT
	AaavUORtrx+4HkeOARhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grLTh-0006j6-5e; Wed, 06 Feb 2019 11:34:53 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grLTd-0006hW-6H
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 11:34:51 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16BYbXN089888;
 Wed, 6 Feb 2019 05:34:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549452877;
 bh=A3SlfqwDsSin2UfoGkUIwUwN5IRNzbEGbr1y5gu3qDg=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=i9lhClr+SQTmJ/3G4QblHePdOGAjBLgX40kJU/reztnwYJom0sdtVenzl+g/xlrgy
 pGu6Tf0a01vAkGq8UWaZCGPqrPa3theRSa5wcpNc9BMXJwsZNzjo3JeSQ5Sf7eZie/
 fsQLoeC4gLcNIfCPt+efar/rwDk8r9putvEGkwIs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16BYbwG130276
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Feb 2019 05:34:37 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:34:36 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:34:36 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16BYWfl018035;
 Wed, 6 Feb 2019 05:34:33 -0600
Subject: Re: [PATCH v5 0/6] A3700 USB UTMI PHY support
To: Miquel Raynal <miquel.raynal@bootlin.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Gregory Clement
 <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew
 Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>
References: <20190129093635.4321-1-miquel.raynal@bootlin.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <058b1b83-255f-5301-29f2-b32d69043260@ti.com>
Date: Wed, 6 Feb 2019 17:04:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129093635.4321-1-miquel.raynal@bootlin.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_033449_306117_F55E160A 
X-CRM114-Status: GOOD (  26.92  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAyOS8wMS8xOSAzOjA2IFBNLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+IFVTQjIgb24gQTM3
MDAgb25seSB3b3JrcyBiZWNhdXNlIFUtQm9vdCBpbml0aWFsaXplcyB0aGUgVVRNSSBQSFlzIChv
bmUKPiB3aXJlZCB0byBlYWNoIFVTQiBjb250cm9sbGVyKS4gV2hpbGUgdGhlcmUgaXMgbm8gaXNz
dWUgd2l0aCByZWd1bGFyCj4gdXNlLCB0aGlzIGFyY2hpdGVjdHVyZSBkb2VzIG5vdCBhbGxvdyBz
dXNwZW5kIHRvIFJBTSB0byB3b3JrIGFzIHRoZQo+IFBIWXMgbXVzdCBiZSByZS1pbml0aWFsaXpl
ZCBhdCByZXN1bWUuIEluIG9yZGVyIHRvIHN1cHBvcnQgdGhpcwo+IGZlYXR1cmUsIHRoaXMgc2Vy
aWVzIGFkZHMgYSBVVE1JIFBIWSBkcml2ZXIgZm9yIHRoZSBBMzcwMCBTb0MuCj4gCj4gVGhlIEEz
NzAwIGRldmljZSB0cmVlIGlzIHVwZGF0ZWQgdG8gcmVmZXJlbmNlIHRoZSBQSFlzLgoKbWVyZ2Vk
IHRoZSBQSFkgcGF0Y2hlcy4KClRoYW5rcwpLaXNob24KPiAKPiBUaGFua3MsCj4gTWlxdcOobAo+
IAo+IENoYW5nZXMgc2luY2UgdjQ6Cj4gPT09PT09PT09PT09PT09PT0KPiAqIERyb3AgVVNCIHBh
dGNoZXMgYXMgdGhleSBoYXZlIGJlZW4gc2VudCBpbiBhIHNlcGFyYXRlIHNlcmllcy4gTm8KPiAg
IHJlYWwgZnVuY3Rpb25hbCBjaGFuZ2VzIHNpbmNlIHRoZSB2NCB0aG91Z2gsIGtpbmQgb2YgYSBy
ZXNlbmQgb2YgdGhlCj4gICBQSFkgcGF0Y2hlcyBmcm9tIHRoZSAiQTM3MDAgVVNCIFMyUkFNIHN1
cHBvcnQiIHNlcmllcy4KPiAKPiBDaGFuZ2VzIHNpbmNlIHYzOgo+ID09PT09PT09PT09PT09PT09
Cj4gKiBCaW5kaW5nczogYXMgc3VnZ2VzdGVkIGJ5IEdyZWdvcnkgYW5kIFJvYiwgdXNlZCB0aGUg
Ii1taXNjIiBzdWZmaXgKPiAgIGluc3RlYWQgb2YgIi1taXNjZWxsYW5lb3VzIiBhbmQgcHJlZml4
ZWQgdGhlIGNvbXBhdGlibGUgd2l0aAo+ICAgImFybWFkYS0zNzAwIiB0byBmb2xsb3cgd2hhdCBo
YXMgYmVlbiB1c2VkIGZvciB0aGUgb3RoZXIgSVBzIG9mIHRoZQo+ICAgc2FtZSBTb0MgKGFuZCBh
ZGRlZCBSb2IncyBhY2spLgo+IAo+IENoYW5nZXMgc2luY2UgdjI6Cj4gPT09PT09PT09PT09PT09
PT0KPiAqIFR5cG9zCj4gKiBVVE1JIFBIWSBiaW5kaW5nczoKPiAgID4gTmV3IG5hbWUgZm9yIHRo
ZSBVU0IyIGhvc3QvUEhZIHN5c2NvbnMgKCsgY2hhbmdlcyBpbiB0aGUgRFQpLgo+ICAgPiBDbGVh
cmx5IHN0YXRlIHRoYXQgdGhlIFBIWXMgYXJlIGRpZmZlcmVudCBiZXR3ZWVuIE9URyBhbmQKPiAg
ICAgaG9zdC1vbmx5IGNvbnRyb2xsZXJzLgo+ICogVVRNSSBQSFkgZHJpdmVyOgo+ICAgPiBVc2Ug
R0VOTUFTSyBtYWNyby4KPiAgID4gUmVtb3ZlZCB1c2VsZXNzIGNoZWNrcyBvbiBkcml2ZXIgZGF0
YSByZXRyaWV2YWwuCj4gICA+IERyb3BwZWQgdGhlIGVtcHR5IC0+cmVtb3ZlKCkgaG9vay4KPiAg
ID4gVXBkYXRlZCB0aGUgbGljZW5jZSBtYWNybyB0byBtYXRjaCB0aGUgU1BEWCB0YWcuCj4gICA+
IFVzZWQgdGhlIG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgpIGhlbHBlci4KPiAgID4gUmVtb3Zl
ZCB0aGUgdXNlIG9mIGEgbG9jYWwgdmFyaWFibGUgaW4gdGhlIC0+cHJvYmUoKSBmb3IgdGhlCj4g
ICAgIGRyaXZlcidzIG9wZXJhdGlvbnMuCj4gICA+IEZpeGVkIHRoZSBkcml2ZXIgY28tYXV0aG9y
OiBJZ2FsLCBub3QgRXZhbi4KPiAKPiBDaGFuZ2VzIHNpbmNlIHYxOgo+ID09PT09PT09PT09PT09
PT09Cj4gKiBBZGQgVVRNSSBQSFkgZHJpdmVyL2JpbmRpbmdzL0RUIGNoYW5nZXMgdG8gYnJpbmcg
UzJSQU0gc3VwcG9ydCB0bwo+ICAgYm90aCBVU0IgcG9ydHMgYXZhaWxhYmxlIG9uIHRoZSBBMzcw
MCBTb0MuCj4gKiBSZWJhc2VkIG9uIHRvcCBvZiB2NS4wLXJjMS4KPiAKPiAKPiBNaXF1ZWwgUmF5
bmFsICg2KToKPiAgIHBoeTogYWRkIEEzNzAwIFVUTUkgUEhZIGRyaXZlcgo+ICAgZHQtYmluZGlu
Z3M6IHBoeTogbXZlYnUtdXRtaTogYWRkIFVUTUkgUEhZIGJpbmRpbmdzCj4gICBNQUlOVEFJTkVS
UzogcGh5OiBmaWxsIEFybWFkYSAzNzAwIFBIWSBkcml2ZXJzIGVudHJ5Cj4gICBBUk02NDogZHRz
OiBtYXJ2ZWxsOiBhcm1hZGEtMzd4eDogZml4IFVTQjIgbWVtb3J5IHJlZ2lvbgo+ICAgQVJNNjQ6
IGR0czogbWFydmVsbDogYXJtYWRhLTM3eHg6IGRlY2xhcmUgVVNCMiBVVE1JIFBIWXMKPiAgIEFS
TTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBsaW5rIFVTQiBob3N0cyB3aXRoIHRoZWly
IFBIWXMKPiAKPiAgLi4uL2JpbmRpbmdzL3BoeS9waHktbXZlYnUtdXRtaS50eHQgICAgICAgICAg
IHwgIDM4ICsrKwo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDQgKy0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zN3h4LmR0
c2kgIHwgIDM0ICsrLQo+ICBkcml2ZXJzL3BoeS9tYXJ2ZWxsL0tjb25maWcgICAgICAgICAgICAg
ICAgICAgfCAgIDkgKwo+ICBkcml2ZXJzL3BoeS9tYXJ2ZWxsL01ha2VmaWxlICAgICAgICAgICAg
ICAgICAgfCAgIDEgKwo+ICBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1hMzcwMC11dG1p
LmMgICAgfCAyNzggKysrKysrKysrKysrKysrKysrCj4gIDYgZmlsZXMgY2hhbmdlZCwgMzYyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdmVidS11dG1pLnR4dAo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtYTM3MDAtdXRtaS5j
Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
