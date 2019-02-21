Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131632084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T7Apyqcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131632084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4uOWJACA3x/ixzK/Jt7h1n5TpPFY9c3gWmts2UAyyzw=; b=T7ApyqcdW56cku
	28YqW60N+xupHDERMmzH4mRSv97EMJAXG/e8i5uZN/ks7VicEhbwLtRfGjuiKF+4kym7/ZUrE4Kkp
	HMreIihLnS7Cvsbld067XSdv0Dp1Sc5/7HEZmg72dDFAFZ25Gy9njprRzk4nbCcZUA+R9stP88s8U
	2qlAtzF/UgnGfmSGMXrPvOs8/4MOTYDDJiZmsrRvXY26UMB+FNLDCA0caO04JUojEhjr+OzyUncTm
	dMMC6ykD4J8PW7iY/Nd6Lce77VualU2LhSJq+y/qPkmW3Pejo9KhIZELbFkLwbYZjDpBNHMUHQrwU
	6N7N/0oNhSH4Qp7INdHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoW5-00006u-A7; Thu, 21 Feb 2019 13:35:57 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwoW1-00006P-Kg; Thu, 21 Feb 2019 13:35:55 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8B7B740012;
 Thu, 21 Feb 2019 13:35:40 +0000 (UTC)
Date: Thu, 21 Feb 2019 14:35:39 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 17/27] mtd: nand: ecc: Let the software Hamming ECC
 engine be unselected
Message-ID: <20190221143539.65035bfa@xps13>
In-Reply-To: <20190221142002.5a160f87@kernel.org>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-5-miquel.raynal@bootlin.com>
 <20190221142002.5a160f87@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_053553_822930_7CA6D6FC 
X-CRM114-Status: GOOD (  19.83  )
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
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gVGh1LCAyMSBGZWIgMjAxOQoxNDoyMDowMiArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMzo1Nzo1NiArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gVGhlcmUgaXMgbm8gcmVhc29uIHRvIGFsd2F5cyBlbWJlZCB0aGUg
c29mdHdhcmUgSGFtbWluZyBFQ0MgZW5naW5lCj4gPiBpbXBsZW1lbnRhdGlvbi4gQnkgZGVmYXVs
dCBpdCBpcywgYnV0IHdlIGNhbiBsZXQgdGhlIHVzZXIgZGVjaWRlLgo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+ID4gLS0t
Cj4gPiAgZHJpdmVycy9tdGQvbmFuZC9lY2MvS2NvbmZpZyAgICAgICAgICAgICAgIHwgMTAgKysr
KystCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZpZyAgICAgICAgICAgICAgIHwgIDIg
Ky0KPiA+ICBpbmNsdWRlL2xpbnV4L210ZC9uYW5kLXN3LWhhbW1pbmctZW5naW5lLmggfCAzOCAr
KysrKysrKysrKysrKysrKysrKysrCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFu
ZC9lY2MvS2NvbmZpZyBiL2RyaXZlcnMvbXRkL25hbmQvZWNjL0tjb25maWcKPiA+IGluZGV4IGUw
MTA2YjNhN2VjMS4uZmYyMGU2MjFmZmVmIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9tdGQvbmFu
ZC9lY2MvS2NvbmZpZwo+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9lY2MvS2NvbmZpZwo+ID4g
QEAgLTEsNyArMSwxNSBAQAo+ID4gIG1lbnUgIkVDQyBlbmdpbmUgc3VwcG9ydCIKPiA+ICAKPiA+
ICBjb25maWcgTVREX05BTkRfRUNDX1NXX0hBTU1JTkcKPiA+IC0JdHJpc3RhdGUKPiA+ICsJdHJp
c3RhdGUgIlNvZnR3YXJlIEhhbW1pbmcgRUNDIGVuZ2luZSIKPiA+ICsJZGVmYXVsdCB5ICAKPiAK
PiBTYW1lIGFzIGZvciB0aGUgTkFORF9DT1JFIHN0dWZmLCBsZXQgdXNlcnMgdGhpcyBvcHRpb24g
d2hlbiB0aGV5IG5lZWQKPiBpdCBpbnN0ZWFkIG9mIGhhdmluZyBhICJkZWZhdWx0IHkiLiBIYXZl
bid0IG1hZGUgbXkgbWluZCB5ZXQgb24gd2hldGhlcgo+IHRoaXMgb3B0aW9uIHNob3VsZCBiZSB2
aXNpYmxlIHRvIHVzZXJzIG9yIG5vdC4gSSBndWVzcyBpdCBjb3VsZCBiZSB3aXRoCj4gdGhlIG5l
dyBpbmZyYXN0cnVjdHVyZSwgYnV0IGl0J3MgcHJvYmFibHkgdG9vIGVhcmx5IGluIHRoZSBwYXRj
aCBzZXJpZXMKPiB0byBjaGFuZ2UgdGhhdC4KClRoaXMgb25lIGlzIGRpZmZlcmVudC4KCkJlZm9y
ZSB0aGUgc2VyaWVzOiB0aGUgc29mdHdhcmUgSGFtbWluZyBFQ0MgYWxnb3JpdGhtIGlzIHBhcnQg
b2YgdGhlCidOQU5EIHBhY2thZ2UnLiBUaGVyZSBpcyBubyB3YXkgdG8gaWdub3JlIGl0LCBpdCAq
d2lsbCogYmUgcGFydCBvZiB5b3VyCmJpbmFyeSAob3IgbW9kdWxlKS4KCkFmdGVyIHRoZSBzZXJp
ZXM6IEkganVzdCBnaXZlIHRoZSB1c2VyIHRoZSBwb3NzaWJpbGl0eSB0byBkZXNlbGVjdAp0aGlz
IG9wdGlvbi4gQnV0IGhhdmluZyAnZGVmYXVsdCB5JyBpcyBtYW5kYXRvcnkgaGVyZSB0byBhdm9p
ZCBicmVha2luZwpjdXJyZW50IGRlZmNvbmZpZ3MuCgo+IAo+ID4gKwloZWxwCj4gPiArCSAgVGhp
cyBlbmFibGVzIHN1cHBvcnQgZm9yIHNvZnR3YXJlIEhhbW1pbmcgZXJyb3IKPiA+ICsJICBjb3Jy
ZWN0aW9uLiBUaGlzIGNvcnJlY3Rpb24gY2FuIGNvcnJlY3QgdXAgdG8gMSBiaXQgZXJyb3IKPiA+
ICsJICBwZXIgY2h1bmsgYW5kIGRldGVjdCB1cCB0byAyIGJpdCBlcnJvcnMuIFdoaWxlIGl0IHVz
ZWQgdG8gYmUKPiA+ICsJICB3aWRlbHkgdXNlZCB3aXRoIG9sZCBwYXJ0cywgbmV3ZXIgTkFORCBj
aGlwcyB1c3VhbGx5IHJlcXVpcmUKPiA+ICsJICBtb3JlIHN0cmVuZ3RoIGNvcnJlY3Rpb24gYW5k
IGluIHRoaXMgY2FzZSBCQ0ggb3IgUlMgd2lsbCBiZQo+ID4gKwkgIHByZWZlcnJlZC4KPiA+ICAg
IAoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
