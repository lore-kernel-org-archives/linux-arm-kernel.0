Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:59:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D65020652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Az4e9cJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D65020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4gE1CLcJwIVKQlGjRqCcSHyPkJnTXKkCGEASq8Tmmr0=; b=Az4e9cJZSECmsa
	e3CikyuVSdmCZuQcbpnrXkcMIRf82dj33nulA+6hS2+PHTVBM4ydUShML7xTH8EnZtxnARRqPFh6n
	w/1VRITv2n8p++umeeyEf4n30W+Js277nwRufggUijM9Jis2fDndZuHXHt+65fuSy8l03EzEUBs+e
	uEtaAA8iI9zFsJx6vGH9Of1hi8u5s9X5cmPgwgUy90y3gp0lVf/+9fXPIgbmoZyJ1kZCrvd+8CKe4
	neQrIvk7laaofZIPydy68cbjSTI3/NiPQi0IA256p2skZEIp6fJLjuFXt/1nSk7GM/AB6GymFH57d
	BgRTP52xYwU3fGfNPPIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyf8s-0006xy-Ck; Tue, 26 Feb 2019 15:59:38 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyf8p-0006xc-Mg; Tue, 26 Feb 2019 15:59:37 +0000
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7E47920000C;
 Tue, 26 Feb 2019 15:59:24 +0000 (UTC)
Date: Tue, 26 Feb 2019 16:59:23 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [RFC PATCH 25/27] mtd: nand: Add helpers to manage ECC engines
 and configurationsND
Message-ID: <20190226165923.535f63f7@xps13>
In-Reply-To: <20190225194803.58fb8efc@collabora.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-13-miquel.raynal@bootlin.com>
 <20190222154431.66c6911f@kernel.org>
 <20190225170118.62739fc4@xps13>
 <20190225173414.1836f0a8@kernel.org>
 <20190225194803.58fb8efc@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_075935_894536_5C4E6C45 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: Brian Norris <computersforpeace@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBjb2xsYWJvcmEuY29t
PiB3cm90ZSBvbiBNb24sIDI1IEZlYgoyMDE5IDE5OjQ4OjAzICswMTAwOgoKPiA+ID4gQWxzbywg
dGhlIHBhcnNpbmcgb2YgdGhlIERUIChpbiBuYW5kX2VjY19yZWFkX3VzZXJfY29uZigpKSBnaXZl
cyBtZSB0aGUKPiA+ID4gdXNlciBFQ0MgbW9kZSBhbmQgYWxnbywgc28gSSBjYW5ub3QgbGV0IHRo
ZSByYXcgTkFORCBjb3JlIChvciBhIHJhdwo+ID4gPiBOQU5EIGNvbnRyb2xsZXIgZHJpdmVyKSBv
ciB0aGUgU1BJIE5BTkQgY29yZSBkZWNpZGUgd2hpY2ggbW9kZSBpcyB0aGUKPiA+ID4gZGVmYXVs
dCBpZiBub3QgcHJvdmlkZWQgYnkgdGhlIHVzZXIuICAgIAo+ID4gCj4gPiBFeGNlcHQgdGhpcyBw
cm9wIGlzIG9wdGlvbmFsIGluIG1vc3QgY2FzZXMsIGFuZCB0aGUgZGVmYXVsdCB2YWx1ZSBpcwo+
ID4gbm90IGFsd2F5cyB0aGUgc2FtZSwgd2hpY2ggaXMgd2h5IEkgdGhpbmsgdGhpcyBFQ0MgZW5n
aW5lIHJldHJpZXZhbCBzdGVwCj4gPiBzaG91bGQgYmUgbGVmdCB0byBlYWNoIHN1Yi1sYXllciAo
YW5kIHNvbWV0aW1lcyB0byB0aGUgY29udHJvbGxlciBkcml2ZXIKPiA+IGJlaGluZCBpdCkuIE1h
eWJlIHlvdSBjYW4gcHJvdmlkZSBoZWxwZXJzIHRvIGhlbHAgd2l0aCB0aGF0LCBidXQgSQo+ID4g
ZG9uJ3QgdGhpbmsgdGFraW5nIHRoaXMgZGVjaXNpb24gaGVyZSwgYmFzZWQgb24gdGhlIGJ1cyB0
eXBlLCBpcyBhIGdvb2QKPiA+IGlkZWEuIEFuZCBJIGFsc28gZG9uJ3QgbGlrZSB0aGUgaWRlYSBv
ZiBhZGRpbmcgYSBuZXcgU1BJTkFORCB0eXBlLiAgCj4gCj4gSG0sIGFmdGVyIHRoaW5raW5nIGEg
Yml0IG1vcmUgYWJvdXQgaXQsIG1heWJlIHdlIGNvdWxkIGhhdmUgc29tZXRoaW5nCj4gaW4tYmV0
d2VlbjogbGV0IHRoZSBjb250cm9sbGVyIGRyaXZlciBvciBzdWItbGF5ZXIgc3BlY2lmeSB3aGF0
IHRoZQo+IGRlZmF1bHQgdmFsdWVzIGFyZSAocHJvdmlkZXIvbW9kZSBhbmQgcG9zc2libHkgYWxn
b3JpdGhtIGlmIHRoYXQgbWFrZXMKPiBzZW5zZSkgc28gdGhhdCB0aGlzIGdlbmVyaWMgZnVuY3Rp
b24gY2FuIHVzZSB0aGVzZSBkZWZhdWx0cyB3aGVuCj4gbmFuZC0+ZWNjLnVzZXJfY29uZi57bW9k
ZSxhbGdvfSA9PSBVTktOT1dOLgoKSGF2aW5nIGEgImRlZmF1bHRfcHJvdmlkZXIiIGluIHN0cnVj
dCBuYW5kX2VjYyBjb3VsZCB0byB0aGUgdHJpY2suIEl0CndvdWxkIGJlIGZpbGxlZCBieSB0aGUg
Y29udHJvbGxlciBkcml2ZXJzL3N1YmxheWVycyBiZWZvcmUKbmFuZGRldl9lY2NfZW5naW5lX2lu
aXQoKSBpcyBjYWxsZWQuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
