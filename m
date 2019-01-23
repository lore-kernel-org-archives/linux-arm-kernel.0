Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:32:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982072184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZYeuvK93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982072184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zzjFNvmMti3rDcWtxwl2zi28f/Hl3ckZKzldpgm0dwk=; b=ZYeuvK9349ZZII
	f3KaLYkTJp9nWoAhj800xxn3WKyfRQ2oMx2qKG/5N5lSvLJPjZ3vcuCOz9zzkeuy8EViYol9NqMZz
	Z+ss2jfk0vV4f6HCHvfkdmthKLFCsY2zk8x6VrdP5GiF+tVXXCkqxyyMMmyrNz+PQ7StN7lWxaXvE
	cf67CE1ie7Z+7S3JzL/OZHf+/SAxsdcudcxUOSCM3x6FV1Lwg2GWbC9DJuG9EcOx5EckSWU03R1wQ
	In+tvaxrzTgrrNloOQAppk4NTNd9fQUn/qONos86MofpKjE7vOKwnlS7a9SZhle0CjNV0VO/ereV7
	1IKAIeNANGvYhqKAyiZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKVh-0004gF-4N; Wed, 23 Jan 2019 15:32:13 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKVc-0004ft-Kb
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:32:11 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmKVR-0007Az-AG; Wed, 23 Jan 2019 16:31:57 +0100
Message-ID: <1548257514.28802.3.camel@pengutronix.de>
Subject: Re: [PATCH v3 4/5] dma: imx-sdma: add an index for imx8mq multi
 sdma devices
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Wed, 23 Jan 2019 16:31:54 +0100
In-Reply-To: <20190123152310.11680-5-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
 <20190123152310.11680-5-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_073208_840266_6E605B6F 
X-CRM114-Status: GOOD (  20.15  )
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

SGkgQW5ndXMsCgpBbSBNaXR0d29jaCwgZGVuIDIzLjAxLjIwMTksIDA4OjIzIC0wNzAwIHNjaHJp
ZWIgQW5ndXMgQWluc2xpZSAoUHVyaXNtKToKPiBPbiBpLm14OG1xLCB0aGVyZSBhcmUgdHdvIHNk
bWEgaW5zdGFuY2VzLCBhbmQgdGhlIGNvbW1vbiBkbWEgZnJhbWV3b3JrCj4gd2lsbCBnZXQgYSBj
aGFubmVsIGR5bmFtaWNhbGx5IGZyb20gYW55IGF2YWlsYWJsZSBzZG1hIGluc3RhbmNlIHdoZXRo
ZXIKPiBpdCdzIHRoZSBmaXJzdCBzZG1hIGRldmljZSBvciB0aGUgc2Vjb25kIHNkbWEgZGV2aWNl
LiBTb21lIElQcyBsaWtlCj4gU0FJIG9ubHkgd29yayB3aXRoIHNkbWEyIG5vdCBzZG1hMS4gVG8g
bWFrZSBzdXJlIHRoZSBzZG1hIGNoYW5uZWwgaXMgZnJvbQo+IHRoZSBjb3JyZWN0IHNkbWEgZGV2
aWNlLCB1c2UgYW4gaW5kZXggdG8gbWF0Y2guCj4gCj4gQmFzZWQgb24gTUxLLTE2MTA0LTIgYnkg
Um9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPgoKVGhpcyByZWxpZXMgb24gdGhlIHByb2Jl
IG9yZGVyIG9mIHRoZSBkZXZpY2VzICh3aGljaCBzaG91bGQgYmUgdHJlYXRlZAphcyByYW5kb20p
IGZvciB0aGUgbWF0Y2ggdG8gZmluZCB0aGUgcmlnaHQgZGV2aWNlLiBUaGlzIGlzIG5vdAphY2Nl
cHRhYmxlIHVwc3RyZWFtLgoKVGhlIERUICJkbWFzIiBwcm9wZXJ0eSBhbHJlYWR5IHNwZWNpZmll
cyB0aGUgY29ycmVjdCBTRE1BIGRldmljZSB0byB1c2UKIGZvciBhIGNvbnN1bWVyLCBzbyB0aGUg
ZmlsdGVyIGZ1bmN0aW9uIHNob3VsZCByZWFsbHkgbWF0Y2ggdGhlIE9GIG5vZGUKb2YgdGhlIFNE
TUEgZGV2aWNlIHdpdGggdGhlIG5vZGUgc3BlY2lmaWVkIGluIHRoZSBkbWFzIHBoYW5kbGUgaW4g
b3JkZXIKdG8gcGljayB0aGUgcmlnaHQgU0RNQSBlbmdpbmUuCgpSZWdhcmRzLApMdWNhcwoKPiAK
PiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIEFpbnNsaWUgKFB1cmlzbSkgPGFuZ3VzQGFra2VhLmNh
Pgo+IC0tLQo+IMKgZHJpdmVycy9kbWEvaW14LXNkbWEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfCAxMiArKysrKysrKysrKysKPiDCoGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0
YS9kbWEtaW14LmggfMKgwqAxICsKPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEv
aW14LXNkbWEuYwo+IGluZGV4IDJlNjkxYjFjZDBlYi4uYmYzNzUyYTZhNjRmIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKPiArKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5j
Cj4gQEAgLTQ0Miw2ICs0NDIsNyBAQCBzdHJ1Y3Qgc2RtYV9lbmdpbmUgewo+ID4gPiDCoAlzdHJ1
Y3Qgc2RtYV9idWZmZXJfZGVzY3JpcHRvcgkqYmQwOwo+ID4gwqAJLyogY2xvY2sgcmF0aW8gZm9y
IEFIQjpTRE1BIGNvcmUuIDE6MSBpcyAxLCAyOjEgaXMgMCovCj4gPiA+IMKgCWJvb2wJCQkJY2xr
X3JhdGlvOwo+ID4gPiArCWludAkJCQlpZHg7Cj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgaW50IHNk
bWFfY29uZmlnX3dyaXRlKHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwKPiBAQCAtNjA2LDYgKzYwNyw4
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNkbWFfZHRfaWRzW10gPSB7Cj4g
wqB9Owo+IMKgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc2RtYV9kdF9pZHMpOwo+IMKgCj4gK3N0
YXRpYyBpbnQgc2RtYV9kZXZfaWR4Owo+ICsKPiA+IMKgI2RlZmluZSBTRE1BX0hfQ09ORklHX0RT
UERNQQlCSVQoMTIpIC8qIGluZGljYXRlcyBpZiB0aGUgRFNQRE1BIGlzIHVzZWQgKi8KPiA+IMKg
I2RlZmluZSBTRE1BX0hfQ09ORklHX1JURF9QSU5TCUJJVCgxMSkgLyogaW5kaWNhdGVzIGlmIFJl
YWwtVGltZSBEZWJ1ZyBwaW5zIGFyZSBlbmFibGVkICovCj4gPiDCoCNkZWZpbmUgU0RNQV9IX0NP
TkZJR19BQ1IJQklUKDQpwqDCoC8qIGluZGljYXRlcyBpZiBBSEIgZnJlcSAvY29yZSBmcmVxID0g
MiBvciAxICovCj4gQEAgLTE5MzQsNiArMTkzNywxMSBAQCBzdGF0aWMgYm9vbCBzZG1hX2ZpbHRl
cl9mbihzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sIHZvaWQgKmZuX3BhcmFtKQo+ID4gwqAJaWYgKCFp
bXhfZG1hX2lzX2dlbmVyYWxfcHVycG9zZShjaGFuKSkKPiA+IMKgCQlyZXR1cm4gZmFsc2U7Cj4g
wqAKPiA+ICsJLyogcmV0dXJuIGZhbHNlIGlmIGl0J3Mgbm90IHRoZSByaWdodCBkZXZpY2UgKi8K
PiA+ICsJaWYgKChzZG1hYy0+c2RtYS0+ZHJ2ZGF0YSA9PSAmc2RtYV9pbXg4bXEpCj4gPiArCQkm
JiAoc2RtYWMtPnNkbWEtPmlkeCAhPSBkYXRhLT5pZHgpKQo+ID4gKwkJcmV0dXJuIGZhbHNlOwo+
ICsKPiA+IMKgCXNkbWFjLT5kYXRhID0gKmRhdGE7Cj4gPiDCoAljaGFuLT5wcml2YXRlID0gJnNk
bWFjLT5kYXRhOwo+IMKgCj4gQEAgLTE5NjEsNiArMTk2OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZG1h
X2NoYW4gKnNkbWFfeGxhdGUoc3RydWN0IG9mX3BoYW5kbGVfYXJncyAqZG1hX3NwZWMsCj4gPiDC
oAnCoCogYmUgc2V0IHRvIHNkbWFjLT5ldmVudF9pZDEuCj4gPiDCoAnCoCovCj4gPiDCoAlkYXRh
LmRtYV9yZXF1ZXN0MiA9IDA7Cj4gPiArCWRhdGEuaWR4ID0gc2RtYS0+aWR4Owo+IMKgCj4gPiDC
oAlyZXR1cm4gZG1hX3JlcXVlc3RfY2hhbm5lbChtYXNrLCBzZG1hX2ZpbHRlcl9mbiwgJmRhdGEp
Owo+IMKgfQo+IEBAIC0yMTQ5LDYgKzIxNTgsOSBAQCBzdGF0aWMgaW50IHNkbWFfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+IMKgCQlvZl9ub2RlX3B1dChzcGJhX2J1cyk7
Cj4gPiDCoAl9Cj4gwqAKPiA+ICsJLyogVGhlcmUgbWF5YmUgbXVsdGkgc2RtYSBkZXZpY2VzIHN1
Y2ggYXMgaS5teDhtcSAqLwo+ID4gKwlzZG1hLT5pZHggPSBzZG1hX2Rldl9pZHgrKzsKPiArCj4g
PiDCoAlyZXR1cm4gMDsKPiDCoAo+IMKgZXJyX3JlZ2lzdGVyOgo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC5oIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9y
bV9kYXRhL2RtYS1pbXguaAo+IGluZGV4IDdkOTY0ZTc4NzI5OS4uODQzZmFmMDgxMjgyIDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LmgKPiArKysgYi9p
bmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC5oCj4gQEAgLTU1LDYgKzU1LDcgQEAg
c3RydWN0IGlteF9kbWFfZGF0YSB7Cj4gPiDCoAlpbnQgZG1hX3JlcXVlc3QyOyAvKiBzZWNvbmRh
cnkgRE1BIHJlcXVlc3QgbGluZSAqLwo+ID4gwqAJZW51bSBzZG1hX3BlcmlwaGVyYWxfdHlwZSBw
ZXJpcGhlcmFsX3R5cGU7Cj4gPiDCoAlpbnQgcHJpb3JpdHk7Cj4gPiArCWludCBpZHg7Cj4gwqB9
Owo+IMKgCj4gwqBzdGF0aWMgaW5saW5lIGludCBpbXhfZG1hX2lzX2lwdShzdHJ1Y3QgZG1hX2No
YW4gKmNoYW4pCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
