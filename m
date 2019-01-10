Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607EAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:16:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF6E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cKEXNaRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF6E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q5rJ+BUnW7Vsds9M8e6tXqJyk1SvvqaQZq5aq6UgsnU=; b=cKEXNaRy5gtttx
	mKhAkZqtCh0+hQkcxK6GRis5P9YPs+ny2ie/WCZKKYfo74vo6Sd0PPAwUU68wlsZM5weYUOommVxG
	t9gmewY4L8uQ1zsO3z4bFoTogOPtOaSApZIYN7VLP5cJDj0knSNI849HbpooESTZOMgu7BwrnkMJa
	vbENUD+9VQJ/PjQxou/fOhSoJ4JYajUw2eUMKRI7zE6NIcXYSKHeK388+B7hYi3rcy8Wox4r45oTN
	07sJQId7t4JXR60rfz7gNMJaZmvuoKRAK72EyvlTTgt0rgGX4JG0YvG9AQSBJPThobcbnmnt3lbNm
	Sk6dIU+KjYfMCOqTDczg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghd0Y-0000A5-2h; Thu, 10 Jan 2019 16:16:38 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd0U-00009k-3M
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:16:36 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C85E7209BD; Thu, 10 Jan 2019 17:16:32 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr
 [109.213.145.18])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7BDFF20898;
 Thu, 10 Jan 2019 17:16:22 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 0/6] Add CPU clock support for Armada 7K/8K
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
Date: Thu, 10 Jan 2019 17:16:22 +0100
In-Reply-To: <20181216094147.6468-1-gregory.clement@bootlin.com> (Gregory
 CLEMENT's message of "Sun, 16 Dec 2018 10:41:41 +0100")
Message-ID: <87a7k8o5d5.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_081634_418442_6A61035C 
X-CRM114-Status: GOOD (  21.19  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlcGhlbiwKIAogT24gZGltLiwgZMOpYy4gMTYgMjAxOCwgR3JlZ29yeSBDTEVNRU5UIDxn
cmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+IHdyb3RlOgoKPiBIZWxsbywKPgo+IFRoaXMgaXMg
dGhlIHRoaXJkIHZlcnNpb24gb2YgYSBzZXJpZXMgYWxsb3dpbmcgdG8gbWFuYWdlIHRoZSBjcHUK
PiBjbG9jayBmb3IgQXJtYWRhIDdLLzhLLiBGb3IgdGhlc2UgU29DcywgdGhlIENQVXMgc2hhcmUg
dGhlIHNhbWUgY2xvY2sKPiBieSBjbHVzdGVyLCBzbyBhY3R1YWxseSB0aGUgY2xvY2sgbWFuYWdl
bWVudCBpcyBkb25lIGF0IGNsdXN0ZXIgbGV2ZWwuCj4KPiBBcyBmb3IgdGhlIG90aGVyIEFybWFk
YSA3Sy84SyBjbG9ja3MgaXQgaXMgcG9zc2libGUgdG8gaGF2ZSBtdWx0aXBsZQo+IEFQIHNvIGhl
cmUgYWdhaW4gd2UgbmVlZCB0byBoYXZlIHVuaXF1ZSBuYW1lOiB0aGUgcHVycG9zZSBvZiB0aGUg
c2Vjb25kCj4gcGF0Y2ggaXMgdG8gc2hhcmUgYSBjb21tb24gY29kZSB3aGljaCB3aWxsIGJlIHVz
ZWQgaW4gMyBkcml2ZXJzLgo+Cj4gVGhlIGxhc3QgMiBwYXRjaCBlbmFibGUgdGhlIGRyaXZlciBh
dCBkdCBhbmQgcGxhdGZvcm0gbGV2ZWwgYW5kIHdpbGwKPiBiZSBhcHBsaWVkIHRocm91Z2ggdGhl
IG12ZWJ1IHN1YnN5c3RlbS4KCldoYXQgaXMgdGhlIHN0YXR1cyBvZiB0aGlzIHNlcmllcz8KClRo
ZSBvbmx5IGNvbW1lbnRzIEkgaGFkIHdhcyBmcm9tIFJvYiBhYm91dCB0aGUgYmluZGluZyBhbmQg
SSBhbnN3ZXJlZAp0aGVtIDMgd2Vla3MgYWdvLiBEbyB5b3UgaGF2ZSBhbnkgb3RoZXIgY29tbWVu
dHM/IERvIHlvdSBleHBlY3QgYSByZWJhc2UKb2YgdGhpcyBzZXJpZXMgb24gdjUuMC1yYzE/CgpU
aGFua3MsCgpHcmVnb3J5Cgo+Cj4gQ2hhbmdlbG9nIHYyLT52MzoKPiAgLSBBZGQgYmFjayB0aGUg
Zmlyc3QgcGF0Y2ggZG9jdW1lbnRpbmcgdGhlIGJpbmRpbmcKPgo+IENoYW5nZWxvZyB2MS0+djI6
Cj4gIC0gSGVhZGVyIGNsZWFudXAKPiAgLSBVc2UgdW5zaWduZWQgaW50IGluc3RlYWQgb2YgaXQg
Zm9yIGNsdXN0ZXIgbWVtYmVyIG9mIHRoZSBhcF9jcHVfY2xrIHN0cnVjdAo+ICAtIFVzZSBjbGtf
aHcgaW5zdGVhZCBvZiBjbGsKPiAgLSBVc2UgcmVnbWFwX3JlYWRfcG9sbF90aW1lb3V0Cj4gIC0g
VXNlIGZvcl9lYWNoX29mX2NwdV9ub2RlCj4gIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IFdBUk5fT04o
KQo+ICAtIFJlbW92ZSBoZWFkZXJzIGZyb20gYXJtYWRhX2FwX2NwX2hlbHBlci5oCj4gIC0gRmV3
IG90aGVyIG1pbm9yIGNsZWFudXAKPgo+IEdyZWdvcnkgQ0xFTUVOVCAoNik6Cj4gICBkdC1iaW5k
aW5nczogYXA4MDY6IGFkZCB0aGUgY2x1c3RlciBjbG9jayBub2RlIGluIHRoZSBzeXNjb24gZmls
ZQo+ICAgY2xrOiBtdmVidTogYWRkIGhlbHBlciBmaWxlIGZvciBBcm1hZGEgQVAgYW5kIENQIGNs
b2Nrcwo+ICAgY2xrOiBtdmVidTogYWRkIENQVSBjbG9jayBkcml2ZXIgZm9yIEFybWFkYSA3Sy84
Swo+ICAgY2xrOiBtdmVidTogYXA4MDY6IEZpeCBjbG9jayBuYW1lIGZvciB0aGUgY2x1c3Rlcgo+
ICAgYXJtNjQ6IG1hcnZlbGw6IGVuYWJsZSB0aGUgIEFybWFkYSA3Sy84SyBDUFUgY2xrIGRyaXZl
cgo+ICAgYXJtNjQ6IGR0czogbWFydmVsbDogQWRkIGNwdSBjbG9jayBub2RlIG9uIEFybWFkYSA3
Sy84Swo+Cj4gIC4uLi9hcm0vbWFydmVsbC9hcDgwNi1zeXN0ZW0tY29udHJvbGxlci50eHQgICB8
ICAyMiArKwo+ICBhcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zICAgICAgICAgICAgICAgICAg
fCAgIDEgKwo+ICAuLi4vYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYtcXVhZC5kdHNpICAg
fCAgIDQgKwo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA2LmR0c2kg
fCAgIDYgKwo+ICBkcml2ZXJzL2Nsay9tdmVidS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAg
fCAgIDggKwo+ICBkcml2ZXJzL2Nsay9tdmVidS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
fCAgIDIgKwo+ICBkcml2ZXJzL2Nsay9tdmVidS9hcC1jcHUtY2xrLmMgICAgICAgICAgICAgICAg
fCAyNTkgKysrKysrKysrKysrKysrKysrCj4gIGRyaXZlcnMvY2xrL212ZWJ1L2FwODA2LXN5c3Rl
bS1jb250cm9sbGVyLmMgICB8ICAyNCArLQo+ICBkcml2ZXJzL2Nsay9tdmVidS9hcm1hZGFfYXBf
Y3BfaGVscGVyLmMgICAgICAgfCAgMzAgKysKPiAgZHJpdmVycy9jbGsvbXZlYnUvYXJtYWRhX2Fw
X2NwX2hlbHBlci5oICAgICAgIHwgIDExICsKPiAgZHJpdmVycy9jbGsvbXZlYnUvY3AxMTAtc3lz
dGVtLWNvbnRyb2xsZXIuYyAgIHwgIDMyICstLQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCAzNTcgaW5z
ZXJ0aW9ucygrKSwgNDIgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2Nsay9tdmVidS9hcC1jcHUtY2xrLmMKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xr
L212ZWJ1L2FybWFkYV9hcF9jcF9oZWxwZXIuYwo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9jbGsvbXZlYnUvYXJtYWRhX2FwX2NwX2hlbHBlci5oCj4KPiAtLSAKPiAyLjE5LjIKPgoKLS0g
CkdyZWdvcnkgQ2xlbWVudCwgQm9vdGxpbgpFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2lu
ZWVyaW5nCmh0dHA6Ly9ib290bGluLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
