Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D543C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:58:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CDF218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hf4iDgyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CDF218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J+cZffyq1N2w4Xfes1/FUQnAo5LBw9tOcQNFzcwp1zc=; b=Hf4iDgyX6EXgDo
	1dk0msz9frUkcLLNs/k4tpKlWEIFOTTL8mdRf1V8OzRU9pe5w/ALNo+AzE/uUajPDSx8n5ZPYC4cn
	Hqyc56HANeu824uuiW9UIpkajQizaagOi0BzZEIXblP6AS2VqJG+QJSwezYUqXqiAf7BcsiDyKF8e
	PcqBSx6neqYj+XivYQOd3RDbONHEK+KirpRQGfBZq+XC4hzsKFlI0b9ahTRYmFAKjoauBNe0kA7AM
	usN+DkUPJ13lAIYoeHp+S0/VmsEBPyuEHAnQTPkmEjcv/omq/rgrorRDGbZDdriGbKbJVFx1AueAv
	A2YvFeiGdbmRG1bNwvmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn13c-0006Ju-Jq; Fri, 25 Jan 2019 12:58:04 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn13X-0006Ii-Ix
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:58:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E1499207B0; Fri, 25 Jan 2019 13:57:57 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7369120397;
 Fri, 25 Jan 2019 13:57:57 +0100 (CET)
Date: Fri, 25 Jan 2019 13:57:57 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190125135757.6518191e@xps13>
In-Reply-To: <20190125124011.GA16389@e107981-ln.cambridge.arm.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
 <20190123170509.GB1157@e107981-ln.cambridge.arm.com>
 <20190125110530.0ff11a54@xps13>
 <20190125124011.GA16389@e107981-ln.cambridge.arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_045800_088822_3372468B 
X-CRM114-Status: GOOD (  29.52  )
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
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTG9yZW56bywKCkxvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
PiB3cm90ZSBvbiBGcmksIDI1IEphbiAyMDE5CjEyOjQwOjExICswMDAwOgoKPiBPbiBGcmksIEph
biAyNSwgMjAxOSBhdCAxMTowNTozMEFNICswMTAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+ID4g
SGkgTG9yZW56bywKPiA+IAo+ID4gTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb20+IHdyb3RlIG9uIFdlZCwgMjMgSmFuIDIwMTkKPiA+IDE3OjA1OjA5ICswMDAwOgo+
ID4gICAKPiA+ID4gT24gVHVlLCBKYW4gMDgsIDIwMTkgYXQgMDU6MjQ6MjVQTSArMDEwMCwgTWlx
dWVsIFJheW5hbCB3cm90ZTogIAo+ID4gPiA+IEhlbGxvLAo+ID4gPiA+IAo+ID4gPiA+IEFzIHBh
cnQgb2YgYW4gZWZmb3J0IHRvIGJyaW5nIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQgdG8gQXJtYWRh
IDM3MDAKPiA+ID4gPiBTb0NzIChtYWluIHRhcmdldDogRVNQUkVTU09iaW4pLCB0aGlzIHNlcmll
cyBoYW5kbGVzIHRoZSB3b3JrIGFyb3VuZAo+ID4gPiA+IHRoZSBQQ0llIElQLgo+ID4gPiA+IAo+
ID4gPiA+IEZpcnN0LCBtb3JlIGNvbmZpZ3VyYXRpb24gaXMgZG9uZSBpbiB0aGUgJ3NldHVwJyBo
ZWxwZXIgYXMgaW5zcGlyZWQKPiA+ID4gPiBmcm9tIHRoZSBVLUJvb3QgZHJpdmVyLiBUaGlzIGlz
IG5lZWRlZCB0byBlbnRpcmVseSBpbml0aWFsaXplIHRoZSBJUAo+ID4gPiA+IGR1cmluZyBmdXR1
cmUgcmVzdW1lIG9wZXJhdGlvbiAocGF0Y2ggMSkuCj4gPiA+ID4gCj4gPiA+ID4gVGhlbiwgcmVz
ZXQgR1BJTywgUEhZIGFuZCBjbG9jayBzdXBwb3J0IGFyZSBpbnRyb2R1Y2VkIChwYXRjaCAyLTQp
LiBBcwo+ID4gPiA+IGN1cnJlbnQgZGV2aWNlIHRyZWVzIGRvIG5vdCBwcm92aWRlIHRoZSBjb3Jy
ZXNwb25kaW5nIHByb3BlcnRpZXMsIG5vdAo+ID4gPiA+IGZpbmRpbmcgb25lIG9mIHRoZXNlIHBy
b3BlcnRpZXMgaXMgbm90IGFuIGVycm9yIGFuZCBqdXN0IHByb2R1Y2VzIGEKPiA+ID4gPiB3YXJu
aW5nLiBIb3dldmVyLCBpZiB0aGUgcHJvcGVydHkgaXMgcHJlc2VudCwgYW4gZXJyb3IgZHVyaW5n
IFBIWQo+ID4gPiA+IGluaXRpYWxpemF0aW9uIHdpbGwgZmFpbCB0aGUgcHJvYmUgb2YgdGhlIGRy
aXZlci4KPiA+ID4gPiAKPiA+ID4gPiBOb3RlOiBUbyBiZSBzdXJlIHRoZSBjbG9jayB3aWxsIGJl
IHJlc3VtZWQgYmVmb3JlIHRoaXMgZHJpdmVyLCBhIGZpcnN0Cj4gPiA+ID4gc2VyaWVzIGFkZGlu
ZyBsaW5rcyBiZXR3ZWVuIGNsb2NrcyBhbmQgY29uc3VtZXJzIGhhcyBiZWVuIHN1Ym1pdHRlZCwK
PiA+ID4gPiBzZWUgWzFdLiBBbnl3YXksIGhhdmluZyB0aGUgY2xvY2sgc2VyaWVzIGFwcGxpZWQg
Zmlyc3QgaXMgbm90IG5lZWRlZC4gICAgCj4gPiA+IAo+ID4gPiBJIGRvIG5vdCB1bmRlcnN0YW5k
IHdoYXQgdGhpcyBtZWFucywgaW4gcGFydGljdWxhciBpbiByZWxhdGlvbgo+ID4gPiB0byB0aGUg
YmxvY2tpbmcgY2xvY2sgY2FsbHMgaW4gdGhlIHN1c3BlbmQvcmVzdW1lIE5PSVJRIGhvb2tzLiAg
Cj4gPiAKPiA+IEkgYW0gbm90IHN1cmUgdG8gdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uLgo+ID4g
Cj4gPiBBcyB0aGVyZSBhcmUgbXVsdGlwbGUgcG9pbnRzIGluIHRoaXMgc2VudGVuY2UgSSB3aWxs
IGRldGFpbCBlYWNoIG9mCj4gPiB0aGVtIHNvIHBsZWFzZSBjb21tZW50IG9uIHRoZSBvbmUgd2hp
Y2ggaXMgYm90aGVyaW5nIHlvdToKPiA+ICogSSBhbSB3b3JraW5nIGluIHBhcmFsbGVsIG9uIGEg
c2VyaWVzIGFkZGluZyBkZXZpY2UgbGlua3MgdG8gdGhlIGNsb2NrCj4gPiAgIGZyYW1ld29yay4g
VGhpcyB3YXkgd2hlbiBhIGRyaXZlciBjb25zdW1lcyBhIGNsb2NrLCB0aGUgY2xvY2sKPiA+ICAg
cHJvdmlkZXIgZHJpdmVyIHdpbGwgYmUgcmVzdW1lZCBmaXJzdC4KPiA+ICogSWYgdGhlIGNsb2Nr
IHNlcmllcyBJIGFtIHRhbGtpbmcgYWJvdXQgaXMgYXBwbGllZCBhZnRlciB0aGlzIG9uZSwKPiA+
ICAgdGhlcmUgaXMgbm8gYnVpbGQgaXNzdWUuIE9mIGNvdXJzZSBzdXNwZW5kaW5nIHRoZSBwbGF0
Zm9ybSBtYXkKPiA+ICAgbm90IHdvcmsgYnV0IHRoaXMgaXMgYSBuZXcgZmVhdHVyZSBzbyBub3Ro
aW5nIHdpbGwgYmUgYnJva2VuLiAgCj4gCj4gU3VzcGVuZCB0byBSQU0gd2lsbCBiZSBicm9rZW4g
aWYgdGhlIGNsb2NrIGlzIHN1c3BlbmRlZCBhbmQgbm8KPiBub3RpZmljYXRpb24gd2lsbCBoYXBw
ZW4gaW4gdGhlIE5PSVJRIHBoYXNlLCBpdCBpcyBhIG5ldy1icm9rZW4tZmVhdHVyZS4KPgo+IAo+
ID4gKiBEZXZpY2UgbGlua3MgZG8gbm90IGVuZm9yY2UgYW55IHByaW9yaXR5IGlmIHRoZSBzdXNw
ZW5kL3Jlc3VtZSBwaGFzZQo+ID4gICBiZXR3ZWVuIHR3byBkcml2ZXJzIGlzIG5vdCB0aGUgc2Ft
ZS4gVGhlIFBDSWUgZHJpdmVyIHN1c3BlbmRzIGluIHRoZQo+ID4gICBOT0lSUSBwaGFzZS4gSWYg
d2Ugd2FudCB0aGUgY2xvY2sgZHJpdmVyIHRvIHN1c3BlbmQgKmFmdGVyKiBQQ0llLCBpdHMKPiA+
ICAgc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2tzIG11c3QgYmUgcHJvbW90ZWQgdG8gdGhlIE5PSVJR
IHBoYXNlIGFzIHdlbGwKPiA+ICAgKGFuZCB0aGlzIGlzIHBhcnQgb2YgYW5vdGhlciBzZXJpZXMp
LiBBcyBvZiB0b2RheSB0aGVyZSBpcwo+ID4gICBubyBhbHRlcm5hdGl2ZS4gIAo+IAo+IEkgd2ls
bCBtZXJnZSB0aGlzIHNlcmllcyB3aGVuIGl0IHdvcmtzLCBJIGhhdmUgbm8gZXZpZGVuY2UgdGhh
dCBpdCBkb2VzCj4gZ2l2ZW4gd2hhdCB5b3UgYXJlIHdyaXRpbmcgYWJvdmUsIGlmIHRoZSBzZXJp
ZXMgeW91IG1lbnRpb24gYXJlCj4gKm5lY2Vzc2FyeSogZm9yIHN1c3BlbmQtdG8tUkFNIHRvIHdv
cmsgdGhleSBvdWdodCB0byBiZSBtZXJnZWQgZmlyc3QuCgpJIGFtIHdvcmtpbmcgYWN0aXZlbHkg
dG8gYnJpbmcgQTM3MDAgU29DIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQgYWxtb3N0CmZyb20gc2Ny
YXRjaC4gCgpBcyBvZiB0b2RheSBJIGhhdmUgY29udHJpYnV0ZWQgNjUgcGF0Y2hlcyBzcHJlYWQg
aW4gOCBzZXJpZXMgZm9yIHRoZQpQSFksIGNsaywgUENJZSwgU0FUQSwgVVNCLCBwaW5jdHJsIGFu
ZCBuZXQgc3Vic3lzdGVtcy4gU29tZSBvZiB0aGVtCmhhdmUgYmVlbiBtZXJnZWQsIGJ1dCB0aGUg
dmFzdCBtYWpvcml0eSBoYXMgbm90LCB5ZXQuCgpJIG1lbnRpb25lZCB0aGlzIHJ1bi10aW1lIGRl
cGVuZGVuY3kgYmVjYXVzZSBpdCBleGlzdHMgZm9yIHBlb3BsZSB3aG8Kd291bGQgbGlrZSB0byB0
ZXN0IGp1c3QgdGhlIFBDSWUgSVAuIEJ1dCBTMlJBTSBvbiBBMzcwMCB3aWxsIGJlIGEKbmV3LWJy
b2tlbi1mZWF0dXJlIHVudGlsIGFsbCBwYXRjaGVzIGFyZSBtZXJnZWQuIFdoaWxlIHRoZXJlIGlz
CnN0aWxsIG9uZSBtaXNzaW5nLCB0aGUgZmVhdHVyZSBpcyBicm9rZW4uIElmIGV2ZXJ5Ym9keSB3
YWl0cyBmb3IKdGhlIG90aGVyIHBhdGNoZXMgdG8gYmUgbWVyZ2VkIGZpcnN0LCBpdCBpcyBnb25u
YSBiZSBhIGxvbmcgcHJvY2VzcyA6KQoKSG93ZXZlciwgaWYgeW91IHdhbnQgdG8gd2FpdCBmb3Ig
dGhlIGNsb2NrIGNvcmUgc2VyaWVzIHRvIGJlIGFwcGxpZWQKZmlyc3QgSSByZXNwZWN0IHRoaXMg
Y2hvaWNlIGFuZCBJIHdpbGwgdXBkYXRlIHlvdSB3aGVuIGl0IHdpbGwgYmUgdGhlCmNhc2UuCgoK
VGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
