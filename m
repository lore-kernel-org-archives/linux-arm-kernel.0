Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5772C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:48:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E9E217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MHIpWmak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E9E217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L4XYpuz5smjsIVB+u+f1j/E39M32ZnB2VyYlKJqbIZc=; b=MHIpWmakkt2DDg
	uuYYjXVFQphOT5ufVIkhtFiiwubWz8XIh9yt+bD/oWbqCcAyZE7dLDUp2IaK+CcfXn2Z9j1uULcXl
	yIP6tHs7GE4aAXT7H3tTOKOfQHxc6qqPlc02xE76AnLlRhx2OlEW3qmd60M7tXKEBAyc1OMqCbt+9
	g9NMluso703Zke2xARHGMvNC/+NOa2bpwvR32m47tNc3gfY8Sxi65CbUNroDeRIqmteBLrs73bJED
	3B5kQvegUAzFXl8YjmjXugd0E7stf/BLBPi74ne4Rz9VShh6L6+VZfed33yhb1/76cA57N3y6YOOC
	QTyQVeThfyHpZTSiObzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZf18-0000o0-8o; Wed, 19 Dec 2018 16:48:18 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZf14-0000ji-AM
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:48:16 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1FF03206FF; Wed, 19 Dec 2018 17:48:02 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8AC842039F;
 Wed, 19 Dec 2018 17:48:01 +0100 (CET)
Date: Wed, 19 Dec 2018 17:48:01 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181219174801.1d611436@xps13>
In-Reply-To: <20181219162835.5ff9c33c@dellmb.labs.office.nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
 <20181217170724.58421a29@xps13> <20181217223430.182d01d8@nic.cz>
 <20181218091817.4a8a5d42@xps13> <20181218092314.725af970@xps13>
 <20181218140920.6935db39@nic.cz> <20181218144130.3f1a75de@xps13>
 <20181219162835.5ff9c33c@dellmb.labs.office.nic.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_084814_634842_8C684DA0 
X-CRM114-Status: GOOD (  23.13  )
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

SGkgTWFyZWssCgpNYXJlayBCZWjDum4gPG1hcmVrLmJlaHVuQG5pYy5jej4gd3JvdGUgb24gV2Vk
LCAxOSBEZWMgMjAxOCAxNjoyODozNQorMDEwMDoKCj4gSGksCj4gCj4gT25lIHRoaW5nIGZvciB3
aGljaCBJIHdvdWxkIGxpa2UgdG8gYmUgYWJsZSB0byBkaXNhYmxlIGNvbXBoeSBpcyB0aGF0Cj4g
ZWFjaCBjb25zdW1lcyBhYm91dCAxMDBtVyBvZiBwb3dlci4gT24gVHVycmlzIE1veCB3ZSBjb25m
aWd1cmUgdGhlCj4gY29tcGh5cyB0byBTR01JSTEsIFBDSWUgYW5kIFVTQjMgbW9kZXMuIElmIHRo
ZXJlIGlzIG5vIFVTQiBkZXZpY2UKPiBwbHVnZ2VkLCB0aGUgVVNCMyBwaHkgY2FuIGJlIGRpc2Fi
bGVkLCBhbmQgc2F2ZSAxMDBtVyBvZiBwb3dlci4gSWYgdGhlCj4gUENJZSBleHRlbnNpb24gbW9k
dWxlIGlzIG5vdCBwcmVzZW50LCB0aGUgUENJZSBjYW4gdG9vIGJlIGRpc2FibGVkLCBhbmQKPiBp
ZiB0aGVyZSBpcyBubyBzd2l0Y2ggbm9yIFNGUCBtb2R1bGUgcHJlc2VudCwgc28gY2FuIFNHTUlJ
MS4KCkluZGVlZCBub3QgYWxsIFBIWSB0eXBlcyBpbXBsZW1lbnQgLT5wb3dlcl9vZmYoKSAoc2Vl
IGluIEFURiBjb2RlKS4KQmV0dGVyIGFzayBNYXJ2ZWxsIGRpcmVjdGx5IGZvciB0aGF0LgoKPiAK
PiBUaGUgb3RoZXIgcmVhc29uIGlzIHRoaXM6IGlmIHRoZSBTR01JSSBwaHkgaXMgc2V0IHRvIDFH
IG1vZGUsIGFuZCB0aGVuCj4gcG93ZXJlZCBvbiBzZWNvbmQgdGltZSBpbiAyLjVHIG1vZGUsIHdp
bGwgaXQgd29yaz8gSSB3b3VsZCBsaWtlIHRvCgpUaGlzIHNob3VsZCB3b3JrLCB5ZXMuCgo+IHBh
dGNoIG12bmV0YSBkcml2ZXIgdG8gcG93ZXIgb24vb2ZmIHRoZSBjb21waHksIGlmIHRoZSBkZXZp
Y2Ugbm9kZSBpcwo+IHByZXNlbnQgaW4gZGV2aWNlIHRyZWUuIEJ1dCB0aGVuIHRoZSBzeXN0ZW0g
Y2FuIHJlcXVlc3Qgc3VjaCBhIGNoYW5nZQo+IChTR01JSSB0byAyNTAwQkFTRS1YIG9yIGJhY2sp
Lgo+IAo+IE1hcmVrCj4gCj4gT24gVHVlLCAxOCBEZWMgMjAxOCAxNDo0MTozMCArMDEwMAo+IE1p
cXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdyb3RlOgo+IAo+ID4gSGkg
TWFyZWssCj4gPiAKPiA+IE1hcmVrIEJlaHVuIDxtYXJlay5iZWh1bkBuaWMuY3o+IHdyb3RlIG9u
IFR1ZSwgMTggRGVjIDIwMTggMTQ6MDk6MjAKPiA+ICswMTAwOgo+ID4gICAKPiA+ID4gPiBbMl0K
PiA+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vQVJNLXNvZnR3YXJlL2FybS10cnVzdGVkLWZpcm13
YXJlL2Jsb2IvbWFzdGVyL2RyaXZlcnMvbWFydmVsbC9jb21waHkvcGh5LWNvbXBoeS0zNzAwLmMg
ICAgICAKPiA+ID4gCj4gPiA+IFllcywgSSB1c2VkIG1haW5saW5lIGF0ZiAoaXQgZGlkIG5vdCB3
b3JrIG91dCBvZiB0aGUgYm94IHdpdGggMTguMDkKPiA+ID4gYXRmLW1hcnZlbGwgb2YgY291cnNl
KS4gQnV0IHRoZXJlIGlzIG5vIF9wb3dlcl9vZmYgZnVuY3Rpb24gZm9yCj4gPiA+IFNHTUlJLCBu
b3IgYSBkaWdpdGFsX3Jlc2V0IGZ1bmN0aW9uIGxpa2UgaW4gY3AxMTAgaW1wbGVtZW50YXRpb24u
ICAgIAo+ID4gCj4gPiBJbmRlZWQsIGJ1dCB3aHkgd291bGQgeW91IG5lZWQgb25lPyBKdXN0IHVz
ZSB0aGUgaGVscGVycyBmcm9tIHRoZSBjb3JlCj4gPiBhbmQgaWYgdGhlcmUgaXMgbm8gaW1wbGVt
ZW50YXRpb24sIG5vdGhpbmcgc2hvdWxkIGhhcHBlbiBhbmQgdGhlCj4gPiBoZWxwZXIgc2hvdWxk
IGV4aXQgd2l0aG91dCBlcnJvci4gSnVzdCBjYWxsCj4gPiBwaHlfc2V0X21vZGUoKS9waHlfcG93
ZXJfb24oKSBhbiB5b3Ugc2hvdWxkIGJlIGdvb2QuCj4gPiAKPiA+IAo+ID4gVGhhbmtzLAo+ID4g
TWlxdcOobCAgCj4gCgpGb3IgdGhlIHJlY29yZCwgSSBmb3VuZCBvdXQgd2hhdCB3YXMgd3Jvbmcg
aW4gbXkgY29kZSwgdG9nZ2xpbmcgdGhlCnJlc2V0IGxpbmVzIGRvIG5vdCBwcm9kdWNlIHJhbmRv
bSBlZmZlY3RzIGFueW1vcmUuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
