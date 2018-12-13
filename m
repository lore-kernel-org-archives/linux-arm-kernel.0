Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B22FC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:33:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F95F20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOjmwt+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F95F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jJegwyzfJ7wb8+jt3XUggmIg1eNiSbjoyaXHoQj/U9A=; b=XOjmwt+pssfBOk
	5VBOUg6M++OOXx6IzyWdJHLgn9eUVlhoDcFOmzKYQJ58Jlx22VMBRRMbm9p2uNWJV7MwDp5V9nDUS
	j62DRlZKtl1eOqsyH80O8TBrMENG2gRCqncNbDc9bfo1tFi1ikCY8/yIn1PekYOHvgPkJ/B6TvmpC
	LFjlgFCnpQd92ZaP8Ux3si7GBh+pZy6kLJkRXo/MlvDivgJyt8A16qse8l9eTJP60dAsLIKQxu7cY
	7d607nSC32ZnSiimD4ed+aSU0irM+DQTnryLO1IyiXVWBSIF9Z/Yn5cLwTaUvU+3DsUvmxB6s2JXa
	P46aVjOzgz5yB9SyWeSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQBP-0000kM-KK; Thu, 13 Dec 2018 12:33:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQBI-0000V0-5n
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:33:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81326A78;
 Thu, 13 Dec 2018 04:33:21 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298E23F575;
 Thu, 13 Dec 2018 04:33:20 -0800 (PST)
Date: Thu, 13 Dec 2018 12:34:01 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
Message-ID: <20181213123401.GA26763@red-moon>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
 <1544692768.3137.25.camel@pengutronix.de>
 <AM0PR0402MB35705EF0F4A77BD7B0AAFDDD8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
 <1544695636.3137.27.camel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544695636.3137.27.camel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_043332_341514_60499DB8 
X-CRM114-Status: GOOD (  22.29  )
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBEZWMgMTMsIDIwMTggYXQgMTE6MDc6MTZBTSArMDEwMCwgTHVjYXMgU3RhY2ggd3Jv
dGU6Cj4gQW0gRG9ubmVyc3RhZywgZGVuIDEzLjEyLjIwMTgsIDA5OjU3ICswMDAwIHNjaHJpZWIg
UmljaGFyZCBaaHU6Cj4gPiBIaSBMdWNhczoKPiA+IAo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+ID4gPiA+ID4gRnJvbTogTHVjYXMgU3RhY2ggW21haWx0bzpsLnN0YWNoQHBlbmd1
dHJvbml4LmRlXQo+ID4gPiBTZW50OiAyMDE45bm0MTLmnIgxM+aXpSAxNzoxOQo+ID4gPiA+ID4g
PiA+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29n
bGUuY29tOwo+ID4gPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBhbmRyZXcuc21pcm5vdkBn
bWFpbC5jb20KPiA+ID4gPiA+ID4gPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOwo+ID4gPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnCj4gPiA+IFN1YmplY3Q6IFJlOiBbdjJdIFBDSTogaW14OiBtYWtlIG1zaSB3
b3JrIHdpdGhvdXQgcGNpZXBvcnRidXMKPiA+ID4gCj4gPiA+IEhpIFJpY2hhcmQsCj4gPiA+IAo+
ID4gPiBBbSBEb25uZXJzdGFnLCBkZW4gMTMuMTIuMjAxOCwgMDg6MDIgKzAwMDAgc2NocmllYiBS
aWNoYXJkIFpodToKPiA+ID4gPiBNU0lfRU4gb2YgaU1YIFBDSWUgUkMgd291bGQgYmUgYXNzZXJ0
ZWQgd2hlbiBQQ0lFUE9SVEJVUyBkcml2ZXIgaXMKPiA+ID4gPiBzZWxlY3RlZC4KPiA+ID4gPiBU
aHVzLCB0aGUgTVNJIHdvcmtzIGZpbmUgb24gaU1YIFBDSWUgYmVmb3JlLgo+ID4gPiA+IEFzc2Vy
dCBpdCB1bmNvbmRpdGlvbmFsbHkgd2hlbiBNU0kgaXMgc3VwcG9ydGVkLgo+ID4gPiA+IE90aGVy
d2lzZSwgdGhlIE1TSSB3b3VsZG4ndCBiZSB0cmlnZ2VyZWQgYWx0aG91Z2ggdGhlIEVQIGlzIHBy
ZXNlbnQKPiA+ID4gPiBhbmQgdGhlIE1TSXMgYXJlIGFzc2lnbmVkLgo+ID4gPiAKPiA+ID4gVGhh
bmtzIGZvciBkaWdnaW5nIGludG8gdGhpcyBpc3N1ZS4gVGhpcyBzZWVtcyBsaWtlIHRoZSByaWdo
dCB3YXkgZm9yd2FyZC4KPiA+ID4gSG93ZXZlciwgZGlkIHlvdSB0ZXN0IHRoaXMgd2l0aCBkZXZp
Y2VzIHVzaW5nIGxlZ2FjeSBJUlFzPwo+ID4gPiBJLmUuIGJvb3Rpbmcgd2l0aCAibm9tc2kiIG9u
IHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIHRvIHNlZSBpZiBsZWdhY3kgSVJRcyBzdGlsbAo+ID4g
PiB3b3JrIGlmIHRoaXMgYml0IGlzIHNldCwgb3IgaWYgd2UgbmVlZCB0byBhdm9pZCBzZXR0aW5n
IHRoaXMgd2hlbiB0aGUgdXNlcgo+ID4gPiBleHBsaWNpdGx5IHJlcXVlc3RzIHRvIGRpc2FibGUg
TVNJcz8KPiA+ID4gCj4gPiA+IFJlZ2FyZHMsCj4gPiA+IEx1Y2FzCj4gPiA+IAo+ID4gCj4gPiBb
UmljaGFyZCBaaHVdIFRoYW5rcyBmb3IgeW91ciByZXZpZXcuCj4gPiBUaGUgTGVnYWN5IElOVHgg
aXMgYnJva2VuLgo+ID4gVGhlIE1TSV9FTiBiaXQgc2hvdWxkbid0IGJlIGFzc2VydGVkIHdoZW4g
dGhlIHVzZXIgZXhwbGljaXRseSByZXF1ZXN0cyB0byBkaXNhYmxlIE1TSXMuCj4gCj4gT2theSwg
c28gdGhpcyBwYXRjaCBzaG91bGQgYmUgZXh0ZW5kZWQgd2l0aCBhIGNoZWNrIGZvcgo+IHBjaV9t
c2lfZW5hYmxlZCgpIHRvIHNlZSBpZiB0aGUgdXNlciBleHBsaWNpdGx5IHdhbnQgbGVnYWN5IElS
UXMuCj4gCj4gPiBCVFcsIHJlZ2FyZGluZyB0byBCYXJ1Y2gncyBjb21tZW50cywgaXQgc2VlbXMg
dGhhdCBhbGwgdGhlIChJU19FTkFCTEVEKENPTkZJR19QQ0lfTVNJKSBjaGVjayBpbgo+ID4gwqB0
aGUgZHdjIGhvc3QgZHJpdmVycyBhcmUgbm90IHJlcXVpcmVkIGFueW1vcmUsIHNpbmNlIHRoZSBk
ZXBlbmRzIG9uIFBDSV9NU0lfSVJRX0RPTUFJTiwgcmlnaHQ/Cj4gCj4gVGhhdCdzIGNvcnJlY3Qu
IFRoaXMgaXMgbW9zdGx5IGEgaGlzdG9yaWNhbCBhcnRpZmFjdCBmcm9tIHRoZSB0aW1lIHdoZW4K
PiAgd2Ugd2VyZSBhYmxlIHRvIGJ1aWxkIHdpdGhvdXQgTVNJIHN1cHBvcnQuIFRob3NlIGNoZWNr
cyBjb3VsZCBiZQo+IGNsZWFuZWQgdXAgbm93IHRoYXQgd2UgZGVwZW5kIG9uIHRoZSBNU0kgb3B0
aW9ucy4KClRoZSBxdWVzdGlvbiBpcyB3aGV0aGVyIHdlIHNob3VsZCByZWFsbHkgZGVwZW5kIG9u
IFBDSV9NU0lfSVJRX0RPTUFJTgpvcHRpb24sIHNob3VsZCB3ZSA/CgpMb3JlbnpvCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
