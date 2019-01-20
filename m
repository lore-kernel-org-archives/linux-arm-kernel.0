Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190A3C676ED
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:17:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99B32085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QZ4RJc4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99B32085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K+mGVMfTupw/jJ0dNPzH8lZxFw4Ej5Rd2bzHK5HHRcA=; b=QZ4RJc4HY6tTSU
	YwGzAc34+Sy+Kx2xygWM0U/3Ms0Dc6ycB/xLF4bhq0K+4NWwXA7uHy6b0Agf2giN++yY6qF1DyaQP
	Ql6ZRM8V+S3aHt4oKWsMEIneRsCjJLwU7IZinqi607KJLXhWAT/gLTppw+rhCUUthl7v8PIg+3RFA
	vJ515mxfXEymqKDqE8psea11aR/xD5fc2NK8s2eA+kCjKSt9J6WiWeX02aMXVyv7p0tXjTB7Kv4BO
	JBhueXbRUQ/gjhwvA7obS16ZQhJZG1Sd03nhn8MDK4xF16iY8gjvq4q8zNKAxU5XjVh+otCynJlew
	QbKlJH7pvDkkNQyqaM8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glEqH-0006bN-Cn; Sun, 20 Jan 2019 15:16:57 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glEqC-0006b1-BP
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 15:16:54 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D61FB2074A; Sun, 20 Jan 2019 16:16:50 +0100 (CET)
Received: from xps13 (unknown [77.136.42.183])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9EF3D206A7;
 Sun, 20 Jan 2019 16:16:49 +0100 (CET)
Date: Sun, 20 Jan 2019 16:16:48 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190120161648.102191be@xps13>
In-Reply-To: <87va2llxhz.fsf@FE-laptop>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
 <87va2llxhz.fsf@FE-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_071652_523905_12831632 
X-CRM114-Status: GOOD (  19.16  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3JlZ29yeSwKCkdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29t
PiB3cm90ZSBvbiBGcmksIDE4IEphbiAyMDE5CjE3OjUxOjUyICswMTAwOgoKPiBIaSBNaXF1ZWws
Cj4gIAo+ICBPbiBtYXIuLCBqYW52LiAwOCAyMDE5LCBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5
bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKPiAKPiA+IEhlbGxvLAo+ID4KPiA+IEFzIHBhcnQgb2Yg
YW4gZWZmb3J0IHRvIGJyaW5nIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQgdG8gQXJtYWRhIDM3MDAK
PiA+IFNvQ3MgKG1haW4gdGFyZ2V0OiBFU1BSRVNTT2JpbiksIHRoaXMgc2VyaWVzIGhhbmRsZXMg
dGhlIHdvcmsgYXJvdW5kCj4gPiB0aGUgUENJZSBJUC4KPiA+Cj4gPiBGaXJzdCwgbW9yZSBjb25m
aWd1cmF0aW9uIGlzIGRvbmUgaW4gdGhlICdzZXR1cCcgaGVscGVyIGFzIGluc3BpcmVkCj4gPiBm
cm9tIHRoZSBVLUJvb3QgZHJpdmVyLiBUaGlzIGlzIG5lZWRlZCB0byBlbnRpcmVseSBpbml0aWFs
aXplIHRoZSBJUAo+ID4gZHVyaW5nIGZ1dHVyZSByZXN1bWUgb3BlcmF0aW9uIChwYXRjaCAxKS4K
PiA+Cj4gPiBUaGVuLCByZXNldCBHUElPLCBQSFkgYW5kIGNsb2NrIHN1cHBvcnQgYXJlIGludHJv
ZHVjZWQgKHBhdGNoIDItNCkuIEFzCj4gPiBjdXJyZW50IGRldmljZSB0cmVlcyBkbyBub3QgcHJv
dmlkZSB0aGUgY29ycmVzcG9uZGluZyBwcm9wZXJ0aWVzLCBub3QKPiA+IGZpbmRpbmcgb25lIG9m
IHRoZXNlIHByb3BlcnRpZXMgaXMgbm90IGFuIGVycm9yIGFuZCBqdXN0IHByb2R1Y2VzIGEKPiA+
IHdhcm5pbmcuIEhvd2V2ZXIsIGlmIHRoZSBwcm9wZXJ0eSBpcyBwcmVzZW50LCBhbiBlcnJvciBk
dXJpbmcgUEhZCj4gPiBpbml0aWFsaXphdGlvbiB3aWxsIGZhaWwgdGhlIHByb2JlIG9mIHRoZSBk
cml2ZXIuCj4gPgo+ID4gTm90ZTogVG8gYmUgc3VyZSB0aGUgY2xvY2sgd2lsbCBiZSByZXN1bWVk
IGJlZm9yZSB0aGlzIGRyaXZlciwgYSBmaXJzdAo+ID4gc2VyaWVzIGFkZGluZyBsaW5rcyBiZXR3
ZWVuIGNsb2NrcyBhbmQgY29uc3VtZXJzIGhhcyBiZWVuIHN1Ym1pdHRlZCwKPiA+IHNlZSBbMV0u
IEFueXdheSwgaGF2aW5nIHRoZSBjbG9jayBzZXJpZXMgYXBwbGllZCBmaXJzdCBpcyBub3QgbmVl
ZGVkLgo+ID4KPiA+IFBhdGNoIDUgYWRkcyBzdXNwZW5kL3Jlc3VtZSBob29rcywgcmUtdXNpbmcg
YWxsIHRoZSBhYm92ZS4KPiA+Cj4gPiBGaW5hbGx5LCBiaW5kaW5ncyBhbmQgZGV2aWNlIHRyZWVz
IGFyZSB1cGRhdGVkIHRvIHJlZmxlY3QgdGhlIGhhcmR3YXJlCj4gPiAocGF0Y2ggNi0xMikuIFdo
aWxlIHRoZSBjbG9jayBkZXBlbmRzIG9uIHRoZSBTb0MsIHRoZSByZXNldCBHUElPIGFuZAo+ID4g
dGhlIFBIWSBkZXBlbmRzIG9uIHRoZSBib2FyZCBzbyB0aGUgY2xvY2sgaXMgYWRkZWQgaW4gdGhl
Cj4gPiBhcm1hZGEtMzd4eC5kdHNpIGZpbGUgd2hpbGUgdGhlIHR3byBvdGhlciBwcm9wZXJ0aWVz
IGFyZSBhZGRlZCBpbgo+ID4gYXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRzLgo+ID4KPiA+IFsx
XSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtYXJtLWtlcm5lbC8y
MDE5LUphbnVhcnkvNjIzODg1Lmh0bWwKPiA+Cj4gPiBUaGFua3MsCj4gPiBNaXF1w6hsCj4gPgo+
ID4KPiA+IENoYW5nZXMgc2luY2UgdjI6Cj4gPiA9PT09PT09PT09PT09PT09PQo+ID4gKiBNaW5v
ciBwYXRjaGVzIHJlb3JkZXJpbmcuCj4gPiAqIEFkZGVkIHBpbmN0cmwgcGF0Y2hlcyBmcm9tIEdy
ZWdvcnkgQ2xlbWVudCBmaXhpbmcgdGhlIFBDSWUgcGlucy4gSGlzCj4gPiAgIGNoYW5nZXMgaW1w
bGllZCBtb2RpZmljYXRpb25zIGluIHRoZSBEVC9iaW5kaW5ncyBwYXRjaGVzIGFkZGluZyBQQ0ll
Cj4gPiAgIHJlc2V0IHBpbiBzdXBwb3J0LiAgCj4gCj4gQWN0dWFsbHkgdGhlc2UgcGF0Y2hlcyBh
cmUgbm90IGluIHRoaXMgc2VyaWVzLiBZb3UgcHJvcGFibHkgbWVhbnQgdGhhdAo+IHRoaXMgc2Vy
aWVzIGlzIGRlcGVuZCBvbiB0aGVzZSBwYXRjaGVzLgo+IAo+IElmIG5lZWRlZCwgZm9yIHBlb2Fw
bGUgd2hvIHdhbnRlZCB0byB0ZXN0IHRoaXMgc2VyaWVzLCB0aGUgcGluY3RybAo+IGNoYW5nZXMg
YXJlIG5vdyBpbiBsaW51eC1uZXh0IGFuZCBhbHNvIGluIHBpbmN0cmwvZm9yLW5leHQuCgpBYnNv
bHV0ZWx5LCB0aGlzIGlzIHdoYXQgSSBtZWFudCwgdGhhbmtzIGZvciBjbGFyaWZ5aW5nLgoKVGhh
bmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
