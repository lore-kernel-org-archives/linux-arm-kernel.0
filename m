Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1728BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:46:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA97E20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="epmnUcC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA97E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8CjlPo2kwF3kDmL1urbqUdKz+54+XSEs3k47b8kkSVs=; b=epmnUcC8GB1DD2
	TwgxNH9J6HDVPPUi4GsW0x2I0E4Beehsq5PUD1G6t04RJY5L8k3GMY4O7Vr/uB6b+U+lFE8FcaJ5g
	p67MmZ65sIohLHDBG1OHENlQbydRWItQP0drfYic9WDBAXMg3NHSMqksA8HQtGKVnNtbAw8Z/j/Wm
	bJryJUoJE4rBEJSMOBUQZ6xs0XtEIQ4tZ4GESxFxuaxYsY/kiIN1neBf7DrTk9oXzqViEJWEOoIB7
	Htx1xRN1Wc/hGEnFoM0VxpY634gdVsHjdi9WybQpqzIVZVrkqMLqeyygZ6eWfgAdXouImoeUKavy6
	0GALZNN+HuEeGEDT+DuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpUp-0000rY-2b; Mon, 03 Dec 2018 14:46:51 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpUk-0000qu-SX
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:46:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 7201F2072A; Mon,  3 Dec 2018 15:46:35 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0E95F206A1;
 Mon,  3 Dec 2018 15:46:35 +0100 (CET)
Date: Mon, 3 Dec 2018 15:46:35 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/6] ata: libahci_platform: comply to PHY framework
Message-ID: <20181203154635.3c6df0d3@xps13>
In-Reply-To: <0517746d-3fca-db57-8dca-8976910dad9c@redhat.com>
References: <20181130153833.11421-1-miquel.raynal@bootlin.com>
 <20181130153833.11421-2-miquel.raynal@bootlin.com>
 <0517746d-3fca-db57-8dca-8976910dad9c@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_064647_197167_E46F17E5 
X-CRM114-Status: GOOD (  28.77  )
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
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSGFucywKCkhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IHdyb3RlIG9uIFN1
biwgMiBEZWMgMjAxOCAxNDoxOTo0OQorMDEwMDoKCj4gSGksCj4gCj4gT24gMzAtMTEtMTggMTY6
MzgsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gPiBDdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHRo
ZSBsaWJhaGNpIGRvZXMgbm90IHRha2UgaW50byBhY2NvdW50IHRoZQo+ID4gbmV3IFBIWSBmcmFt
ZXdvcmsuIENvcnJlY3QgdGhlIHNpdHVhdGlvbiBieSBhZGRpbmcgYSBjYWxsIHRvCj4gPiBwaHlf
c2V0X21vZGUoKSBiZWZvcmUgcGh5X3Bvd2VyX29uKCkgYW5kIGJ5IGFkZGluZyBjYWxscyB0bwo+
ID4gYWhjaV9wbGF0Zm9ybV9lbmFibGUvZGlzYWJsZV9waHlzKCkgYXQgc3VzcGVuZC9yZXN1bWVf
aG9zdCgpIHRpbWUuCj4gPiAKPiA+IFN1Z2dlc3RlZC1ieTogR3J6ZWdvcnogSmFzemN6eWsgPGph
ekBzZW1paGFsZi5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwu
cmF5bmFsQGJvb3RsaW4uY29tPiAgCj4gCj4gTXVjaCBiZXR0ZXIuIFNvbWUgcmVtYXJrcyBpbmxp
bmUuCj4gCj4gPiAtLS0KPiA+ICAgZHJpdmVycy9hdGEvYWhjaS5oICAgICAgICAgICAgIHwgIDIg
KysKPiA+ICAgZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5jIHwgMTkgKysrKysrKysrKysr
KysrKysrLQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2FoY2kuaCBiL2RyaXZlcnMv
YXRhL2FoY2kuaAo+ID4gaW5kZXggZWYzNTZlNzBlNmRlLi45ODI2MzhiMzdmZWUgMTAwNjQ0Cj4g
PiAtLS0gYS9kcml2ZXJzL2F0YS9haGNpLmgKPiA+ICsrKyBiL2RyaXZlcnMvYXRhL2FoY2kuaAo+
ID4gQEAgLTI1NCw2ICsyNTQsOCBAQCBlbnVtIHsKPiA+ICAgCUFIQ0lfSEZMQUdfSVNfTU9CSUxF
CQk9ICgxIDw8IDI1KSwgLyogbW9iaWxlIGNoaXBzZXQsIHVzZQo+ID4gICAJCQkJCQkJU0FUQV9N
T0JJTEVfTFBNX1BPTElDWQo+ID4gICAJCQkJCQkJYXMgZGVmYXVsdCBscG1fcG9saWN5ICovCj4g
PiArCUFIQ0lfSEZMQUdfTUFOQUdFX1BIWVMJCT0gKDEgPDwgMjYpLCAvKiBsZXQgdGhlIGNvcmUg
bWFuYWdlIHRoZQo+ID4gKwkJCQkJCQlQSFlzIHdoZW4gcmVsZXZhbnQgKi8gIAo+IAo+IFVzaW5n
IGEgaGZsYWcgZm9yIHRoaXMgaXMgYSBnb29kIGlkZWEsIGJ1dCB0aGUgTUFOQUdFX1BIWVMgbmFt
ZXMgaXMgYSBiaXQKPiBnZW5lcmljLCBldmVuIGlmIHRoaXMgaXMgbm90IHNldCB0aGVuIGFoY2lf
cGxhdGZvcm1fZW5hYmxlX3Jlc291cmNlcygpIHdpbGwKPiBzdGlsbCBlbmFibGUgdGhlIHBoeS4g
U28gSSB3b3VsZCBuYW1lIHRoaXMgQUhDSV9IRkxBR19TVVNQRU5EX1BIWVMgdG8gbWFrZQo+IGNs
ZWFyIHRoaXMgb25seSBpbmZsdWVuY2VzIHN1c3BlbmQvcmVzdW1lIGJlaGF2aW9yLgoKSSB1bmRl
cnN0YW5kIGFuZCB3aWxsIG1vZGlmeSB0aGUgSEZMQUcgbmFtZSBhcyB5b3Ugc3VnZ2VzdC4KCj4g
Cj4gQWxzbyBzZWUgYmVsb3cuCj4gCj4gPiAgIAkvKiBhcC0+ZmxhZ3MgYml0cyAqLyAgCj4gPiAg
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYyBiL2RyaXZlcnMv
YXRhL2xpYmFoY2lfcGxhdGZvcm0uYyAgCj4gPiBpbmRleCA0YjkwMGZjNjU5ZjcuLmY1YTY0ZWIx
ZmVhOCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYwo+ID4g
KysrIGIvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5jCj4gPiBAQCAtNTYsNiArNTYsMTIg
QEAgc3RhdGljIGludCBhaGNpX3BsYXRmb3JtX2VuYWJsZV9waHlzKHN0cnVjdCBhaGNpX2hvc3Rf
cHJpdiAqaHByaXYpCj4gPiAgIAkJaWYgKHJjKQo+ID4gICAJCQlnb3RvIGRpc2FibGVfcGh5czsg
IAo+ID4gICA+ICsJCXJjID0gcGh5X3NldF9tb2RlKGhwcml2LT5waHlzW2ldLCBQSFlfTU9ERV9T
QVRBKTsgIAo+ID4gKwkJaWYgKHJjKSB7Cj4gPiArCQkJcGh5X2V4aXQoaHByaXYtPnBoeXNbaV0p
Owo+ID4gKwkJCWdvdG8gZGlzYWJsZV9waHlzOwo+ID4gKwkJfQo+ID4gKwo+ID4gICAJCXJjID0g
cGh5X3Bvd2VyX29uKGhwcml2LT5waHlzW2ldKTsKPiA+ICAgCQlpZiAocmMpIHsKPiA+ICAgCQkJ
cGh5X2V4aXQoaHByaXYtPnBoeXNbaV0pOwo+ID4gQEAgLTM3OCw3ICszODQsOCBAQCBzdGF0aWMg
aW50IGFoY2lfcGxhdGZvcm1fZ2V0X3JlZ3VsYXRvcihzdHJ1Y3QgYWhjaV9ob3N0X3ByaXYgKmhw
cml2LCB1MzIgcG9ydCwKPiA+ICAgICogMykgMCAtIEFIQ0lfTUFYX0NMS1MgY2xvY2tzLCBhcyBz
cGVjaWZpZWQgaW4gdGhlIGRldnMgZGV2aWNldHJlZSBub2RlLAo+ID4gICAgKiAgICBvciBmb3Ig
bm9uIGRldmljZXRyZWUgZW5hYmxlZCBwbGF0Zm9ybXMgYSBzaW5nbGUgY2xvY2sKPiA+ICAgICog
NCkgcmVzZXRzLCBpZiBmbGFncyBoYXMgQUhDSV9QTEFURk9STV9HRVRfUkVTRVRTIChvcHRpb25h
bCkKPiA+IC0gKiA1KSBwaHlzIChvcHRpb25hbCkKPiA+ICsgKiA1KSBwaHlzIChvcHRpb25hbCks
IFBIWSBoYW5kbGluZyBkdXJpbmcgc3VzcGVuZC9yZXN1bWUgd2lsbCBiZSBza2lwcGVkIGlmIHRo
ZQo+ID4gKyAqICAgIGZsYWcgQUhDSV9IRkxBR19NQU5BR0VfUEhZUyBpcyBtaXNzaW5nLgo+ID4g
ICAgKgo+ID4gICAgKiBSRVRVUk5TOgo+ID4gICAgKiBUaGUgYWxsb2NhdGVkIGFoY2lfaG9zdF9w
cml2IG9uIHN1Y2Nlc3MsIG90aGVyd2lzZSBhbiBFUlJfUFRSIHZhbHVlCj4gPiBAQCAtNDU4LDYg
KzQ2NSw5IEBAIHN0cnVjdCBhaGNpX2hvc3RfcHJpdiAqYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2VzKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCj4gPiAgIAkJfQo+ID4gICAJfSAgCj4g
PiAgID4gKwlpZiAoZmxhZ3MgJiBBSENJX0hGTEFHX01BTkFHRV9QSFlTKSAgCj4gPiArCQlocHJp
di0+ZmxhZ3MgfD0gQUhDSV9IRkxBR19NQU5BR0VfUEhZUzsKPiA+ICsKPiA+ICAgCWhwcml2LT5u
cG9ydHMgPSBjaGlsZF9ub2RlcyA9IG9mX2dldF9jaGlsZF9jb3VudChkZXYtPm9mX25vZGUpOyAg
Cj4gPiAgID4gICAJLyogIAo+IAo+IEludGVycHJldGluZyBhIGZsYWcgcGFzc2VkIHRvIGFoY2lf
cGxhdGZvcm1fZ2V0X3Jlc291cmNlcyB1c2luZyBhCj4gQUhDSV9IRkxBR18qIG1hc2sgaXMgYXNr
aW5nIGZvciB0cm91YmxlIGluIHRoZSBmdXR1cmUuCj4gCj4gU2luY2UgeW91IGFyZSB1c2luZyBh
IGhmbGFnIGZvciB0aGlzLCB5b3UgY2FuIGp1c3QgZHJvcCB0aGlzIGNodW5rIC8gY2hhbmdlCj4g
YW5kIGluIHRoZSBjYWxsZXIgb2YgYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2VzKCkgZG86Cj4g
Cj4gCWhwcml2ID0gYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2VzKHBkZXYsIC4uLik7Cj4gCWlm
IChJU19FUlIoaHByaXYpKQo+IAkJLi4uCj4gCj4gCWhwcml2LT5mbGFncyB8PSBBSENJX0hGTEFH
X01BTkFHRV9QSFlTOwo+IAo+IFNldHR0aW5nIGhmbGFncyBsaWtlIHRoaXMgYWZ0ZXIgY2FsbGlu
ZyBhaGNpX3BsYXRmb3JtX2dldF9yZXNvdXJjZXMoKQo+IGlzIGFscmVhZHkgZG9uZSBpbiBzZXZl
cmFsIHBsYWNlLgoKSW5kZWVkLCB0aGlzIGlzIGNsb3NlIHRvIG15IGZpcnN0IGRyYWZ0IGJ1dCBh
ZnRlciByZS1yZWFkaW5nIHlvdXIKcHJldmlvdXMgcmV2aWV3IEkgdW5kZXJzdG9vZCB5b3Ugd2Fu
dGVkIHRoaXMgZmxhZyB0byBiZSBwYXNzZWQgdG8KYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2Vz
KCkuCgpJIGRvIGFncmVlIHRoYXQgdGhlIGN1cnJlbnQgZm9ybSBpcyBhIGJpdCByZWR1bmRhbnQg
c28gSSB3aWxsIGxldCB1c2VycwphZGQgdGhlIGZsYWcgbWFudWFsbHkgZHVyaW5nIHRoZSBwcm9i
ZSBhZnRlciB0aGUKYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2VzKCkgY2FsbCwgYXMgc3VnZ2Vz
dGVkLgoKPiAKPiBPbmNlIHRoaXMgaXMgY2hhbmdlZCwgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRv
IGdvIHVwc3RyZWFtIHRvIG1lLgo+IAo+IFJlZ2FyZHMsCj4gCj4gSGFucwo+IAo+IAo+IAoKVGhh
bmtzIGZvciB0aGUgcmV2aWV3IQpNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
