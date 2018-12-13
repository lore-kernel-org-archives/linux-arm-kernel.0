Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE85C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B3820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VoL4kMaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B3820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kZ46Yorm20nFiPceFoATDOO/FJLIAowpalQvjZ7+S/k=; b=VoL4kMaEgkF5R9
	MmFDlehM1+15eErUcxyVQKlVOoZtWYrSbrG++Yg5rDRVkOO6tMbUJD/b1tKy/ZYYUe0W2MFyDcD6I
	ju7D15zQmJZ/fbhqhrecPrmY4QWijM0tZPt8Ix357Ev9E2qJVqntSM0ypeA1HtjHXpJVFNsDL8jT+
	DOsKctInZRQvFKDDepG/ZPFdGt9pkJgEfRt/GniT9ZtH9mnDGoVAngJz8QgjHwtSporCGT+rAytmE
	NBBYUnYUOeis07yzQg4S6oMQ/Ay036WiWtSUTvVTtQM3Wbusja7lfoGBSDptb4fzjjUIn2bseZyRH
	8+xZwcCiRMNaN54vw4Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXS0X-0005Uw-Qo; Thu, 13 Dec 2018 14:30:33 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXS0P-0005Sw-5O
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 14:30:30 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 52E3E207AD; Thu, 13 Dec 2018 15:30:12 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 53E1D20743;
 Thu, 13 Dec 2018 15:30:01 +0100 (CET)
Date: Thu, 13 Dec 2018 15:30:00 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Message-ID: <20181213153000.245d7d5f@xps13>
In-Reply-To: <20181213105302.GA5330@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <1999610.6DN9RK2Tt3@aspire.rjw.lan>
 <20181204094558.GA24588@e107981-ln.cambridge.arm.com>
 <1966692.fVZYlVgWHv@aspire.rjw.lan>
 <20181211141627.GA526@e107981-ln.cambridge.arm.com>
 <154469162632.19322.13092710881803732022@swboyd.mtv.corp.google.com>
 <20181213105302.GA5330@e107981-ln.cambridge.arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_063025_345696_032C0EE1 
X-CRM114-Status: GOOD (  14.24  )
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
 Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, sudeep.holla@arm.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTG9yZW56bywKCj4gPiBJZiB0aGF0J3MgcmVhbGx5IHRoZSBjYXNlLCB0aGVuIEkgY2FuIHNl
ZSBob3cgb25lIGRldmljZSBhbmQgaXQncwo+ID4gY2hpbGRyZW4gYXJlIHN1c3BlbmRlZCBhbmQg
dGhlIGlycSBmb3IgaXQgaXMgZGlzYWJsZWQgYnV0IHRoZSBwcm92aWRpbmcKPiA+IGRldmljZXMg
KGNsaywgcmVndWxhdG9yLCBidXMgY29udHJvbGxlciwgZXRjLikgYXJlIHN0aWxsIGZ1bGx5IGFj
dGl2ZQo+ID4gYW5kIG5vdCBzdXNwZW5kZWQgYnV0IGluIGZhY3QgY29tcGxldGVseSB1c2FibGUg
YW5kIGFibGUgdG8gc2VydmljZQo+ID4gaW50ZXJydXB0cy4gSWYgdGhhdCBhbGwgbWFrZXMgc2Vu
c2UsIHRoZW4gSSB3b3VsZCBhbnN3ZXIgdGhlIHF1ZXN0aW9uCj4gPiB3aXRoIGEgZGVmaW5pdGl2
ZSAieWVzIGl0J3MgYWxsIGZpbmUiIGJlY2F1c2UgdGhlIGNsayBjb25zdW1lciBjb3VsZCBiZQo+
ID4gaW4gdGhlIE5PSVJRIHBoYXNlIG9mIGl0cyBzdXNwZW5kIGJ1dCB0aGUgY2xrIHByb3ZpZGVy
IHdvdWxkbid0IGhhdmUKPiA+IGV2ZW4gc3RhcnRlZCBzdXNwZW5kaW5nIHlldCB3aGVuIGNsa19k
aXNhYmxlX3VucHJlcGFyZSgpIGlzIGNhbGxlZC4gIAo+IAo+IFRoYXQncyBhIHZlcnkgZ29vZCBz
dW1tYXJ5IGFuZCBhZGRyZXNzIG15IGNvbmNlcm4sIEkgc3RpbGwgcXVlc3Rpb24gdGhpcwo+IHBh
dGNoIGNvcnJlY3RuZXNzIChhbmQgbWFueSBvdGhlcnMgdGhhdCBjYXJyeSBvdXQgY2xrIG9wZXJh
dGlvbnMgaW4gUzJSCj4gTk9JUlEgcGhhc2UpLCB0aGV5IG1heSB3b3JrIGJ1dCBkbyBub3QgdGVs
bCBtZSB0aGV5IGFyZSByb2NrIHNvbGlkIGdpdmVuCj4geW91ciBhY2N1cmF0ZSBzdW1tYXJ5IGFi
b3ZlLgoKSSB1bmRlcnN0YW5kIHlvdXIgY29uY2VybiBidXQgSSBkb24ndCBzZWUgYW55IGFsdGVy
bmF0aXZlIHJpZ2h0IG5vdwphbmQgYSBkZWVwIHJld29yayBvZiB0aGUgUE0gY29yZSB0byByZXNw
ZWN0IHN1Y2ggZGVwZW5kZW5jeSBpcyBub3QKc29tZXRoaW5nIHRoYXQgY2FuIGJlIGRvbmUgaW4g
YSByZWFzb25hYmxlIGFtb3VudCBvZiB0aW1lLiBXaXRoCnJlZ2FyZCB0byB0aGlzIGNvbnN0cmFp
bnQsIGRvIHlvdSB0aGluayBpdCBpcyB3b3J0aCBibG9ja2luZyB0aGUKc2VyaWVzPwoKClRoYW5r
cywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
