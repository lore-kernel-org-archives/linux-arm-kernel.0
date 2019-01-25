Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D12C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:42:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC6B2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SeRFedM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC6B2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AsWvO2FRI0hM1KsrzPxPGwEkbs6cy1Luvrqe1ZrNxAM=; b=SeRFedM37/wgy0
	hSG7kLxpu3OtDNY+JwdQva6GhBpGTVGXxwFHrVFcMZgpzRhhZJduXS7yACZ5GCc2nR8XMfriVQhLZ
	ajnhwrTr8aLFVW9ABBaTgvuV/4KCntCkzAnHMtO/nqUGAJRQ9tdRPI2OoLEvL2RaYYnvDOrxri18F
	LgIqv03sqHAISTdYNOBn+7m8EdnydIIJxebfpRLVZ2uRLQwbzq7A64995nX4kyeg5WzEq+g1US9RN
	5uWYZonqI+vZJxrX0D4cBc0cKx5nR785w8n5amfdd7DI5xugouFXID+1cbF1qmpDSkS8iR8lr3KSP
	+xtcPsvdVJNqQNBHMklw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmy0l-0007Jf-EF; Fri, 25 Jan 2019 09:42:55 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmy0h-0007J9-V0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:42:53 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmy0c-0002bH-MG; Fri, 25 Jan 2019 10:42:46 +0100
Message-ID: <1548409366.28802.39.camel@pengutronix.de>
Subject: Re: [PATCH v4 1/5] dmaengine: imx-sdma: add clock ratio 1:1 check
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Fri, 25 Jan 2019 10:42:46 +0100
In-Reply-To: <20190125025528.15645-2-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
 <20190125025528.15645-2-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_014252_173650_FCAF533D 
X-CRM114-Status: GOOD (  16.94  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDI0LjAxLjIwMTksIDE5OjU1IC0wNzAwIHNjaHJpZWIgQW5ndXMg
QWluc2xpZSAoUHVyaXNtKToKPiBPbiBpLm14OCBtc2NhbGUgQjAgY2hpcCwgQUhCL1NETUEgY2xv
Y2sgcmF0aW8gMjoxIGNhbid0IGJlIHN1cHBvcnR0ZWQsCj4gc2luY2UgU0RNQSBjbG9jayByYXRp
byBoYXMgdG8gYmUgaW5jcmVhc2VkIHRvIDI1ME1oeiwgQUhCIGNhbid0IHJlYWNoCj4gdG8gNTAw
TWh6LCBzbyB1c2UgMToxIGluc3RlYWQuCj4gCj4gPiBCYXNlZCBvbiBOWFAgY29tbWl0IE1MSy0x
Njg0MS0xIGJ5IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4KPiAKPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuZ3VzIEFpbnNsaWUgKFB1cmlzbSkgPGFuZ3VzQGFra2VhLmNhPgo+IC0tLQo+IMKg
ZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDIxICsrKysrKysrKysrKysrKysrLS0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jCj4g
aW5kZXggMGIzYTY3ZmY4ZTgyLi41ZTVlZjBiNWE5NzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9k
bWEvaW14LXNkbWEuYwo+ICsrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKPiBAQCAtNDQwLDYg
KzQ0MCw4IEBAIHN0cnVjdCBzZG1hX2VuZ2luZSB7Cj4gPiA+IMKgCXVuc2lnbmVkIGludAkJCWly
cTsKPiA+ID4gwqAJZG1hX2FkZHJfdAkJCWJkMF9waHlzOwo+ID4gPiDCoAlzdHJ1Y3Qgc2RtYV9i
dWZmZXJfZGVzY3JpcHRvcgkqYmQwOwo+ID4gKwkvKiBjbG9jayByYXRpbyBmb3IgQUhCOlNETUEg
Y29yZS4gMToxIGlzIDEsIDI6MSBpcyAwKi8KPiA+ID4gKwlib29sCQkJCWNsa19yYXRpbzsKPiDC
oH07Cj4gwqAKPiDCoHN0YXRpYyBpbnQgc2RtYV9jb25maWdfd3JpdGUoc3RydWN0IGRtYV9jaGFu
ICpjaGFuLAo+IEBAIC02NjIsOCArNjY0LDE0IEBAIHN0YXRpYyBpbnQgc2RtYV9ydW5fY2hhbm5l
bDAoc3RydWN0IHNkbWFfZW5naW5lICpzZG1hKQo+ID4gwqAJCWRldl9lcnIoc2RtYS0+ZGV2LCAi
VGltZW91dCB3YWl0aW5nIGZvciBDSDAgcmVhZHlcbiIpOwo+IMKgCj4gPiDCoAkvKiBTZXQgYml0
cyBvZiBDT05GSUcgcmVnaXN0ZXIgd2l0aCBkeW5hbWljIGNvbnRleHQgc3dpdGNoaW5nICovCj4g
PiAtCWlmIChyZWFkbChzZG1hLT5yZWdzICsgU0RNQV9IX0NPTkZJRykgPT0gMCkKPiA+IC0JCXdy
aXRlbF9yZWxheGVkKFNETUFfSF9DT05GSUdfQ1NNLCBzZG1hLT5yZWdzICsgU0RNQV9IX0NPTkZJ
Ryk7Cj4gKwlpZiAoKHJlYWRsKHNkbWEtPnJlZ3MgKyBTRE1BX0hfQ09ORklHKSAmIH5TRE1BX0hf
Q09ORklHX0FDUikgPT0gMCkgewoKVGhlIGludGVudGlvbiBvZiB0aGlzIGNvZGUgd2FzIHByb2Jh
Ymx5IHRvIHNldCB0aGUgQ1NNIGJpdCBpZiB0aGV5CndlcmVuJ3Qgc2V0IGJlZm9yZSwgc28gbWFz
a2luZyBvdXQgaW5kaXZpZHVhbCBiaXRzIGZyb20gdGhlIHJlZ2lzdGVyCmFuZCByaXNraW5nIHRv
IHNraXAgdGhpcyB3aGVuIG9uZSBvZiB0aGUgb3RoZXIgYml0cyB3YXMgc2V0IGRvZXNuJ3QKc2Vl
bSByaWdodC4KCkkgZ3Vlc3MgdGhlIHdob2xlIGJsb2NrIGNhbiBiZSBzaW1wbGlmaWVkIHRvOgoK
cmVnID0gcmVhZGwoc2RtYS0+cmVncyArIFNETUFfSF9DT05GSUcpOwppZiAoKHJlZyAmIFNETUFf
SF9DT05GSUdfQ1NNKSAhPSBTRE1BX0hfQ09ORklHX0NTTSkKCXJlZyB8PSBTRE1BX0hfQ09ORklH
X0NTTTsKd3JpdGVsX3JlbGF4ZWQocmVnLCBzZG1hLT5yZWdzICsgU0RNQV9IX0NPTkZJRyk7CgpS
ZWdhcmRzLApMdWNhcwoKPiArCQlyZWcgPSBTRE1BX0hfQ09ORklHX0NTTTsKPiArCj4gPiArCQlp
ZiAoc2RtYS0+Y2xrX3JhdGlvKQo+ID4gKwkJCXJlZyB8PSBTRE1BX0hfQ09ORklHX0FDUjsKPiAr
Cj4gPiArCQl3cml0ZWxfcmVsYXhlZChyZWcsIHNkbWEtPnJlZ3MgKyBTRE1BX0hfQ09ORklHKTsK
PiA+ICsJfQo+IMKgCj4gPiDCoAlyZXR1cm4gcmV0Owo+IMKgfQo+IEBAIC0xODQwLDYgKzE4NDgs
OSBAQCBzdGF0aWMgaW50IHNkbWFfaW5pdChzdHJ1Y3Qgc2RtYV9lbmdpbmUgKnNkbWEpCj4gPiDC
oAlpZiAocmV0KQo+ID4gwqAJCWdvdG8gZGlzYWJsZV9jbGtfaXBnOwo+IMKgCj4gPiArCWlmIChj
bGtfZ2V0X3JhdGUoc2RtYS0+Y2xrX2FoYikgPT0gY2xrX2dldF9yYXRlKHNkbWEtPmNsa19pcGcp
KQo+ID4gKwkJc2RtYS0+Y2xrX3JhdGlvID0gMTsKPiArCj4gPiDCoAkvKiBCZSBzdXJlIFNETUEg
aGFzIG5vdCBzdGFydGVkIHlldCAqLwo+ID4gwqAJd3JpdGVsX3JlbGF4ZWQoMCwgc2RtYS0+cmVn
cyArIFNETUFfSF9DMFBUUik7Cj4gwqAKPiBAQCAtMTg4MCw4ICsxODkxLDEwIEBAIHN0YXRpYyBp
bnQgc2RtYV9pbml0KHN0cnVjdCBzZG1hX2VuZ2luZSAqc2RtYSkKPiA+IMKgCXdyaXRlbF9yZWxh
eGVkKDB4NDA1MCwgc2RtYS0+cmVncyArIFNETUFfQ0hOMEFERFIpOwo+IMKgCj4gPiDCoAkvKiBT
ZXQgYml0cyBvZiBDT05GSUcgcmVnaXN0ZXIgYnV0IHdpdGggc3RhdGljIGNvbnRleHQgc3dpdGNo
aW5nICovCj4gPiAtCS8qIEZJWE1FOiBDaGVjayB3aGV0aGVyIHRvIHNldCBBQ1IgYml0IGRlcGVu
ZGluZyBvbiBjbG9jayByYXRpb3MgKi8KPiA+IC0Jd3JpdGVsX3JlbGF4ZWQoMCwgc2RtYS0+cmVn
cyArIFNETUFfSF9DT05GSUcpOwo+ID4gKwlpZiAoc2RtYS0+Y2xrX3JhdGlvKQo+ID4gKwkJd3Jp
dGVsX3JlbGF4ZWQoU0RNQV9IX0NPTkZJR19BQ1IsIHNkbWEtPnJlZ3MgKyBTRE1BX0hfQ09ORklH
KTsKPiA+ICsJZWxzZQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQoMCwgc2RtYS0+cmVncyArIFNETUFf
SF9DT05GSUcpOwo+IMKgCj4gPiDCoAl3cml0ZWxfcmVsYXhlZChjY2JfcGh5cywgc2RtYS0+cmVn
cyArIFNETUFfSF9DMFBUUik7Cj4gwqAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
