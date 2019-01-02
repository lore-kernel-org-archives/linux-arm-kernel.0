Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1048BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:28:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF2C218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RVtNQFok";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzdtyI56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF2C218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rkWFT73qZDHlz5MZyUkKUYOl7tkUeTG8SYDShb4mWPs=; b=RVtNQFoklJGcG2
	6Ob36v4+r7xiVvrAHWOA3p9eC9eA7j/E+cN+k3Xrd2+XdbQlaAf3VgNiII2Jzipdy+4rn8CMuDqSM
	VMmvM6xWBa4bg/PDRP0JnmULwOT0CERtJzjfYZSrU+iHjsw7L5/kOz6EOW8NxDoaLQMpMZVHv7kuv
	loaximMQ/AKwHxbFpum9cHMqBLxEM1KEUoSo3oyUDri2pngbG6hH6jhsI1VoruTRj985Lba6IcNM4
	V/6/8ATmtvs5c2q2TUKWPieRHsjs5Swol9ijVs6QgkmuvxpT+7c6SGHZ4hd2jBYMRSXG53n5r6fad
	jvlSEYvHzFrhrFjFju0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gelFi-0005rK-TZ; Wed, 02 Jan 2019 18:28:26 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gelFg-0005qg-44
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 18:28:25 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so31367762wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gMhKoB56fl1CENDGxaDFPrqlt7cUUK874k7xw397NdU=;
 b=JzdtyI56NkMTgEJWWUI7nVrrdM4ObN36HtPjzfrSSjcdqdR9Gtl9t/46owiSX02KfJ
 wude1FNPPx52lUIBO6Mj1WbUQ7dn1GEkoUAWSBE0ruGW/AYS1ZdrVE4WEG+cjM3s9gDR
 POqYiDhxqJkxRfi/ZQiGRyw+4M3gWrbKCVED24XGoMjWdIchuBU3I7Qy08q7YX29sIRl
 C45vCtxvK5eXALv38zLCau929LZIPSi7uRWZXAZqMmFxcagAMxgyR+2mO7MegAWSvLAk
 kG2L+cFubVPh+1r7Unm9pPfxY26p6AQdjpHnpqt7xJNVRwcb8LLKTAinlvtgIm1zyhP+
 cv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gMhKoB56fl1CENDGxaDFPrqlt7cUUK874k7xw397NdU=;
 b=eB3oztdJC0Q1pfemk5buBvtNUAY9Xbs+V/qg9x4SDNL7d2ZELqIGDTY69NcDQ9V7Pc
 2thTH6cUqTVZLrUel7dfbyxXv5X41Kgp2T9XV9LQEjfTAHMo1r/1Ejr2EiYW5Loz7UDX
 VSceVUN2yJoiRE8ZXE3/7gbuOwhQQjBXaKdlRmrK1sr5+6ICx5yPvVcaNSX9iYIMlWcS
 drfbb79g5/05zdwU+ZPRNtf3Rpkx7nTXsJhHoQppyOCK8G0t+5lwK+YHcFoV5W5mTfn4
 y+YPtRWANcKYrhLas9Mm88mTKg++tW+9qgSecpOkdZTFjQOdlVZ5eHSqozlF/yIQux19
 IxtA==
X-Gm-Message-State: AJcUukf668P//xeAxS5oWs+4B/SXPgAFAOJeIE1k5Lydzl44HMA1iWB1
 hJjHdfYoP7trSekPjzicCIQJEMlZhTqK7/5WKtg=
X-Google-Smtp-Source: ALg8bN5DG7KGiHBMbCIxnPHPogckdubzNMt/jjijDA8hZ2AZq8k3DkpH3670RP94iJyqTvr7cTVkl8RWceaALOX7seg=
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr37134675wrq.5.1546453701202;
 Wed, 02 Jan 2019 10:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-12-andrew.smirnov@gmail.com>
 <86e8172d-d1dc-59d6-0b64-b11ce014b6a4@synopsys.com>
In-Reply-To: <86e8172d-d1dc-59d6-0b64-b11ce014b6a4@synopsys.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 2 Jan 2019 10:28:09 -0800
Message-ID: <CAHQ1cqH3uFj51ORhp1eHPp6jVNoM0D1nv5qHvQESnmPX3-ESoQ@mail.gmail.com>
Subject: Re: [PATCH 11/21] PCI: designware: Make use of BIT() in constant
 definitions
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_102824_222228_BE51F02C 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgMjYsIDIwMTggYXQgNzoxOSBBTSBHdXN0YXZvIFBpbWVudGVsCjxndXN0YXZv
LnBpbWVudGVsQHN5bm9wc3lzLmNvbT4gd3JvdGU6Cj4KPiBIaSwKPgo+IE9uIDIxLzEyLzIwMTgg
MDc6MjcsIEFuZHJleSBTbWlybm92IHdyb3RlOgo+ID4gQXZvaWQgdXNpbmcgZXhwbGljaXQgbGVm
dCBzaGlmdHMgYW5kIGNvbnZlcnQgdmFyaW91cyBkZWZpbml0aW9ucyB0bwo+ID4gdXNlIEJJVCgp
IGluc3RlYWQuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLgo+ID4KPiA+IENjOiBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4KPiA+IENjOiBCam9ybiBI
ZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgo+ID4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZhYmlv
LmVzdGV2YW1AbnhwLmNvbT4KPiA+IENjOiBDaHJpcyBIZWFseSA8Y3BoZWFseUBnbWFpbC5jb20+
Cj4gPiBDYzogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cj4gPiBDYzogTGVv
bmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4KPiA+IENjOiAiQS5zLiBEb25n
IiA8YWlzaGVuZy5kb25nQG54cC5jb20+Cj4gPiBDYzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPgo+ID4gQ2M6IGxpbnV4LWlteEBueHAuY29tCj4gPiBDYzogbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZwo+ID4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6
IEFuZHJleSBTbWlybm92IDxhbmRyZXcuc21pcm5vdkBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyB8ICAyICstCj4gPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggfCAxOCArKysrKysr
KystLS0tLS0tLS0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS5jCj4gPiBpbmRleCBkMTIzYWMyOTBiOWUuLjA4NmU4N2E0MDMxNiAxMDA2NDQKPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYwo+ID4gQEAg
LTMwMCw3ICszMDAsNyBAQCB2b2lkIGR3X3BjaWVfZGlzYWJsZV9hdHUoc3RydWN0IGR3X3BjaWUg
KnBjaSwgaW50IGluZGV4LAo+ID4gICAgICAgfQo+ID4KPiA+ICAgICAgIGR3X3BjaWVfd3JpdGVs
X2RiaShwY2ksIFBDSUVfQVRVX1ZJRVdQT1JULCByZWdpb24gfCBpbmRleCk7Cj4gPiAtICAgICBk
d19wY2llX3dyaXRlbF9kYmkocGNpLCBQQ0lFX0FUVV9DUjIsIH5QQ0lFX0FUVV9FTkFCTEUpOwo+
ID4gKyAgICAgZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9BVFVfQ1IyLCAodTMyKX5QQ0lF
X0FUVV9FTkFCTEUpOwo+Cj4gVGhpcyBpcyB1bnJlbGF0ZWQgd2l0aCB0aGUgcGF0Y2ggZGVzY3Jp
cHRpb24gcHVycG9zZS4KPgoKVGhpcyBpcyBhIGRpcmVjdCByZXN1bHQgb2YgY29udmVydGluZyBQ
Q0lFX0FUVV9FTkFCTEUgdG8gQklUKDMxKS4KQklUKDMxKSBleHBhbmRzIHRvICgxVUwgPDwgMzEp
IHNvLCB3aXRob3V0IHRoYXQgY2FzdCBJIGdldAoKZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmM6IEluIGZ1bmN0aW9uCuKAmGR3X3BjaWVfZGlzYWJsZV9hdHXigJk6
CmRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jOjMwMzo0MDogd2Fy
bmluZzogbGFyZ2UKaW50ZWdlciBpbXBsaWNpdGx5IHRydW5jYXRlZCB0byB1bnNpZ25lZCB0eXBl
IFstV292ZXJmbG93XQogIGR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSUVfQVRVX0NSMiwgflBD
SUVfQVRVX0VOQUJMRSk7CgpvbiBBQXJjaDY0LiBJIGFtIGd1ZXNzaW5nIHRoYXQgb3JpZ2luYWwg
ZGVmaW5pdGlvbiBvZiAoMSA8PCAzMSkgYXZvaWRzCnRoaXMgcHJvYmxlbSBieSBiZWluZyBhbiAi
aW50IiBpbnN0ZWFkIG9mICJ1bnNpZ25lZCBsb25nIi4KClRoYW5rcywKQW5kcmV5IFNtaXJub3YK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
