Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9777FC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8C121783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="regVEG/r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PmeU1g9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8C121783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sbzX7MZi6y+KEWSeCQ9WBUaIv4EshF/F1rDkZqStkk4=; b=regVEG/rjkWYpr
	brpUqoAVQfcbY5v2vRJtbdgG8Eqh56ezy/fCoNngDqS9qVWvwyv1MUshcocJhx1oMWyDMLybS8Wfl
	ujUsfxuYMQ++nnz/VardBqpJrrprS3FyqMb9h9qiSzwk3v09fQZHg6yClSEM9xrPeyjPir/VlHAYJ
	y0kg8jdGcy5sSOHWyyjLjmReDQbXi+Sd5pMFABfehUd7CuHJgu1qjisGO0EDWSwpXZD88y7akfaEc
	9GsitLm5zlQaHyxTVf2D7s9qHNK3VmbJh0xSaOcqU3MyTioHQBRhHAFQrDJd6uq/gifDiMJSQ6WlG
	w82T2qghY9Dr1vIR4aTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBb1-0002RL-1m; Mon, 28 Jan 2019 18:25:23 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBaq-0001gK-CL; Mon, 28 Jan 2019 18:25:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
 Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r1XU3ocFpnsznbPSbxFceyXNXEb17hRGRbRwITPYzYs=; b=PmeU1g9+y5uZlXlwXJR0tsuwhw
 aEfIPG289zqprOda6fivLJKJZyAy8sxikQ8CBAxy2Y/53/kBJQCahQWk9jEdo4uisAlp53Latd4a+
 CijskxpbAzkQMeanUUhl/s4b3sudOJdsjDjWFXoFPD0HxprzOKhbrHwUDh9lENLgvhjyq3gfgVNdX
 kBGnNX+l6mXLM4rVDr5oW3HoxPopq9dEKb/8Q2JDy7m8qndKtoKPWNbockkH/gxdMyPgypEn4sCcC
 iR185wgFyEDBD45hD0A0yhm8JZs/vcBY94cQhwxZ9lxt9+q3DBotrZPJXtzCFgOp1XuniIlXiXZYU
 nMqtuLiw==;
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBam-0003AE-Le; Mon, 28 Jan 2019 18:25:10 +0000
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
 (Authenticated sender: hadess@hadess.net)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 886FDC0003;
 Mon, 28 Jan 2019 18:24:33 +0000 (UTC)
Message-ID: <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
Subject: Re: [PATCH] input: goodix - support Goodix gt5688
From: Bastien Nocera <hadess@hadess.net>
To: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Date: Mon, 28 Jan 2019 19:24:33 +0100
In-Reply-To: <20190128170310.GA305@bogon.m.sigxcpu.org>
References: <20190128170310.GA305@bogon.m.sigxcpu.org>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_132508_821673_AF0CDDBB 
X-CRM114-Status: GOOD (  15.76  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAyMDE5LTAxLTI4IGF0IDE4OjAzICswMTAwLCBHdWlkbyBHw7xudGhlciB3cm90ZToK
PiBGcm9tIHdoYXQgSSd2ZSBzZWVuIGluIHZlbmRvciB0cmVlcyBpdCdzIGZpbmUgdG8gdHJlYXQg
dGhpcyBhcyBndDF4wrkuCj4gCj4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20vVGFkaVQ3L2FuZHJv
aWRfa2VybmVsX210ay00LjQvdHJlZS9tYXN0ZXIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9t
ZWRpYXRlay9HVDU2ODgKCkNhbiB5b3UgcGxlYXNlIHBvaW50IHRvIHRoZSBleGFjdCBsaW5lIG9m
IGNvZGUgdGhhdCBtYWtlcyB5b3Ugc2F5IHRoYXQ/CkknbSBub3Qgc2F5aW5nIGl0J3Mgbm90IGNv
bXBhdGlibGUsIGJ1dCBpdCdzIG5vdCB0aGUgc2FtZSBkcml2ZXIgdGhhdAp0aGUgY3VycmVudCBn
b29kaXguYyB3YXMgYmFzZWQgb24sIG9yIGV2ZW4gZ29vZGl4LmMuCgpDYW4geW91IHBsZWFzZSBl
bGFib3JhdGU/CgpGaW5kaW5nIHRoYXQgZGF0YSBpbiB0aGUgc3BlY3Mgd291bGQgYWxzbyBiZSBm
aW5lOgpodHRwczovL2dpdGh1Yi5jb20vaGFkZXNzL2d0OXh4L3RyZWUvbWFzdGVyL3NwZWNpZmlj
YXRpb25zCgpDaGVlcnMKClsxXTogb3JpZ2luYWwgZHJpdmVyOgpodHRwczovL2dpdGh1Yi5jb20v
aGFkZXNzL2d0OXh4L2NvbW1pdC84MmIxNDEyMjBlOGJjZTAwMDYwZTBkZTY5NzczNWQwYTcwYWYy
Njc4Cgo+IFNpZ25lZC1vZmYtYnk6IEd1aWRvIEfDvG50aGVyIDxhZ3hAc2lneGNwdS5vcmc+Cj4g
LS0tCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC90b3VjaHNjcmVl
bi9nb29kaXgudHh0IHwgMSArCj4gIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMgo+ICsrCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdAo+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC50eHQKPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC90b3VjaHNjcmVlbi9nb29kaXgudHh0Cj4gaW5k
ZXggZjdlOTVjNTJmM2M3Li41N2QzZDg4NzBhMDkgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC50eHQKPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQvdG91Y2hzY3JlZW4vZ29v
ZGl4LnR4dAo+IEBAIC0zLDYgKzMsNyBAQCBEZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgR29vZGl4
IEdUOXh4IHNlcmllcwo+IHRvdWNoc2NyZWVuIGNvbnRyb2xsZXIKPiAgUmVxdWlyZWQgcHJvcGVy
dGllczoKPiAgCj4gICAtIGNvbXBhdGlibGUJCTogU2hvdWxkIGJlICJnb29kaXgsZ3QxMTUxIgo+
ICsJCQkJIG9yICJnb29kaXgsZ3Q1Njg4Igo+ICAJCQkJIG9yICJnb29kaXgsZ3Q5MTEiCj4gIAkJ
CQkgb3IgImdvb2RpeCxndDkxMTAiCj4gIAkJCQkgb3IgImdvb2RpeCxndDkxMiIKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9nb29kaXguYwo+IGIvZHJpdmVycy9pbnB1
dC90b3VjaHNjcmVlbi9nb29kaXguYwo+IGluZGV4IGYyZDljMmM0MTg4NS4uNDdiMWNlZDQxNTc2
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LmMKPiArKysg
Yi9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC5jCj4gQEAgLTIxNiw2ICsyMTYsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGdvb2RpeF9jaGlwX2RhdGEKPiAqZ29vZGl4X2dldF9jaGlw
X2RhdGEodTE2IGlkKQo+ICB7Cj4gIAlzd2l0Y2ggKGlkKSB7Cj4gIAljYXNlIDExNTE6Cj4gKwlj
YXNlIDU2ODg6Cj4gIAkJcmV0dXJuICZndDF4X2NoaXBfZGF0YTsKPiAgCj4gIAljYXNlIDkxMToK
PiBAQCAtOTQyLDYgKzk0Myw3IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgZ29vZGl4X2Fj
cGlfbWF0Y2gpOwo+ICAjaWZkZWYgQ09ORklHX09GCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGdvb2RpeF9vZl9tYXRjaFtdID0gewo+ICAJeyAuY29tcGF0aWJsZSA9ICJnb29k
aXgsZ3QxMTUxIiB9LAo+ICsJeyAuY29tcGF0aWJsZSA9ICJnb29kaXgsZ3Q1Njg4IiB9LAo+ICAJ
eyAuY29tcGF0aWJsZSA9ICJnb29kaXgsZ3Q5MTEiIH0sCj4gIAl7IC5jb21wYXRpYmxlID0gImdv
b2RpeCxndDkxMTAiIH0sCj4gIAl7IC5jb21wYXRpYmxlID0gImdvb2RpeCxndDkxMiIgfSwKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
