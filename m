Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:04:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BEA2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iNGFo/w5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BEA2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3TnGGWDoAk9RTVmkz+p1+qW3s0mft0CwuuY1dO8U2eo=; b=iNGFo/w5yah+DZ
	jFyJRcW7Kr9/2uBs61YFitTlGEWvAwDyDJ29UKF6P9e67oeGN/dXrmmGuRvj0NoW3NU0ZP0KfV219
	MwFzwuz4RDzmpviA+rm4Frs/UVOXXFplKXU2VOcF6sgbZcLsdpaPI14eevbaokLQS2TdBPrD9R+35
	6ZqphyLY0ruLOCI7IWE593x2zKe8x3A1UaO4YJud0hWwwdXAe+LKnwYyBnS2W0aHCYidJ3Dxljl/m
	N/TsCY4+ozzsWb+h43M25Y8GomqzMiKSxXFiWTjQiwOPHXe06LhLXlzTVh90DpfkQbEG6KH0iEShD
	JJdK/oqhfWWazjZTmh2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZWpi-0004ml-Aa; Wed, 19 Dec 2018 08:03:58 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZWpe-0004ko-Uy
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 08:03:56 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EA08120A82; Wed, 19 Dec 2018 09:03:41 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9AACF207B8;
 Wed, 19 Dec 2018 09:03:31 +0100 (CET)
Date: Wed, 19 Dec 2018 09:03:31 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/4] clk: core: clarify the check for runtime PM
Message-ID: <20181219090331.4c8c4852@xps13>
In-Reply-To: <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-2-miquel.raynal@bootlin.com>
 <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_000355_134677_B7A38885 
X-CRM114-Status: GOOD (  21.99  )
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
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlcGhlbiwKClN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGUgb24gVHVl
LCAxOCBEZWMgMjAxOCAxNjowMzoyOQotMDgwMDoKCj4gUXVvdGluZyBNaXF1ZWwgUmF5bmFsICgy
MDE4LTEyLTA0IDExOjI0OjM3KQo+ID4gQ3VycmVudGx5LCB0aGUgY29yZS0+ZGV2IGVudHJ5IGlz
IHBvcHVsYXRlZCBvbmx5IGlmIHJ1bnRpbWUgUE0gaXMKPiA+IGVuYWJsZWQuIERvaW5nIHNvIHBy
ZXZlbnRzIGFjY2Vzc2luZyB0aGUgZGV2aWNlIHN0cnVjdHVyZSBpbiBhbnkKPiA+IGNhc2UuCj4g
PiAKPiA+IEtlZXAgdGhlIHNhbWUgbG9naWMgYnV0IGluc3RlYWQgb2YgdXNpbmcgdGhlIHByZXNl
bmNlIG9mIGNvcmUtPmRldiBhcwo+ID4gdGhlIG9ubHkgY29uZGl0aW9uLCBhbHNvIGNoZWNrIHRo
ZSBzdGF0dXMgb2YKPiA+IHBtX3J1bnRpbWVfZW5hYmxlZCgpLiBUaGVuLCB3ZSBjYW4gc2V0IHRo
ZSBjb3JlLT5kZXYgcG9pbnRlciBhdCBhbnkKPiA+IHRpbWUgYXMgbG9uZyBhcyBhIGRldmljZSBz
dHJ1Y3R1cmUgaXMgYXZhaWxhYmxlLgo+ID4gCj4gPiBUaGlzIGNoYW5nZSB3aWxsIGhlbHAgc3Vw
cG9ydGluZyBkZXZpY2UgbGlua3MgaW4gdGhlIGNsb2NrIHN1YnN5c3RlbS4KPiA+IAo+ID4gU2ln
bmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiA+
IC0tLQo+ID4gIGRyaXZlcnMvY2xrL2Nsay5jIHwgMTEgKysrKystLS0tLS0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbGsvY2xrLmMgYi9kcml2ZXJzL2Nsay9jbGsuYwo+ID4gaW5kZXggYWYw
MTE5NzRkNGVjLi5iNzk5MzQ3YzVmZDYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9jbGsu
Ywo+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLmMKPiA+IEBAIC05Nyw3ICs5Nyw3IEBAIHN0YXRp
YyBpbnQgY2xrX3BtX3J1bnRpbWVfZ2V0KHN0cnVjdCBjbGtfY29yZSAqY29yZSkKPiA+ICB7Cj4g
PiAgICAgICAgIGludCByZXQgPSAwOwo+ID4gIAo+ID4gLSAgICAgICBpZiAoIWNvcmUtPmRldikK
PiA+ICsgICAgICAgaWYgKCFjb3JlLT5kZXYgfHwgIXBtX3J1bnRpbWVfZW5hYmxlZChjb3JlLT5k
ZXYpKSAgCj4gCj4gVGhpcyBsb29rcyBwb3RlbnRpYWxseSBkYW5nZXJvdXMuIFdoYXQgaWYgcnVu
dGltZSBQTSBpcyBkaXNhYmxlZCBmb3IgdGhlCj4gY2xrIHdoZW4gdGhpcyBmdW5jdGlvbiBpcyBj
YWxsZWQ/IFNob3VsZG4ndCB3ZSBqdXN0IHN0YXNoIGEgYm9vbCBhd2F5IGluCj4gdGhlIGNsa19j
b3JlIHN0cnVjdHVyZSB3aGVuIGl0J3MgcmVnaXN0ZXJlZD8gQW5kIHRoZW4gd2UgY2FuIHJlcGxh
Y2UgdGhlCj4gY2hlY2sgZm9yICFjb3JlLT5kZXYgd2l0aCBhIGNoZWNrIGZvciAnY29yZS0+cnBt
X2VuYWJsZWQnIGluc3RlYWQuIFRoYXQKPiB3b3VsZCBiZSBhIG1vcmUgZXhhY3QgdHJhbnNmb3Jt
YXRpb24uCgpTdXJlLCBJJ2xsIGRvIHRoYXQgaWYgeW91IHRoaW5rIHRoZXJlIGlzIGEgZGFuZ2Vy
LgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
