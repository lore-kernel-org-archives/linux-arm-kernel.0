Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EB1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504922171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R71CaLoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504922171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cA7EtlBwxRjQ+BifrZJt9TlA5A8bd2LwPR5DW1TDG7A=; b=R71CaLocPzCy32
	UNM4y/mEofyf0NxdxHgUI1kMC1B9mCjk9QTXdj2x78GH7nNHtWkV5ry7uflj62aO21GXA33nlEjnC
	BIkhCPmgozjMZ7pL+WuxvK9qBmZhuOssiGM+3wQK/Vz5FZ45fIoTasodCksKfi3YIRNhlVKycHzdS
	jGf4alBX666fBl5R9ySbr7OCkru2Dpg/EnxQTcOrZPTBIUx+Qvg2QXMfS1U6zEj7LKwlVISdyzAbN
	ir/luInXz6RqBLsr/cFAkQS3b9c8gwcC5tOOAJObOh5OgjH4zo4m1Z+htF9PACG73ZFjl1sdwPdT3
	K0/usXCR3AKKcMR3clCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geeBN-0008Rr-KT; Wed, 02 Jan 2019 10:55:29 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geeBJ-0008Pw-Qv
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 10:55:27 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DC8EF207B0; Wed,  2 Jan 2019 11:55:22 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr
 [90.88.149.148])
 by mail.bootlin.com (Postfix) with ESMTPSA id 87F7A206A6;
 Wed,  2 Jan 2019 11:55:22 +0100 (CET)
Date: Wed, 2 Jan 2019 11:55:22 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/4] clk: core: clarify the check for runtime PM
Message-ID: <20190102115522.2d7a1c37@xps13>
In-Reply-To: <154534015908.79149.14109221006631310404@swboyd.mtv.corp.google.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-2-miquel.raynal@bootlin.com>
 <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com>
 <20181219090331.4c8c4852@xps13>
 <154534015908.79149.14109221006631310404@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_025526_145164_D6E94384 
X-CRM114-Status: GOOD (  26.76  )
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

SGkgU3RlcGhlbiwKClN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGUgb24gVGh1
LCAyMCBEZWMgMjAxOCAxMzowOToxOQotMDgwMDoKCj4gUXVvdGluZyBNaXF1ZWwgUmF5bmFsICgy
MDE4LTEyLTE5IDAwOjAzOjMxKQo+ID4gSGkgU3RlcGhlbiwKPiA+IAo+ID4gU3RlcGhlbiBCb3lk
IDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZSBvbiBUdWUsIDE4IERlYyAyMDE4IDE2OjAzOjI5Cj4g
PiAtMDgwMDoKPiA+ICAgCj4gPiA+IFF1b3RpbmcgTWlxdWVsIFJheW5hbCAoMjAxOC0xMi0wNCAx
MToyNDozNykgIAo+ID4gPiA+IEN1cnJlbnRseSwgdGhlIGNvcmUtPmRldiBlbnRyeSBpcyBwb3B1
bGF0ZWQgb25seSBpZiBydW50aW1lIFBNIGlzCj4gPiA+ID4gZW5hYmxlZC4gRG9pbmcgc28gcHJl
dmVudHMgYWNjZXNzaW5nIHRoZSBkZXZpY2Ugc3RydWN0dXJlIGluIGFueQo+ID4gPiA+IGNhc2Uu
Cj4gPiA+ID4gCj4gPiA+ID4gS2VlcCB0aGUgc2FtZSBsb2dpYyBidXQgaW5zdGVhZCBvZiB1c2lu
ZyB0aGUgcHJlc2VuY2Ugb2YgY29yZS0+ZGV2IGFzCj4gPiA+ID4gdGhlIG9ubHkgY29uZGl0aW9u
LCBhbHNvIGNoZWNrIHRoZSBzdGF0dXMgb2YKPiA+ID4gPiBwbV9ydW50aW1lX2VuYWJsZWQoKS4g
VGhlbiwgd2UgY2FuIHNldCB0aGUgY29yZS0+ZGV2IHBvaW50ZXIgYXQgYW55Cj4gPiA+ID4gdGlt
ZSBhcyBsb25nIGFzIGEgZGV2aWNlIHN0cnVjdHVyZSBpcyBhdmFpbGFibGUuCj4gPiA+ID4gCj4g
PiA+ID4gVGhpcyBjaGFuZ2Ugd2lsbCBoZWxwIHN1cHBvcnRpbmcgZGV2aWNlIGxpbmtzIGluIHRo
ZSBjbG9jayBzdWJzeXN0ZW0uCj4gPiA+ID4gCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWlxdWVs
IFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAg
ZHJpdmVycy9jbGsvY2xrLmMgfCAxMSArKysrKy0tLS0tLQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+ID4gPiA+IAo+ID4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9jbGsuYyBiL2RyaXZlcnMvY2xrL2Nsay5jCj4gPiA+ID4gaW5k
ZXggYWYwMTE5NzRkNGVjLi5iNzk5MzQ3YzVmZDYgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9jbGsvY2xrLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGsuYwo+ID4gPiA+IEBAIC05
Nyw3ICs5Nyw3IEBAIHN0YXRpYyBpbnQgY2xrX3BtX3J1bnRpbWVfZ2V0KHN0cnVjdCBjbGtfY29y
ZSAqY29yZSkKPiA+ID4gPiAgewo+ID4gPiA+ICAgICAgICAgaW50IHJldCA9IDA7Cj4gPiA+ID4g
IAo+ID4gPiA+IC0gICAgICAgaWYgKCFjb3JlLT5kZXYpCj4gPiA+ID4gKyAgICAgICBpZiAoIWNv
cmUtPmRldiB8fCAhcG1fcnVudGltZV9lbmFibGVkKGNvcmUtPmRldikpICAgIAo+ID4gPiAKPiA+
ID4gVGhpcyBsb29rcyBwb3RlbnRpYWxseSBkYW5nZXJvdXMuIFdoYXQgaWYgcnVudGltZSBQTSBp
cyBkaXNhYmxlZCBmb3IgdGhlCj4gPiA+IGNsayB3aGVuIHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVk
PyBTaG91bGRuJ3Qgd2UganVzdCBzdGFzaCBhIGJvb2wgYXdheSBpbgo+ID4gPiB0aGUgY2xrX2Nv
cmUgc3RydWN0dXJlIHdoZW4gaXQncyByZWdpc3RlcmVkPyBBbmQgdGhlbiB3ZSBjYW4gcmVwbGFj
ZSB0aGUKPiA+ID4gY2hlY2sgZm9yICFjb3JlLT5kZXYgd2l0aCBhIGNoZWNrIGZvciAnY29yZS0+
cnBtX2VuYWJsZWQnIGluc3RlYWQuIFRoYXQKPiA+ID4gd291bGQgYmUgYSBtb3JlIGV4YWN0IHRy
YW5zZm9ybWF0aW9uLiAgCj4gPiAKPiA+IFN1cmUsIEknbGwgZG8gdGhhdCBpZiB5b3UgdGhpbmsg
dGhlcmUgaXMgYSBkYW5nZXIuICAKPiAKPiBJJ3ZlIG1hZGUgdGhlIGNoYW5nZSBhbmQgcHVzaGVk
IGl0IG91dCB0byB0aGUgY2xrIHRyZWUuIEknbSB3b3JraW5nIG9uCj4gc29tZSBwYXRjaGVzIHRv
IGNoYW5nZSBob3cgd2UgZG8gcGFyZW50IGxvb2t1cHMgYW5kIHJld29ya2luZyBjbGtfZ2V0KCkK
PiBpbiB0aGUgcHJvY2Vzcy4gVGFrZSBhIGxvb2sgc28gd2UgZG9uJ3QgZHVwbGljYXRlIGVmZm9y
dHMuIFRoZSBjb2RlCj4gaXNuJ3QgY29tcGxldGUsIGJ1dCBJIGhvcGUgdG8gZmluaXNoIHNvb24u
IFlvdXIgZGV2aWNlIGxpbmtzIHBhdGNoZXMgY2FuCj4gYnVpbGQgdXBvbiB0aGlzLgo+IAo+ICBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2xrL2xpbnV4Lmdp
dCBjbGstcGFyZW50LXJld3JpdGUKPiAKClNvcnJ5IGZvciB0aGUgZGVsYXkgYW5kIHRoYW5rcyBm
b3IgdGhlIHVwZGF0ZS4gSSBoYXZlIGJlZW4gcHJlZW1wdGVkIGJ5CmFub3RoZXIgaXNzdWUsIEkg
d2lsbCBzd2l0Y2ggdG8gY2xvY2tzIGFuZCBwcm9wb3NlIHNvbWV0aGluZyBBU0FQLgoKClRoYW5r
cywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
