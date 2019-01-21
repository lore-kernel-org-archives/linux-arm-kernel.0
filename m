Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46294C282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:12:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD42214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PPZQXKZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD42214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sZr4qI/mZOO8Smpfj4kx39FQnOMWXTp0KFIJGCJwT6Q=; b=PPZQXKZ69deZYo
	iK5M+dALRzTA1Fdyt17rQKNBnDULQ9s6btCwpoehNOR+nGtSqLIjjcocegwthbJszlzwFlPX7T1NS
	WBDmIIa1Zi4cJ/ee8rZI8Qz6CIy+DYxDdjDw2gx12uajp9e7muFb1Dc5KW5s1XRb5F39RBZiwmydw
	HMQs2OXRykasn2dybI/LYcJPlGxP3XaBNYk9JWnUIL3oxHj0u8q7lH1dG04Jza+7Cy/Fa35ALEyV3
	efMJMIWBZhPnf/t57ia7XOsz0DiysN3bXKpMglSCao8XHelXQhLpU1rPZLCSOxUZQlRaXSYaVqcYO
	5kfv08Pb2VR1ZuFhjQOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVd7-00052t-9r; Mon, 21 Jan 2019 09:12:29 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVbS-0003Ul-G3; Mon, 21 Jan 2019 09:10:52 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B65A420898; Mon, 21 Jan 2019 10:10:44 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 251FF2078C;
 Mon, 21 Jan 2019 10:10:30 +0100 (CET)
Date: Mon, 21 Jan 2019 10:10:30 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liang Yang <liang.yang@amlogic.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Amlogic NAND controller driver
Message-ID: <20190121101030.2efbee17@xps13>
In-Reply-To: <54e8156f-2362-21db-3e6c-e5b68147c49c@amlogic.com>
References: <1547917355-13179-1-git-send-email-jianxin.pan@amlogic.com>
 <20190120160605.33689354@xps13>
 <3f098e44-9d9b-3d0a-3e19-5913077aeb07@amlogic.com>
 <20190121092106.2c97ebe2@xps13>
 <54e8156f-2362-21db-3e6c-e5b68147c49c@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_011046_915785_09687453 
X-CRM114-Status: GOOD (  14.58  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 devicetree@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTGlhbmcsCgpMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZSBvbiBN
b24sIDIxIEphbiAyMDE5IDE2OjU5OjQyCiswODAwOgoKPiBIaSBNaXF1ZWzvvIwKPiAKPiBPbiAy
MDE5LzEvMjEgMTY6MjEsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gPiBIaSBKaWFueGluLAo+ID4g
Cj4gPiBKaWFueGluIFBhbiA8amlhbnhpbi5wYW5AYW1sb2dpYy5jb20+IHdyb3RlIG9uIE1vbiwg
MjEgSmFuIDIwMTkKPiA+IDEyOjE4OjE4ICswODAwOgo+ID4gICAKPiA+PiBIaSBNaXF1ZWwsCj4g
Pj4KPiA+PiBPbiAyMDE5LzEvMjAgMjM6MDYsIE1pcXVlbCBSYXluYWwgd3JvdGU6ICAKPiA+Pj4g
SGkgSmlhbnhpbiwKPiA+Pj4KPiA+Pj4gSmlhbnhpbiBQYW4gPGppYW54aW4ucGFuQGFtbG9naWMu
Y29tPiB3cm90ZSBvbiBTdW4sIDIwIEphbiAyMDE5Cj4gPj4+IDAxOjAyOjM1ICswODAwOiAgCj4g
Pj4+ICAgID4+Pj4gQWRkIGVudHJ5IGZvciBBbWxvZ2ljIE5BTkQgY29udHJvbGxlciBkcml2ZXIg
YW5kIGl0cyBiaW5kaW5nc1swXS4gIAo+ID4+Pj4KPiA+Pj4+IFswXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzE1NDc1NjY2ODQtNTc0NzItMS1naXQtc2VuZC1lbWFpbC1qaWFueGluLnBh
bkBhbWxvZ2ljLmNvbS8KPiA+Pj4+Cj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBZYW5nIDxs
aWFuZy55YW5nQGFtbG9naWMuY29tPgo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogSmlhbnhpbiBQYW4g
PGppYW54aW4ucGFuQGFtbG9naWMuY29tPiAgCj4gPj4+Cj4gPj4+IElmIHlvdSBhcmUgdGhlIGF1
dGhvciBvZiB0aGUgcGF0Y2ggeW91ciBTaWduZWQtb2ZmLWJ5IHNob3VsZCBjb21lIGZpcnN0LiAg
Cj4gPj4gT0suICAKPiA+Pj4KPiA+Pj4gQWxzbywgd2h5IGlzIExpYW5nIHRoZSBNYWludGFpbmVy
PyBXaHkgbm90IHlvdT8gIAo+ID4+PiAgICA+PiBZYW5nbGlhbmcgaXMgQW1sb2dpYyBtYWludGFp
bmVyIGZvciBOQU5EIGNvbnRyb2xsZXIuIEFuZCBhbGwgcGF0Y2hlcyBhYm91dCBhbWxvZ2ljIE5B
TkQgY29udHJvbGxlciBhcmUgZnJvbSBoaW0uICAKPiA+IAo+ID4gTWF5YmUgYnV0IGhlIG5ldmVy
IHdyb3RlIHRvIHRoZSBNTCwgdGhlIG1haW50YWluZXIgbWF5IGJlIHNvbWVvbmUgZWxzZQo+ID4g
dGhhbiB0aGUgb3JpZ2luYWwgYXV0aG9yLCBJIGp1c3Qgd2FudCBzb21lb25lIHRvIHJldmlldyBw
YXRjaGVzIGFuZAo+ID4gaGVscCB0byBtYWludGFpbiB0aGUgZHJpdmVyLgo+ID4gCj4gPiBZYW5n
bGlhbmcgYXJlIHlvdSB3aWxsaW5nIHRvIGRvIHRoYXQ/Cj4gPiBPZiBjb3Vyc2UuaXQgaXMgbXkg
cGxlYXN1cmUgYW5kIHJlc3BvbnNpYmlsaXR5LgoKT2sgdGhlbiwgaXQncyBmaW5lIGZvciBtZSEK
CgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
