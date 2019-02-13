Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB79CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D918222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bDW2tc6m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XfSSPc0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D918222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M7k3tCfYUw5E2rihuBVjcr5BA5eV5RhPC9wE0ZpcVmY=; b=bDW2tc6mTMIG6S
	OrtOUI9Ym6G+MHyPFQWw2vQjX0lEJtj3nPZ8dzFNU3gRazUOqqUOZOUnAQVJFaCOlXiBwRsRH2TAp
	47vshboGcqsT0hXx7w7Kn6KXfsde2jYtBu6sNSG18yrbMiShAqakxre0XQq2mhbnTpw1pWsTbI8ds
	p7JMfpI0X9NwDjm2gbPM92mqxN2bmxTAZxEN6bSo8z3UruWRcgcW3n6zAQZvgF1U8NUzDuJaKL9MZ
	lLibTKo3YwmfWvlSIF6XegrNN3nf0BUo4jIXFl2AoIXshClTD7iToRkwbmqzgZLfWLQvT3pITF5Sd
	q11fsQ8QDVo6/7PqxMLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqMU-0004xT-7x; Wed, 13 Feb 2019 08:57:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqMT-0004xK-6A
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 08:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sk7pCNN+kLygfXtHFJCpe4wq3tbYAjt37EfNZwNJB/E=; b=XfSSPc0yYWYxD4kKkBpqksfq2q
 oOIBcdbbBTNtDGZSiESPw3lgVjgy1db3+OzSadvaPfQTU5ywH8QZsUrNOiXiMddg5t9UVLf/yucaP
 fM7cHTid8NeSsoc00smMbemgKRcasDD8Ci7FblCb0NHXxHRjKGDYLWduMMNAtZ2QZFz7WQq0AGNkS
 c2LppuCTg89IuyvqoIdgV2SMfKWI3Prh/ycZUY6+zu+OROsU2a34LTG2J0jT6iFIf1WW2L9seqqNk
 AQNLRv9qc2lQBVrTR7jwvhXlgJil6Oj9TFEN0eZbHk8kPpE2wJXs3I0t0hrhR/eear26Q6Ova4P99
 fhU7gUoQ==;
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqMP-0003jZ-Qz
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:57:42 +0000
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 (Authenticated sender: gregory.clement@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8C44EE0012;
 Wed, 13 Feb 2019 08:57:04 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 0/6] Add CPU clock support for Armada 7K/8K
In-Reply-To: <875zuwo4fi.fsf@FE-laptop>
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
 <87a7k8o5d5.fsf@FE-laptop>
 <154713766177.15366.14948014236046606980@swboyd.mtv.corp.google.com>
 <875zuwo4fi.fsf@FE-laptop>
Date: Wed, 13 Feb 2019 09:57:04 +0100
Message-ID: <871s4c5an3.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_035741_979948_9FC7E230 
X-CRM114-Status: GOOD (  19.20  )
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
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org,
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

SGkgU3RlcGhlbiwKIAogT24gamV1LiwgamFudi4gMTAgMjAxOSwgR3JlZ29yeSBDTEVNRU5UIDxn
cmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+IHdyb3RlOgoKPiBIaSBTdGVwaGVuLAo+ICAKPiAg
T24gamV1LiwgamFudi4gMTAgMjAxOSwgU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3
cm90ZToKPgo+PiBRdW90aW5nIEdyZWdvcnkgQ0xFTUVOVCAoMjAxOS0wMS0xMCAwODoxNjoyMikK
Pj4+IEhpIFN0ZXBoZW4sCj4+PiAgCj4+PiAgT24gZGltLiwgZMOpYy4gMTYgMjAxOCwgR3JlZ29y
eSBDTEVNRU5UIDxncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+IHdyb3RlOgo+Pj4gCj4+PiA+
IEhlbGxvLAo+Pj4gPgo+Pj4gPiBUaGlzIGlzIHRoZSB0aGlyZCB2ZXJzaW9uIG9mIGEgc2VyaWVz
IGFsbG93aW5nIHRvIG1hbmFnZSB0aGUgY3B1Cj4+PiA+IGNsb2NrIGZvciBBcm1hZGEgN0svOEsu
IEZvciB0aGVzZSBTb0NzLCB0aGUgQ1BVcyBzaGFyZSB0aGUgc2FtZSBjbG9jawo+Pj4gPiBieSBj
bHVzdGVyLCBzbyBhY3R1YWxseSB0aGUgY2xvY2sgbWFuYWdlbWVudCBpcyBkb25lIGF0IGNsdXN0
ZXIgbGV2ZWwuCj4+PiA+Cj4+PiA+IEFzIGZvciB0aGUgb3RoZXIgQXJtYWRhIDdLLzhLIGNsb2Nr
cyBpdCBpcyBwb3NzaWJsZSB0byBoYXZlIG11bHRpcGxlCj4+PiA+IEFQIHNvIGhlcmUgYWdhaW4g
d2UgbmVlZCB0byBoYXZlIHVuaXF1ZSBuYW1lOiB0aGUgcHVycG9zZSBvZiB0aGUgc2Vjb25kCj4+
PiA+IHBhdGNoIGlzIHRvIHNoYXJlIGEgY29tbW9uIGNvZGUgd2hpY2ggd2lsbCBiZSB1c2VkIGlu
IDMgZHJpdmVycy4KPj4+ID4KPj4+ID4gVGhlIGxhc3QgMiBwYXRjaCBlbmFibGUgdGhlIGRyaXZl
ciBhdCBkdCBhbmQgcGxhdGZvcm0gbGV2ZWwgYW5kIHdpbGwKPj4+ID4gYmUgYXBwbGllZCB0aHJv
dWdoIHRoZSBtdmVidSBzdWJzeXN0ZW0uCj4+PiAKPj4+IFdoYXQgaXMgdGhlIHN0YXR1cyBvZiB0
aGlzIHNlcmllcz8KPj4+IAo+Pj4gVGhlIG9ubHkgY29tbWVudHMgSSBoYWQgd2FzIGZyb20gUm9i
IGFib3V0IHRoZSBiaW5kaW5nIGFuZCBJIGFuc3dlcmVkCj4+PiB0aGVtIDMgd2Vla3MgYWdvLiBE
byB5b3UgaGF2ZSBhbnkgb3RoZXIgY29tbWVudHM/IERvIHlvdSBleHBlY3QgYSByZWJhc2UKPj4+
IG9mIHRoaXMgc2VyaWVzIG9uIHY1LjAtcmMxPwo+Pj4gCj4+Cj4+IEknbSB3YWl0aW5nIGZvciBS
b2IuIEkgdGhpbmsgdGhlIGJpbmRpbmcgaXMgbm90IHByb3BlciBzbyBwcmVzdW1hYmx5IHlvdQo+
PiB3aWxsIGZpZ3VyZSBvdXQgd2hhdCBSb2Igd2FudHMgYW5kIHRoZW4gY2hhbmdlIHRoZSBjb2Rl
IGFjY29yZGluZ2x5IGFuZAo+PiByZXNlbmQ/Cj4KPiBBY3R1YWxseSB0aGUgYmluZGluZyBkZXNj
cmliZXMgcHJvcGVybHkgdGhlIGhhcmR3YXJlIHdlIGhhdmUgYW5kIHRoYXQKPiB3aGF0IEkgYW5z
d2VyZWQgdG8gUm9iLgoKSSBwaW5nZWQgeW91IGFib3V0IHRoaXMgc2VyaWVzIG1vcmUgdGhhbiBv
bmUgbW9udGggYWdvLCBhbmQgYW5zd2VyZWQgUm9iCmNvbmNlcm5lZCAyIG1vbnRocyBhZ28hIEhl
IGRpZG4ndCBzYWlkIGFueXRoaW5nIGFib3V0IG15IGNvbW1lbnRzIHNvIEkKcmVhbGx5IHRoaW5r
IHRoYXQgdGhlIGJpbmRpbmcgaXMgT0sgYW5kIGRlc2NyaWJlZCB0aGUgaGFyZHdhcmUgd2UgaGF2
ZS4KClNvIGNvdWxkIHlvdSBjb25zaWRlciB0byBhcHBseSB0aGlzIHNlcmllcz8KClRoYW5rcywK
CkdyZWdvcnkKCgo+Cj4gR3JlZ29yeQo+Cj4gLS0gCj4gR3JlZ29yeSBDbGVtZW50LCBCb290bGlu
Cj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwo+IGh0dHA6Ly9ib290bGlu
LmNvbQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAoKLS0gCkdyZWdvcnkgQ2xlbWVudCwgQm9vdGxpbgpFbWJlZGRl
ZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9ib290bGluLmNvbQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
