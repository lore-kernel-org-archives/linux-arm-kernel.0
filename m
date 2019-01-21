Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E367C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:54:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C8920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lO9cFqOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C8920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A9DA+LVqOEPqE3gtrA8ueJxAbmk69ZQ4tP4B4I6jVAM=; b=lO9cFqOLce06rw
	P05CxIyXAb19N0nN306lH4cXFd2iqPxjbtY86pXA1jTYhyDWKB9s2lrG3pYD5QEEzj+v3MEsadgie
	06pe6lM6ISxlqmWk/ghu/M3/fq1qbYxetyIO2Ep0zdz5+7uqNPLQl7bt+ovuf3XKc5mGI9DOrXoKw
	XpjvExYmzlmuntfjOGPUUohtl52DJydpqMfT6HAVf574+PhsqaeduG03ojZNSjbd8tp9z0rJfrvp6
	dgUAfIU4nH4K0JHz2HyS+fb5wuXaG2whVTFO+Jno1aU+A+7Zj9Y71LzHYjTzi1GleqRxRXdFAslJk
	9f7XIDuvFOMAXcPjdBug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXE8-0004hj-3Q; Mon, 21 Jan 2019 10:54:48 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXDu-0004Uk-Ak
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:54:38 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A318F209BF; Mon, 21 Jan 2019 11:54:32 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 28A26206A7;
 Mon, 21 Jan 2019 11:54:22 +0100 (CET)
Date: Mon, 21 Jan 2019 11:54:22 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 02/10] usb: host: xhci: mvebu: add reset on resume quirk
Message-ID: <20190121115422.5db1bd99@xps13>
In-Reply-To: <878szilzpq.fsf@FE-laptop>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-3-miquel.raynal@bootlin.com>
 <878szilzpq.fsf@FE-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_025434_707753_B136C157 
X-CRM114-Status: GOOD (  23.64  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Ofer Heifetz <oferh@marvell.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3JlZ29yeSwKCkdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29t
PiB3cm90ZSBvbiBGcmksIDE4IEphbiAyMDE5CjE3OjA0OjAxICswMTAwOgoKPiBIaSBNaXF1ZWws
Cj4gIAo+ICBPbiB2ZW4uLCBqYW52LiAxMSAyMDE5LCBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5
bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKPiAKPiA+IEZyb206IE9mZXIgSGVpZmV0eiA8b2ZlcmhA
bWFydmVsbC5jb20+Cj4gPgo+ID4gVGhlIG12ZWJ1IHhIQ0kgaG9zdCBkcml2ZXIgZG9lcyBub3Qg
aGF2ZSBzdXNwZW5kL3Jlc3VtZSBzdXBwb3J0LiBVc2Ugb2YKPiA+IHRoZSBYSENJX1JFU0VUX09O
X1JFU1VNRSBxdWlyayBpcyBtYW5kYXRvcnkgaW4gb3JkZXIgdG8gYXZvaWQgZmFpbHVyZXMKPiA+
IGFmdGVyIHJlc3VtZS4gVGhpcyB3aWxsIHdvcmsgb25seSBpZiBubyBVU0IgZGV2aWNlIGlzIHBs
dWdnZWQtaW4uCj4gPgo+ID4gV2hpbGUgYXQgaXQsIG1lbnRpb24gaW4gdGhlIEtjb25maWcgZmls
ZSB0aGF0IHRoaXMgSVAgaXMgYWxzbyBwcmVzZW50Cj4gPiBvbiB0aGUgQTM3MDAgU29DLgo+ID4K
PiA+IFNpZ25lZC1vZmYtYnk6IE9mZXIgSGVpZmV0eiA8b2ZlcmhAbWFydmVsbC5jb20+Cj4gPiBb
bWlxdWVsLnJheW5hbEBib290bGluLmNvbTogUmV3b3JkIHRoZSBjb21taXQgbWVzc2FnZV0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+
Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3VzYi9ob3N0L0tjb25maWcgICAgICB8ICA0ICsrLS0KPiA+
ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXZlYnUuYyB8IDExICsrKysrKysrKysrCj4gPiAgZHJp
dmVycy91c2IvaG9zdC94aGNpLW12ZWJ1LmggfCAgNiArKysrKysKPiA+ICBkcml2ZXJzL3VzYi9o
b3N0L3hoY2ktcGxhdC5jICB8ICA3ICsrKysrKysKPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZwo+ID4gaW5kZXggMTY3
NThiMTJhNWU5Li4xM2Q1OWJlNmE2YWEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0
L0tjb25maWcKPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZwo+ID4gQEAgLTY5LDEz
ICs2OSwxMyBAQCBjb25maWcgVVNCX1hIQ0lfTVRLCj4gPiAgCSAgSWYgdW5zdXJlLCBzYXkgTi4K
PiA+ICAKPiA+ICBjb25maWcgVVNCX1hIQ0lfTVZFQlUKPiA+IC0JdHJpc3RhdGUgInhIQ0kgc3Vw
cG9ydCBmb3IgTWFydmVsbCBBcm1hZGEgMzc1LzM4eCIKPiA+ICsJdHJpc3RhdGUgInhIQ0kgc3Vw
cG9ydCBmb3IgTWFydmVsbCBBcm1hZGEgMzc1LzM4eC8zNzAwIiAgCj4gCj4gSSB3b3VsZCBuYW1l
IGl0IDM3eHggdG8gYmUgY29uc2lzdGVudCB3aXRoIDM4eAo+IAo+ID4gIAlzZWxlY3QgVVNCX1hI
Q0lfUExBVEZPUk0KPiA+ICAJZGVwZW5kcyBvbiBIQVNfSU9NRU0KPiA+ICAJZGVwZW5kcyBvbiBB
UkNIX01WRUJVIHx8IENPTVBJTEVfVEVTVAo+ID4gIAktLS1oZWxwLS0tCj4gPiAgCSAgU2F5ICdZ
JyB0byBlbmFibGUgdGhlIHN1cHBvcnQgZm9yIHRoZSB4SENJIGhvc3QgY29udHJvbGxlcgo+ID4g
LQkgIGZvdW5kIGluIE1hcnZlbGwgQXJtYWRhIDM3NS8zOHggQVJNIFNPQ3MuCj4gPiArCSAgZm91
bmQgaW4gTWFydmVsbCBBcm1hZGEgMzc1LzM4eC8zNzAwIEFSTSBTT0NzLiAgCj4gc2FtZSBoZXJl
Cj4gCgpTdXJlIQoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
