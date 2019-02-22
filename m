Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DB0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:04:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C762070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AYBI/g+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C762070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oTHdHiGYa6czK2SAtTtQtY4AILjXNjpA2DyAgWLJBnA=; b=AYBI/g+f+NWHnT
	493YVoHL1DHD7Rw80jAGN2ZVyWqFZRCbhizuxgPiJJvpHowoTHb1EGYkVwmMTP0m/nLCRcLFPm0on
	IvYrV5kbgoeX9iEHTH3mMjmOFl+FpqgU+MiVUc80AU7H9XYYbQjt4F1j1ZTJb/mQmM2wlY/XPCIaR
	rgyY0lhykh2nQb9pFUod+DZiTWOMybWWLTowmriDbw92VScVpnhJ5tCduhRorLnXkE+guuwhpHco7
	QHxXNn8LB76awPu6afg1koOAxY3tVUkbwWl0k1kXCIubjO4YXL0F3fgLAL1dp2hFGk5G0UnZsh4eo
	H32Zcd3pMvqdjOH2JbsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDIt-0006rx-Gi; Fri, 22 Feb 2019 16:03:59 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDIp-0006r0-1H
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:03:57 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D749040006;
 Fri, 22 Feb 2019 16:03:49 +0000 (UTC)
Date: Fri, 22 Feb 2019 17:03:48 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/5] ata: libahci_platform: Support per-port interrupts
Message-ID: <20190222170348.12e45f42@xps13>
In-Reply-To: <c847985c-7117-6b31-ae78-4467871714c8@redhat.com>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-3-miquel.raynal@bootlin.com>
 <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
 <20190222163114.0f4488fe@xps13>
 <c847985c-7117-6b31-ae78-4467871714c8@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_080355_378249_1587188C 
X-CRM114-Status: GOOD (  22.55  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSGFucywKCkhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IHdyb3RlIG9uIEZy
aSwgMjIgRmViIDIwMTkgMTY6NTI6NTUKKzAxMDA6Cgo+IEhpLAo+IAo+IE9uIDIvMjIvMTkgNDoz
MSBQTSwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiA+IEhpIEhhbnMsCj4gPiAKPiA+IEhhbnMgZGUg
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IHdyb3RlIG9uIEZyaSwgMjIgRmViIDIwMTkgMTY6
MjY6MDEKPiA+ICswMTAwOgo+ID4gICAKPiA+PiBIaSwKPiA+Pgo+ID4+IE9uIDIvMjIvMTkgMzo1
MyBQTSwgTWlxdWVsIFJheW5hbCB3cm90ZTogIAo+ID4+PiBSaWdodCBub3cgdGhlIEFUQSBjb3Jl
IG9ubHkgYWxsb3dzIElQcyB0byB1c2UgYSBzaW5nbGUgaW50ZXJydXB0LiBTb21lCj4gPj4+IG9m
IHRoZW0gKGZvciBpbnN0YW5jZSB0aGUgQXJtYWRhLUNQMTEwIG9uZSkgYWN0dWFsbHkgaGFzIG9u
ZSBpbnRlcnJ1cHQKPiA+Pj4gcGVyIHBvcnQuIEFkZCBzb21lIGxvZ2ljIHRvIHN1cHBvcnQgc3Vj
aCBzaXR1YXRpb24uCj4gPj4+Cj4gPj4+IFdlIGNvbnNpZGVyIHRoYXQgZWl0aGVyIHRoZXJlIGlz
IG9uZSBzaW5nbGUgaW50ZXJydXB0IGRlY2xhcmVkIGluIHRoZQo+ID4+PiBtYWluIElQIG5vZGUs
IG9yIHRoZXJlIGFyZSBwZXItcG9ydCBpbnRlcnJ1cHRzLCBlYWNoIG9mIHRoZW0gYmVpbmcKPiA+
Pj4gZGVjbGFyZWQgaW4gdGhlIHBvcnQgc3ViLW5vZGVzLgo+ID4+Pgo+ID4+PiBTaWduZWQtb2Zm
LWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+ID4+PiAtLS0K
PiA+Pj4gICAgZHJpdmVycy9hdGEvYWNhcmQtYWhjaS5jICAgICAgIHwgIDIgKy0KPiA+Pj4gICAg
ZHJpdmVycy9hdGEvYWhjaS5jICAgICAgICAgICAgIHwgIDIgKy0KPiA+Pj4gICAgZHJpdmVycy9h
dGEvYWhjaS5oICAgICAgICAgICAgIHwgIDMgKy0KPiA+Pj4gICAgZHJpdmVycy9hdGEvbGliYWhj
aS5jICAgICAgICAgIHwgIDIgKy0KPiA+Pj4gICAgZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9y
bS5jIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQo+ID4+PiAgICBkcml2
ZXJzL2F0YS9zYXRhX2hpZ2hiYW5rLmMgICAgfCAgMiArLQo+ID4+PiAgICA2IGZpbGVzIGNoYW5n
ZWQsIDYxIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQo+ID4+Pgo+ID4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hdGEvYWNhcmQtYWhjaS5jIGIvZHJpdmVycy9hdGEvYWNhcmQtYWhjaS5j
Cj4gPj4+IGluZGV4IDU4M2UzNjZiZTdlMi4uOTQxNGI4MWU5OTRjIDEwMDY0NAo+ID4+PiAtLS0g
YS9kcml2ZXJzL2F0YS9hY2FyZC1haGNpLmMKPiA+Pj4gKysrIGIvZHJpdmVycy9hdGEvYWNhcmQt
YWhjaS5jCj4gPj4+IEBAIC00MzQsNyArNDM0LDcgQEAgc3RhdGljIGludCBhY2FyZF9haGNpX2lu
aXRfb25lKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZAo+
ID4+PiAgICAJaWYgKCFocHJpdikKPiA+Pj4gICAgCQlyZXR1cm4gLUVOT01FTTsgIAo+ID4+PiAg
ICA+IC0JaHByaXYtPmlycSA9IHBkZXYtPmlycTsgIAo+ID4+PiArCWhwcml2LT5pcnFzWzBdID0g
cGRldi0+aXJxOwo+ID4+PiAgICAJaHByaXYtPmZsYWdzIHw9ICh1bnNpZ25lZCBsb25nKXBpLnBy
aXZhdGVfZGF0YTsgIAo+ID4+PiAgICAgID4+IFdoYXQgY29kZS1wYXRoIGlzIGdvaW5nIHRvIGFs
bG9jIGhwcml2LT5pcnFzIGZvciBkcml2ZXJzIHVzaW5nIHRoaXMgY29kZS1wYXRoICAKPiA+PiB3
aGljaCBhcmUgbm90IHVzaW5nIGxpYmFoY2lfcGxhdGZvcm0gLmMgPyAgCj4gPiAKPiA+IEkgZG9u
J3QgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24gKG9yIHRoZSByZW1hcmsgYmVoaW5kIHRoZSBxdWVz
dGlvbiksCj4gPiBjYW4geW91IGV4cGxhaW4gYSBsaXR0bGUgYml0IG1vcmUgd2hhdCB5b3UgaGF2
ZSBpbiBtaW5kPyAgCj4gCj4gU29ycnkgSSBnb3QgdGhlIGNvZGUgY29udGV4dCB3cm9uZyBJIG1l
YW50IHRvIHB1dCB0aGF0IGNvbW1lbnQgYmVsb3cgdGhpcyBjaHVuazoKPiAKPiAgPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hdGEvYWhjaS5jIGIvZHJpdmVycy9hdGEvYWhjaS5jCj4gID4gaW5kZXgg
MDIxY2U0NmUyZTU3Li4xOGJjZTU1NmQ4NWYgMTAwNjQ0Cj4gID4gLS0tIGEvZHJpdmVycy9hdGEv
YWhjaS5jCj4gID4gKysrIGIvZHJpdmVycy9hdGEvYWhjaS5jCj4gID4gQEAgLTE4MTcsNyArMTgx
Nyw3IEBAIHN0YXRpYyBpbnQgYWhjaV9pbml0X29uZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29u
c3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkKPiAgPiAgIAkJLyogbGVnYWN5IGludHggaW50
ZXJydXB0cyAqLwo+ICA+ICAgCQlwY2lfaW50eChwZGV2LCAxKTsKPiAgPiAgIAl9Cj4gID4gLQlo
cHJpdi0+aXJxID0gcGNpX2lycV92ZWN0b3IocGRldiwgMCk7Cj4gID4gKwlocHJpdi0+aXJxc1sw
XSA9IHBjaV9pcnFfdmVjdG9yKHBkZXYsIDApOwo+ICA+Cj4gID4gICAJaWYgKCEoaHByaXYtPmNh
cCAmIEhPU1RfQ0FQX1NTUykgfHwgYWhjaV9pZ25vcmVfc3NzKQo+ICA+ICAgCQlob3N0LT5mbGFn
cyB8PSBBVEFfSE9TVF9QQVJBTExFTF9TQ0FOOyAgCj4gCj4gCj4gV2hpY2ggQUZBSUsgaXMgYSBj
b21tb24gY29kZS1wYXRoIGFsc28gdXNlZCBieSBhaGNpIGRyaXZlcnMgbm90IHVzaW5nCj4gbGli
YWhjaV9wbGF0Zm9ybSwgYW5kIGluIHRoYXQgY2FzZSBocHJpdi0+aXJxcyB3aWxsIGJlIE5VTEwg
YXMgbm90aGluZwo+IGluaXRpYWxpemVzIGl0LgoKT2ggSSBzZWUuIFdoYXQgZG8geW91IHByZWZl
cjoKMS8KKiBJIGFkZCAiaXJxcyIgYmVzaWRlcyAiaXJxIiBpbiB0aGUgc3RydWN0dXJlCiogY29w
eSB0aGUgdmFsdWUgb2YgaXJxIGluIGlycXNbMF0KKiB1c2UgaXJxcyBpbnN0ZWFkIG9mIGlycSBp
biB0aGUgbGliYWhjaV9wbGF0Zm9ybSA/Cm9yCjIvCiogQWxsb2NhdGVkIG9uZSBpcnEgdGhlcmUg
aWYgdGhlcmUgaXMgbm9uZSA/CgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
