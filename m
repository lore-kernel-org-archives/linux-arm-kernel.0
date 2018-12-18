Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF16C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:59:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B88C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R8lo+Fzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B88C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=feNVysxfiqB1nX2EHZIKFxbn3/PQ0ef8YN6zFTMTUTM=; b=R8lo+FzdgY9g5a
	OvWVDdENqtHV+YRvrTk4v6O8DSMnNpTydpx1ucJmUA92jXyGAfaIcsVVTnXjsL47dg649yuE9Nbk3
	dwSC04l2RvuywMELV1qATlELdw6wAvUtprRdLt5W7JpG5z3JvGlVLKIeBaaJQZHn/UGTfPChhqNex
	X3KRxzN+meNqZ0hdx3JJHcwP2q77KspZL4ub73hKGeltQ+Rl5pu3i9UeFggKUuuWEoPqxEw3t7QoS
	n0QgJ8Ntd417EylLPeMuoR0h1GUms8t9m1mafT1UWnvE7+24JkghN3pw2N89DedtAYb/EeObvyk2i
	cqmfkQ5Rdw4sQxjhFzdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZIhw-0007gW-PB; Tue, 18 Dec 2018 16:59:00 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZIhs-0007f2-Oq
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:58:58 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 354C02072C; Tue, 18 Dec 2018 17:58:44 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 03B16206A7;
 Tue, 18 Dec 2018 17:58:33 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
References: <87k1kowf7i.fsf@bootlin.com> <20181205101035.GA31059@e107155-lin>
Date: Tue, 18 Dec 2018 17:58:34 +0100
In-Reply-To: <20181205101035.GA31059@e107155-lin> (Sudeep Holla's message of
 "Wed, 5 Dec 2018 10:10:35 +0000")
Message-ID: <877eg6hiv9.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_085856_938544_251B0A6E 
X-CRM114-Status: GOOD (  19.55  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>,
 Jason Cooper <jason@lakedaemon.net>, Sergey Matyukevich <geomatsi@gmail.com>,
 linux-pm@vger.kernel.org, orenbh <orenbh@marvell.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3VkZWVwLAogCiBPbiBtZXIuLCBkw6ljLiAwNSAyMDE4LCBTdWRlZXAgSG9sbGEgPHN1ZGVl
cC5ob2xsYUBhcm0uY29tPiB3cm90ZToKCj4gT24gV2VkLCBEZWMgMDUsIDIwMTggYXQgMDk6Mjc6
NDVBTSArMDEwMCwgR3JlZ29yeSBDTEVNRU5UIHdyb3RlOgo+PiBIaSBCYXJ1Y2gsCj4+ICAKPj4g
IE9uIG1lci4sIGTDqWMuIDA1IDIwMTgsIEJhcnVjaCBTaWFjaCA8YmFydWNoQHRrb3MuY28uaWw+
IHdyb3RlOgo+PiAKPj4gPiBIaSBHcmVnb3J5LAo+PiA+Cj4+ID4gT24gVHVlLCBEZWMgMDQsIDIw
MTggYXQgMDY6NDg6NDNQTSArMDIwMCwgQmFydWNoIFNpYWNoIHdyb3RlOgo+PiA+PiBPbiBUdWUs
IERlYyAwNCwgMjAxOCBhdCAwNToyMToyNVBNICswMTAwLCBHcmVnb3J5IENMRU1FTlQgd3JvdGU6
Cj4+ID4+ID4gIE9uIG1hci4sIGTDqWMuIDA0IDIwMTgsIEJhcnVjaCBTaWFjaCA8YmFydWNoQHRr
b3MuY28uaWw+IHdyb3RlOgo+PiA+PiA+ID4gVGhpcyByZXZlcnRzIGNvbW1pdCA4ZWQ0NjM2ODc3
NmIzYmM5M2Q3NGMxZjhmMmJmYjlmZDhhOWFkODA1Lgo+PiA+PiA+ID4KPj4gPj4gPiA+IFRoaXMg
Y29tbWl0IGJyZWFrcyBib290IG9uIEFybWFkYSA4SyBiYXNlZCBzeXN0ZW1zLiBSZXZlcnRpbmcg
aXQgbWFrZXMKPj4gPj4gPiA+IGFmZmVjdGVkIHN5c3RlbXMgYm9vdCBhZ2Fpbi4KPj4gPj4gPiA+
Cj4+ID4+ID4gPiBSZXBvcnRlZC1ieTogU2VyZ2V5IE1hdHl1a2V2aWNoIDxnZW9tYXRzaUBnbWFp
bC5jb20+Cj4+ID4+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0a29z
LmNvLmlsPgo+PiA+PiA+IAo+PiA+PiA+IEkgd291bGQgbGlrZSB0byBrbm93IG1vcmUgYWJvdXQg
aXQgYmVjYXVzZSBvbiB0aGUgTWNCaW4gSSB1c2UgdGhlcmUgaXMKPj4gPj4gPiBubyBpc3N1ZSB3
aXRoIDQuMjAtcmMxLgo+PiA+PiA+IAo+PiA+PiA+IERvIHlvdSBvYnNlcnZlIHRoaXMgaXNzdWUg
d2l0aCB0aGUgYXJtNjQgZGVmY29uZmlnIG9yIGRvIHlvdSBoYXZlIHNvbWUKPj4gPj4gPiBzcGVj
aWZpYyBjb25maWd1cmF0aW9uIG9wdGlvbj8KPj4gPj4gCj4+ID4+IEkgdGVzdGVkIHRoZSBhdHRh
Y2hlZCBkZWZjb25maWcgb24gQ2xlYXJmb2cgR1QtOEsgYW5kIG9uIGFub3RoZXIgY3VzdG9tIEFy
bWFkYSAKPj4gPj4gOEsgYmFzZWQgYm9hcmQuCj4+ID4+IAo+PiA+PiBUb21vcnJvdyBJJ2xsIHRl
c3QgTWFjY2hpYXRvYmluIHdpdGggdGhpcyBjb25maWcgYW5kIHRoZSBhcm02NCBkZWZjb25maWcu
Cj4+ID4KPj4gPiBJIHJlcHJvZHVjZWQgc2FtZSBpc3N1ZSBvbiBhIE1hY2NoaWF0b2JpbiBib2Fy
ZCB3aXRoIGJvdGggdGhpcyBjb25maWcgYW5kIHRoZSAKPj4gPiBhcm02NCBkZWZjb25maWcuIFRo
ZSBsYXR0ZXIgcHJvZHVjZWQgdGhpcyBzcGxhdDoKPj4gCj4+IE9LIHRoYW5rcywgZm9yIHRoaXMs
IEkgYWxzbyBnb3QgdGhlIGNvbmZpcm1hdGlvbiBieSBteSBjb2xsZWFndWVzLiBUaGUKPj4gb25s
eSBkaWZmZXJlbmNlIEkgY2FuIHRoaW5rIG9mLCBpcyB0aGUgZmlybXdhcmUsIGJ1dCB0aGUgc3Vy
cHJpc2luZwo+PiB0aGluZywgaXMgdGhhdCBJIGhhdmUgYW4gb2xkIGZpcm13YXJlOiAxNy4wNi4y
IGFuZCB0aGF0IHdpdGggYSByZWNlbnQKPj4gb25lLCBpdCBkb2Vzbid0IHdvcmsuCj4+IAo+PiBT
byBJIHdpbGwgYXBwbHkgaXQgaW4gbXZlYnUvZml4ZXMuCj4+IAo+Cj4gU29ycnkgaWYgaXQncyB0
b28gbGF0ZS4gQnV0IEkgd291bGQgcmF0aGVyIGRpc2FibGUgdGhlIHN0YXRlcyB0aGF0IGFyZQo+
IGJyb2tlbiBvbiBvbGQgZmlybXdhcmUgYW5kIHNlZSBpZiBpdCdzIHBvc3NpYmxlIGZvciBib290
bG9hZGVyIG9yIGJvb3QKPiBmaXJtd2FyZSBsb2FkaW5nIERUIGNhbiBtb2RpZnkgdGhlIHN0YXR1
cyB0byAiZW5hYmxlZCIgaWYgaXQgY2FuIGRldGVjdAo+IHRoZSBmaXJtd2FyZSB2ZXJzaW9uLgoK
eW91IG1lYW4gYWRkaW5nIHN0YXR1cyA9ICJkaXNhYmxlIiBvbiBlYWNoIGlkbGUtc3RhdGUgc3Vi
bm9kZT8KCkdyZWdvcnkKCj4KPiAtLQo+IFJlZ2FyZHMsCj4gU3VkZWVwCgotLSAKR3JlZ29yeSBD
bGVtZW50LCBCb290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0
cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
