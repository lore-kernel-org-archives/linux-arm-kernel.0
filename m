Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4342DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:31:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A5420869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGcyNtAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A5420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ukioMZ6869dCN0N3wo4ZUI04YUvyPq8XQ0lsZ27Cy4Y=; b=dGcyNtAqlbLt1t
	JVJE9k2DlKVoY5r3MQYfT5mwDmzPaovN96uMQaA4K18RBZ3HM3H3njgOrdUtRs2IB8TAwkDMn+pE6
	w5U9I3KcE6DcMGtbx6vIQGTm6j2AzExwUCVTIKarWzJjgOL7G107cVhaEsRQXbwCR7Zd1v3svUtms
	TiCJVHlP9G4w6VzmeLFJI5IBxNsaJTjBL19/MoiQeT5D73/Hms9RR8FtmYLnVtBjDhUtctAoOnoS4
	pPJm/IZxwx7JuTh/mZ9IphfNA7w8j2XkxEfQRD5K/sQpJ6/EBSrfzCT0wT+gCJ6ClMWj4/5qQge3l
	1Z2GeWQB7r/9cPXa27yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQfm-0005bP-Si; Tue, 29 Jan 2019 10:31:18 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQfj-0005Za-Aa; Tue, 29 Jan 2019 10:31:17 +0000
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
 (Authenticated sender: hadess@hadess.net)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2B44720008;
 Tue, 29 Jan 2019 10:30:54 +0000 (UTC)
Message-ID: <12e21befacf68861ddf34020838ff7a6e6e078ad.camel@hadess.net>
Subject: Re: [PATCH] input: goodix - support Goodix gt5688
From: Bastien Nocera <hadess@hadess.net>
To: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Date: Tue, 29 Jan 2019 11:30:53 +0100
In-Reply-To: <20190129091651.GA8497@bogon.m.sigxcpu.org>
References: <20190128170310.GA305@bogon.m.sigxcpu.org>
 <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
 <20190129091651.GA8497@bogon.m.sigxcpu.org>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_023115_528033_2099D6A5 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMDE5LTAxLTI5IGF0IDEwOjE2ICswMTAwLCBHdWlkbyBHw7xudGhlciB3cm90ZToK
PiBIaSwKPiBPbiBNb24sIEphbiAyOCwgMjAxOSBhdCAwNzoyNDozM1BNICswMTAwLCBCYXN0aWVu
IE5vY2VyYSB3cm90ZToKPiA+IE9uIE1vbiwgMjAxOS0wMS0yOCBhdCAxODowMyArMDEwMCwgR3Vp
ZG8gR8O8bnRoZXIgd3JvdGU6Cj4gPiA+IEZyb20gd2hhdCBJJ3ZlIHNlZW4gaW4gdmVuZG9yIHRy
ZWVzIGl0J3MgZmluZSB0byB0cmVhdCB0aGlzIGFzCj4gPiA+IGd0MXjCuS4KPiA+ID4gCj4gPiA+
IFsxXTogCj4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9UYWRpVDcvYW5kcm9pZF9rZXJuZWxfbXRr
LTQuNC90cmVlL21hc3Rlci9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL21lZGlhdGVrL0dUNTY4
OAo+ID4gCj4gPiBDYW4geW91IHBsZWFzZSBwb2ludCB0byB0aGUgZXhhY3QgbGluZSBvZiBjb2Rl
IHRoYXQgbWFrZXMgeW91IHNheQo+ID4gdGhhdD8KPiA+IEknbSBub3Qgc2F5aW5nIGl0J3Mgbm90
IGNvbXBhdGlibGUsIGJ1dCBpdCdzIG5vdCB0aGUgc2FtZSBkcml2ZXIKPiA+IHRoYXQKPiA+IHRo
ZSBjdXJyZW50IGdvb2RpeC5jIHdhcyBiYXNlZCBvbiwgb3IgZXZlbiBnb29kaXguYy4KPiA+IAo+
ID4gQ2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlPwo+IAo+IEkgYmFzaWNhbGx5IGxvb2tlZCBhdCB0
aGUgcmVnaXN0ZXJzIHVzZXMgZm9yIHRoZSBjb25maWcgdXBkYXRlOgo+IAo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9UYWRpVDcvYW5kcm9pZF9rZXJuZWxfbXRrLTQuNC9ibG9iL21hc3Rlci9kcml2ZXJz
L2lucHV0L3RvdWNoc2NyZWVuL21lZGlhdGVrL0dUNTY4OC9pbmNsdWRlL2d0MXhfdHBkX2NvbW1v
bi5oI0wxNTIKPiBodHRwczovL2dpdGh1Yi5jb20vVGFkaVQ3L2FuZHJvaWRfa2VybmVsX210ay00
LjQvYmxvYi9tYXN0ZXIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9tZWRpYXRlay9HVDU2ODgv
Z3QxeF9nZW5lcmljLmMjTDQzMAoKSSdtIG5vdCBzdXJlIHRoYXQncyBnb29kIGVub3VnaCB0byBz
YXkgdGhhdCB0aGUgdG91Y2hzY3JlZW4gbW9kZWxzIGFyZQpjb21wYXRpYmxlLgoKPiBUaGF0IGFu
ZCB0aGUgZmFjdCB0aGF0IHRoZSBkcml2ZXIgaXMgZG9pbmcgaXQncyBqb2Igd2VsbCBtYWRlIG1l
Cj4gYmVsaWV2ZQo+IHRoYXQncyBnb29kIGZvciBiYXNlIHN1cHBvcnQuCgpJZiB5b3UndmUgdGVz
dGVkIGl0LCB0aGF0J3MgYmV0dGVyLiBDYW4geW91IHBsZWFzZSBhZGQgYSByZWZlcmVuY2UgdG8K
dGhlIGRldmljZSB0aGF0IHlvdSd2ZSB0ZXN0ZWQgdGhpcyBvbiBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2U/Cgo+ICBUaGluZ3MgbGlrZSBob3Rrbm90LCBnZXN0dXJlIHdha2V1cCBhbmQKPiBwcm94aW1p
dHkgc2Vuc29yIHdpbGwgbmVlZCBhZGRpdGlvbmFsIHdvcmsuCj4gCj4gPiBGaW5kaW5nIHRoYXQg
ZGF0YSBpbiB0aGUgc3BlY3Mgd291bGQgYWxzbyBiZSBmaW5lOgo+ID4gaHR0cHM6Ly9naXRodWIu
Y29tL2hhZGVzcy9ndDl4eC90cmVlL21hc3Rlci9zcGVjaWZpY2F0aW9ucwo+IAo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9oYWRlc3MvZ3Q5eHgvcHVsbC8zCgpNZXJnZWQgdGhhdCwgdGhhbmtzCgpDaGVl
cnMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
