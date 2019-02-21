Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18533C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:02:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5A22084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="img5ujNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5A22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0P+i5c0HpI5WjbjP4RH6LqXjCQaIlV1aGQa/azFCrX0=; b=img5ujNChe0bvt
	y/V9yZcsgPlrw2uKfk14UtjMaSPH1WtigQ2NUQ/v9CR79SFKG2hPRPSbOgH+PTPZjIdsrsRMx7NYH
	dnDYFbpktCzZ+alJosmkzkUEBb0ft87kzgc1P8ZPaWsg83W3RmOdVRsQold5NYnuNWhDp8Vj8NXGt
	sIlECvdh0zIhqVJ5XOV1AjPlAZQ2uF8hx1jZMGCL2/vI5B64cRRgNqjjLjFfmhKkBliFrcxNF1l24
	xk8/iwkLvXchOacJcgqH1IycCL4JIIwQ44sOjyalHjyYA53qfTGZDicy3qlyi3XwxISn0q2g1Hda1
	UaffP2xYsb7xfyhX270w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwow0-0004Ma-5F; Thu, 21 Feb 2019 14:02:44 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwovx-0004M8-Dc; Thu, 21 Feb 2019 14:02:43 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4D7EEE0009;
 Thu, 21 Feb 2019 14:02:25 +0000 (UTC)
Date: Thu, 21 Feb 2019 15:02:24 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Subject: Re: [RFC PATCH 16/27] mtd: nand: ecc: Let the software BCH ECC
 engine be a module
Message-ID: <20190221150224.7b01b553@xps13>
In-Reply-To: <CAHCN7xJhoEAjPchpp=-zEyyK1Ggzt24aQAX9ujfavdP329+ouw@mail.gmail.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-4-miquel.raynal@bootlin.com>
 <CAHCN7xJhoEAjPchpp=-zEyyK1Ggzt24aQAX9ujfavdP329+ouw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_060241_609760_80AC9ED8 
X-CRM114-Status: GOOD (  16.35  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>, Boris Brezillon <bbrezillon@kernel.org>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQWRhbSwKCkFkYW0gRm9yZCA8YWZvcmQxNzNAZ21haWwuY29tPiB3cm90ZSBvbiBUaHUsIDIx
IEZlYiAyMDE5IDA3OjQ4OjQ2IC0wNjAwOgoKPiBPbiBUaHUsIEZlYiAyMSwgMjAxOSBhdCA2OjU4
IEFNIE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdyb3RlOgo+ID4K
PiA+IFRoZXJlIGlzIG5vIHJlYXNvbiB0byBwcmV2ZW50IHRoZSBzb2Z0d2FyZSBCQ0ggRUNDIGVu
Z2luZQo+ID4gaW1wbGVtZW50YXRpb24gdG8gYmUgY29tcGlsZWQgYXMgYSBtb2R1bGUsIHNvIGNo
YW5nZSB0aGUgJ2Jvb2wnIGludG8gYQo+ID4gJ3RyaXN0YXRlJy4gIAo+IAo+IElmIHlvdSdyZSBi
b290aW5nIGZyb20gbmFuZCBhbmQgbmVlZCB0aGUgQkNIIGVuZ2luZSwgaXQgc2VlbXMgdG8gbWUK
PiBsaWtlIHlvdSdkIG5lZWQgaXQgdG8gYmUgY29tcGlsZWQgaW50byB0aGUga2VybmVsIGJlY2F1
c2UgeW91J2QgaGF2ZQo+IHRvIG1vdW50IHRoZSBmaWxlc3lzdGVtIGJlZm9yZSBsb2FkaW5nIHRo
ZSBtb2R1bGUgdW5sZXNzIHlvdSBoYXZlIGEKPiBpbml0cmFtZnMuICBJZiB5b3UgbmVlZCB0aGUg
QkNIIGVuZ2luZSB0byBtb3VudCB0aGUgZmlsZXN5c3RlbSwgaXQKPiBjcmVhdGVzIGEgZGVwZW5k
ZW5jeSBpc3N1ZS4KClRoYXQncyB0cnVlLCBJIGNvdWxkIG1lbnRpb24gdGhpcyB1c2UgY2FzZSBp
biB0aGUgY29tbWl0IGxvZy4gQnV0IHRoZQphY3Rpb24gb2YgY2hvb3NpbmcgdG8gY29tcGlsZSBp
dCBhcyBhIG1vZHVsZSBpcyBkb25lIGJ5IHRoZSB1c2VyLCBzbyBJCmd1ZXNzIHByZXZlbnRpbmcg
YW55IHVzZXIgdG8gdXNlIGl0IGFzIGEgbW9kdWxlIGlzIG5vbmV0aGVsZXNzIHRvbwpyZXN0cmlj
dGl2ZT8KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
