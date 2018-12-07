Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74822C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:04:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AD520838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kUEOOnSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AD520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FLkcRuMKru9oFmfeImy7rmnOBWJ5ZFU1k+V/zAzlRGo=; b=kUEOOnSLHWgtKV
	vjjNGV98cjMJ5pc4lJ9MHWbkoySoNGgHB0WSqutwxdhuq2mTogmrB+RAjId5A6gRahhWbICnnbw0W
	RQ7Edx7IgNRVK3pcfHAibIyrUkAPitLDkXmdK1vzZvO57RL2nQrL9pO1b+RvaZyulUzcrwUPPJl2l
	kW9HG8w3qx1hL/Q23cvwfU7Ujyht9tvl/33TqDOcbyyVggYvhW38bvbRBBlb8CwygKPpnw/dWLlVw
	M7kZhSi7xAcVIZWSubePgt5jPvUGs46ad7vP0Zr3C1mGOK/OXyZHDRXzjGlfaa8rUCFnjAOgJW07q
	pSlcO5EgAdS/9uutjMcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVB7z-000588-5Y; Fri, 07 Dec 2018 08:04:51 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVB7w-00057C-Dg; Fri, 07 Dec 2018 08:04:49 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1C6D120834; Fri,  7 Dec 2018 09:04:37 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id A8BB52073D;
 Fri,  7 Dec 2018 09:04:26 +0100 (CET)
Date: Fri, 7 Dec 2018 09:04:25 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Subject: [PATCH v4 0/4] mtd: rawnand: ams-delta: Use GPIO API
 for data I/O
Message-ID: <20181207090425.4480d2c0@xps13>
In-Reply-To: <20181123170333.GH53235@atomide.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
 <20181121155639.77873f7f@bbrezillon>
 <20181123170333.GH53235@atomide.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_000448_598037_3C2E71D8 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Marek Vasut <marek.vasut@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVG9ueSwKClRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IHdyb3RlIG9uIEZyaSwg
MjMgTm92IDIwMTggMDk6MDM6MzMKLTA4MDA6Cgo+ICogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5i
cmV6aWxsb25AYm9vdGxpbi5jb20+IFsxODExMjEgMTQ6NTZdOgo+ID4gT24gV2VkLCAyMSBOb3Yg
MjAxOCAxMjowODowMiArMDEwMAo+ID4gSmFudXN6IEtyenlzenRvZmlrIDxqbWtyenlzenRAZ21h
aWwuY29tPiB3cm90ZToKPiA+ICAgCj4gPiA+IEZpbmFsaXplIGltcGxlbWVudGF0aW9uIG9mIHRo
ZSBpZGVhIHN1Z2dlc3RlZCBieSBBcnRlbSBCaXR5dXRza2l5IGFuZAo+ID4gPiBUb255IExpbmRn
cmVuLCBkZXNjcmliZWQgaW4gY29tbWl0IGIwMjcyNzRkMmUzYSAoIm10ZDogYW1zLWRlbHRhOiBm
aXgKPiA+ID4gcmVxdWVzdF9tZW1fcmVnaW9uKCkgZmFpbHVyZSIpLiBVc2UgcHVyZSBHUElPIGNv
bnN1bWVyIEFQSSwgYXMgcmVxZXN0ZWQKPiA+ID4gYnkgQm9yaXMgQnJlemlsbG9uLgo+ID4gPiAK
PiA+ID4gSmFudXN6IEtyenlzenRvZmlrICg0KToKPiA+ID4gICAgICAgQVJNOiBPTUFQMTogYW1z
LWRlbHRhOiBQcm92aWRlIEdQSU8gbG9va3VwIHRhYmxlIGZvciBOQU5EIGRhdGEgcG9ydAo+ID4g
PiAgICAgICBtdGQ6IHJhd25hbmQ6IGFtcy1kZWx0YTogUmVxdWVzdCBkYXRhIHBvcnQgR1BJTyBy
ZXNvdXJjZQo+ID4gPiAgICAgICBtdGQ6IHJhd25hbmQ6IGFtcy1kZWx0YTogVXNlIEdQSU8gQVBJ
IGZvciBkYXRhIEkvTwo+ID4gPiAgICAgICBBUk06IE9NQVAxOiBhbXMtZGVsdGE6IERyb3Agb2Jz
b2xldGUgTkFORCByZXNvdXJjZXMKPiA+ID4gCj4gPiA+ICBhcmNoL2FybS9tYWNoLW9tYXAxL2Jv
YXJkLWFtcy1kZWx0YS5jIHwgICAyMiArKy0tLS0KPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3
L2Ftcy1kZWx0YS5jICAgICAgfCAgMTIwICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgNjIgZGVsZXRpb25z
KC0pCj4gPiA+IAo+ID4gPiBQZXJmb3JtYW5jZSBvbiBBbXN0cmFkIERlbHRhIGlzIG5vdyBhY2Nl
cHRhYmxlIGFmdGVyIHJlY2VudCBleHRlbnNpb25zCj4gPiA+IHRvIEdQSU8gQVBJIGFuZCByYXdu
YW5hZCBlbmhhbmNlbWVudHMuCj4gPiA+IAo+ID4gPiBTZXJpZXMgaW50ZW50ZWQgdG8gYmUgbWVy
Z2VkIHZpYSBtdGQgdHJlZSwgc2hvdWxkIG5vdCBjb25mbGljdCB3aXRoCj4gPiA+IG90aGVyIE9N
QVAxIHBhdGNoZXMgc3VibWl0dGVkIGZvciA0LjIxLiAgCj4gPiAKPiA+IFdlJ2xsIHByZXBhcmUg
YW4gaW1tdXRhYmxlIHRhZywganVzdCBpbiBjYXNlLiAgCj4gCj4gU291bmRzIGdvb2QgdG8gbWUg
dGhhbmtzOgo+IAo+IEFja2VkLWJ5OiBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPgoK
QWN0dWFsbHksIEkgY2FuJ3Qgc2V0dXAgYSB0b3BpYyBicmFuY2ggd2l0aCB0aGlzIHNlcmllcyBi
ZWNhdXNlIGl0CmRlcGVuZHMgb24gb3RoZXIgY2hhbmdlcyBpbiBuYW5kL25leHQuIElmIGEgY29u
ZmxpY3QgaGFwcGVucyBpbiAtbmV4dCwKSSBzdXBwb3NlIHdlIHdpbGwgaGF2ZSB0byBzZW5kIHlv
dSBhIFBSLgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
