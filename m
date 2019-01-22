Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C85C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:13:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBFF21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+YniG/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBFF21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uXNjLX2A98btopzmUFPC7aOO7exMPNJaIFksOrEiVdQ=; b=h+YniG/h0bF8Hp
	xoAQnMREzweBNn0DkblGXvDWvJdMZ7g2egExHlTIvuv0fKDBOxKtnzCdUIjseis6VDzLvrpIbYoGk
	bjFaZyhfbwgzwU5CtCg4QKL9kIDCWTYE7Iywc6RHlAzyAqm3noEAd5I26S303XqOtUTwXMu66ElGw
	JLq5pZFffg/Rj4CA7E26smlpN4tPsjoSNCqpn1/ZVRNyP8Tmj0QqFCnbXg6EsVQ1mKrsnAk8fDNAB
	ORCNgIhS+cu8cQpOilXEWt57Qt1/M0MEPhBpfwaakDLmOSxgXJiB4dyXlbp6OaTZwDsyWxGLPtvy7
	5CnJ39Hd/vf3/hnpvqvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glyfz-0006jv-7i; Tue, 22 Jan 2019 16:13:23 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glyfv-0006jY-Kh
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 16:13:21 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 79E06206DC; Tue, 22 Jan 2019 17:13:17 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 14003206A6;
 Tue, 22 Jan 2019 17:13:07 +0100 (CET)
Date: Tue, 22 Jan 2019 17:13:07 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
Message-ID: <20190122171307.3dc956b6@xps13>
In-Reply-To: <CAL_JsqLQ+7VZ--n17aDAFS4v1fMOKKPprs9fVVASy9yt=_mR2w@mail.gmail.com>
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
 <20190121112336.23489-7-miquel.raynal@bootlin.com>
 <20190121154451.GA28183@bogus> <87r2d6ko6e.fsf@FE-laptop>
 <CAL_JsqLQ+7VZ--n17aDAFS4v1fMOKKPprs9fVVASy9yt=_mR2w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_081319_817298_AEE2E547 
X-CRM114-Status: GOOD (  16.45  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Linux USB List <linux-usb@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiB3cm90ZSBvbiBUdWUsIDIyIEph
biAyMDE5IDEwOjA4OjQxIC0wNjAwOgoKPiBPbiBNb24sIEphbiAyMSwgMjAxOSBhdCA5OjQ5IEFN
IEdyZWdvcnkgQ0xFTUVOVAo+IDxncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+IHdyb3RlOgo+
ID4KPiA+IEhpIFJvYiwKPiA+Cj4gPiAgT24gbHVuLiwgamFudi4gMjEgMjAxOSwgUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiAgCj4gPiA+IE9uIE1vbiwgMjEgSmFuIDIw
MTkgMTI6MjM6MzIgKzAxMDAsIE1pcXVlbCBSYXluYWwgd3JvdGU6ICAKPiA+ID4+IEFkZCBiaW5k
aW5ncyBmb3IgTWFydmVsbCBBcm1hZGEgMzcwMCBVU0IyIFVUTUkrIFBIWS4KPiA+ID4+Cj4gPiA+
PiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29t
Pgo+ID4gPj4gLS0tCj4gPiA+PiAgLi4uL2JpbmRpbmdzL3BoeS9waHktbXZlYnUtdXRtaS50eHQg
ICAgICAgICAgIHwgMzggKysrKysrKysrKysrKysrKysrKwo+ID4gPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzOCBpbnNlcnRpb25zKCspCj4gPiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW12ZWJ1LXV0bWkudHh0Cj4gPiA+PiAgCj4g
Pgo+ID4gSSBmb3VuZCAibWFydmVsbCx1c2IyLWhvc3QtbWlzY2VsbGFuZW91cyIgdG9vIGdlbmVy
aWMsIEkgd291bGQgcHJlZmVyCj4gPiB0aGF0IHdlIGNhbGwgaXQgIm1hcnZlbGwsYXJtYWRhLTM3
MDAtdXNiMi1ob3N0LW1pc2NlbGxhbmVvdXMiIGFzIHdlIGRvCj4gPiBmb3IgYWxsIHRoZSBvdGhl
ciBJUC4gIAo+IAo+IEFoIHllcywgeW91IGFyZSByaWdodC4gUGVyaGFwcyBqdXN0ICctbWlzYycg
dG8gc2hvcnRlbiBpdCBhIGxpdHRsZSBiaXQuCj4gCj4gUm9iCgpTdXJlLCBubyBwcm9ibGVtLgoK
SSB3aWxsIHdhaXQgZm9yIG90aGVyIGNvbW1lbnRzIG9uIHRoZSByZXN0IG9mIHRoZSBzZXJpZXMg
YW5kIHRoZW4gSQp3aWxsIHVwZGF0ZSB0aGUgYmluZGluZ3MvRFQgcGF0Y2guIFBlcmhhcHMgaWYg
SSBkb24ndCBnZXQgbW9yZQpmZWVkYmFjayBJIHdpbGwganVzdCByZXNlbmQgdGhlIGNvbmNlcm5l
ZCBwYXRjaGVzICg2LzEwIGFuZCA5LzEwKS4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
