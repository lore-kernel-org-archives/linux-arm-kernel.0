Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBC4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:46:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2642080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bw0Uu4OZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2642080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T9EiXugviMjpurxk96VD+gocbWWhMWQLf5c1QZrZ11E=; b=Bw0Uu4OZODAjxs
	WrAEJ20dhR13IN3gtSylAcbA8fMferV3VzEy0rxhYJITdW4lu/V61sQwmxIi2lqBwpIbZ0glu1A2R
	mk45ju15DkCWch4RaPrNNGmwtinrfqZTK6ngemY1EiJxCB0y34SYvCslZQ2N8ZLZtWrRmSB74RCg+
	7QI3dSEyXLhgtcAToxMtnm4nVNchG1lNpFyop0TCIq8HWgM1X/3whg/1XRXdSFEyn3mretoguN78n
	yRsv/LrjTNHaY0lK7yw27Wvv3QH/uYZE41gSHBDp9lvbVEVGKTCGPHyYxRw3u8s8A8I9DAhHEzAzq
	XlGVEQ3cqnY4/YLaZ1Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoga-00065j-2K; Thu, 21 Feb 2019 13:46:48 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwogV-00064x-5M; Thu, 21 Feb 2019 13:46:45 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 4A14F4001F;
 Thu, 21 Feb 2019 13:46:39 +0000 (UTC)
Date: Thu, 21 Feb 2019 14:46:38 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 17/27] mtd: nand: ecc: Let the software Hamming ECC
 engine be unselected
Message-ID: <20190221144638.5f3ee481@xps13>
In-Reply-To: <20190221144148.6313d2ba@kernel.org>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-5-miquel.raynal@bootlin.com>
 <20190221142002.5a160f87@kernel.org>
 <20190221143539.65035bfa@xps13>
 <20190221144148.6313d2ba@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_054643_509620_FA5B56DC 
X-CRM114-Status: GOOD (  25.18  )
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
b24gVGh1LCAyMSBGZWIgMjAxOQoxNDo0MTo0OCArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxNDozNTozOSArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gSGkgQm9yaXMsCj4gPiAKPiA+IEJvcmlzIEJyZXppbGxvbiA8YmJy
ZXppbGxvbkBrZXJuZWwub3JnPiB3cm90ZSBvbiBUaHUsIDIxIEZlYiAyMDE5Cj4gPiAxNDoyMDow
MiArMDEwMDoKPiA+ICAgCj4gPiA+IE9uIFRodSwgMjEgRmViIDIwMTkgMTM6NTc6NTYgKzAxMDAK
PiA+ID4gTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4gd3JvdGU6Cj4g
PiA+ICAgICAKPiA+ID4gPiBUaGVyZSBpcyBubyByZWFzb24gdG8gYWx3YXlzIGVtYmVkIHRoZSBz
b2Z0d2FyZSBIYW1taW5nIEVDQyBlbmdpbmUKPiA+ID4gPiBpbXBsZW1lbnRhdGlvbi4gQnkgZGVm
YXVsdCBpdCBpcywgYnV0IHdlIGNhbiBsZXQgdGhlIHVzZXIgZGVjaWRlLgo+ID4gPiA+IAo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvZWNjL0tjb25maWcgICAg
ICAgICAgICAgICB8IDEwICsrKysrLQo+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9LY29u
ZmlnICAgICAgICAgICAgICAgfCAgMiArLQo+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L210ZC9uYW5k
LXN3LWhhbW1pbmctZW5naW5lLmggfCAzOCArKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4g
PiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9lY2MvS2NvbmZpZyBiL2Ry
aXZlcnMvbXRkL25hbmQvZWNjL0tjb25maWcKPiA+ID4gPiBpbmRleCBlMDEwNmIzYTdlYzEuLmZm
MjBlNjIxZmZlZiAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL2VjYy9LY29u
ZmlnCj4gPiA+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9lY2MvS2NvbmZpZwo+ID4gPiA+IEBA
IC0xLDcgKzEsMTUgQEAKPiA+ID4gPiAgbWVudSAiRUNDIGVuZ2luZSBzdXBwb3J0Igo+ID4gPiA+
ICAKPiA+ID4gPiAgY29uZmlnIE1URF9OQU5EX0VDQ19TV19IQU1NSU5HCj4gPiA+ID4gLQl0cmlz
dGF0ZQo+ID4gPiA+ICsJdHJpc3RhdGUgIlNvZnR3YXJlIEhhbW1pbmcgRUNDIGVuZ2luZSIKPiA+
ID4gPiArCWRlZmF1bHQgeSAgICAgIAo+ID4gPiAKPiA+ID4gU2FtZSBhcyBmb3IgdGhlIE5BTkRf
Q09SRSBzdHVmZiwgbGV0IHVzZXJzIHRoaXMgb3B0aW9uIHdoZW4gdGhleSBuZWVkCj4gPiA+IGl0
IGluc3RlYWQgb2YgaGF2aW5nIGEgImRlZmF1bHQgeSIuIEhhdmVuJ3QgbWFkZSBteSBtaW5kIHll
dCBvbiB3aGV0aGVyCj4gPiA+IHRoaXMgb3B0aW9uIHNob3VsZCBiZSB2aXNpYmxlIHRvIHVzZXJz
IG9yIG5vdC4gSSBndWVzcyBpdCBjb3VsZCBiZSB3aXRoCj4gPiA+IHRoZSBuZXcgaW5mcmFzdHJ1
Y3R1cmUsIGJ1dCBpdCdzIHByb2JhYmx5IHRvbyBlYXJseSBpbiB0aGUgcGF0Y2ggc2VyaWVzCj4g
PiA+IHRvIGNoYW5nZSB0aGF0LiAgICAKPiA+IAo+ID4gVGhpcyBvbmUgaXMgZGlmZmVyZW50Lgo+
ID4gCj4gPiBCZWZvcmUgdGhlIHNlcmllczogdGhlIHNvZnR3YXJlIEhhbW1pbmcgRUNDIGFsZ29y
aXRobSBpcyBwYXJ0IG9mIHRoZQo+ID4gJ05BTkQgcGFja2FnZScuIFRoZXJlIGlzIG5vIHdheSB0
byBpZ25vcmUgaXQsIGl0ICp3aWxsKiBiZSBwYXJ0IG9mIHlvdXIKPiA+IGJpbmFyeSAob3IgbW9k
dWxlKS4KPiA+IAo+ID4gQWZ0ZXIgdGhlIHNlcmllczogSSBqdXN0IGdpdmUgdGhlIHVzZXIgdGhl
IHBvc3NpYmlsaXR5IHRvIGRlc2VsZWN0Cj4gPiB0aGlzIG9wdGlvbi4gQnV0IGhhdmluZyAnZGVm
YXVsdCB5JyBpcyBtYW5kYXRvcnkgaGVyZSB0byBhdm9pZCBicmVha2luZwo+ID4gY3VycmVudCBk
ZWZjb25maWdzLiAgCj4gCj4gT2theSwgdGhlbiBtYXliZQo+IAo+IAlkZWZhdWx0IHkgaWYgTVRE
X1JBV19OQU5ECgpSaWdodCwgdGhpcyBpcyBtb3JlIGFjY3VyYXRlLgoKPiAKPiBBbmQgSSB0aGlu
ayB5b3Ugc2hvdWxkIHNlbGVjdCB0aGUgb3B0aW9uIGluIE1URF9OQU5EX05ERkMgaW5zdGVhZCBv
Zgo+IGFkZGluZyBhIGRlcGVuZHMgb24uIAoKQWNrLgoKPiAKPiA+ICAgCj4gPiA+ICAgICAKPiA+
ID4gPiArCWhlbHAKPiA+ID4gPiArCSAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIHNvZnR3YXJl
IEhhbW1pbmcgZXJyb3IKPiA+ID4gPiArCSAgY29ycmVjdGlvbi4gVGhpcyBjb3JyZWN0aW9uIGNh
biBjb3JyZWN0IHVwIHRvIDEgYml0IGVycm9yCj4gPiA+ID4gKwkgIHBlciBjaHVuayBhbmQgZGV0
ZWN0IHVwIHRvIDIgYml0IGVycm9ycy4gV2hpbGUgaXQgdXNlZCB0byBiZQo+ID4gPiA+ICsJICB3
aWRlbHkgdXNlZCB3aXRoIG9sZCBwYXJ0cywgbmV3ZXIgTkFORCBjaGlwcyB1c3VhbGx5IHJlcXVp
cmUKPiA+ID4gPiArCSAgbW9yZSBzdHJlbmd0aCBjb3JyZWN0aW9uIGFuZCBpbiB0aGlzIGNhc2Ug
QkNIIG9yIFJTIHdpbGwgYmUKPiA+ID4gPiArCSAgcHJlZmVycmVkLgo+ID4gPiA+ICAgICAgICAK
PiA+IAo+ID4gCj4gPiBUaGFua3MsCj4gPiBNaXF1w6hsICAKPiAKCgoKClRoYW5rcywKTWlxdcOo
bAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
