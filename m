Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF2C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:16:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBD521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MEz2GeJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBD521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=flhBRf7IkxvcAQ0kTmDYTxZO0PHouTJSqPwbom2K5XU=; b=MEz2GeJpJ8MEQl
	yPpy0MAxdt4zvi5nEs5iAUSiNjYx0bPMW2JP53pCqYK8S8gcFAfbHJ9ecgTmjrtYPzRBPSwNB1Z51
	5TZv9cR8z8pvBdZP+B2DBGF1jSal4iIA1qdUrWFDNK8Kzhy4RaIGHTlw8B+ajfAaQ6ubzFUI445/9
	w5ZHeWiMU5lIqpVDdVyHK9gCXSLRGlgKnN73x7A6LHgCyfeiNZw5biKLl5RQwYCuC0sVGIhmBE/ID
	e9MttbqRFWYKAObk1hoe+qhPG01mnDyXVPvBy04Rx7cuvnauAfzVCuMfjb/J227RseNtjFlkrSyHb
	384WXQof+8T2Wv5K/yug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm1Xd-00073h-7w; Tue, 22 Jan 2019 19:16:57 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm1XX-0006vh-43
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 19:16:55 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DA7E520955; Tue, 22 Jan 2019 20:16:47 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id EEA45207A3;
 Tue, 22 Jan 2019 20:16:36 +0100 (CET)
Date: Tue, 22 Jan 2019 20:16:35 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
Message-ID: <20190122201635.4a6c28d0@xps13>
In-Reply-To: <20190122183833.40077d7a@windsurf>
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
 <20190121112336.23489-7-miquel.raynal@bootlin.com>
 <20190122183833.40077d7a@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_111652_598791_72686FDE 
X-CRM114-Status: GOOD (  17.00  )
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
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVGhvbWFzLAoKVGhvbWFzIFBldGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNv
bT4gd3JvdGUgb24gVHVlLCAyMiBKYW4KMjAxOSAxODozODozMyArMDEwMDoKCj4gSGVsbG8sCj4g
Cj4gT24gTW9uLCAyMSBKYW4gMjAxOSAxMjoyMzozMiArMDEwMCwgTWlxdWVsIFJheW5hbCB3cm90
ZToKPiAKPiA+ICstIGNvbXBhdGlibGU6IFNob3VsZCBiZSBvbmUgb2Y6Cj4gPiArCSAgICAgICog
Im1hcnZlbGwsYTM3MDAtdXRtaS1ob3N0LXBoeSIgZm9yIHRoZSBQSFkgY29ubmVjdGVkIHRvCj4g
PiArCSAgICAgICAgdGhlIFVTQjIgaG9zdC1vbmx5IGNvbnRyb2xsZXIuCj4gPiArCSAgICAgICog
Im1hcnZlbGwsYTM3MDAtdXRtaS1vdGctcGh5IiBmb3IgdGhlIFBIWSBjb25uZWN0ZWQgdG8KPiA+
ICsJICAgICAgICB0aGUgVVNCMyBhbmQgVVNCMiBPVEcgY2FwYWJsZSBjb250cm9sbGVyLiAgCj4g
Cj4gRG8gd2UgcmVhbGx5IG5lZWQgZGlmZmVyZW50IGNvbXBhdGlibGUgc3RyaW5ncyBmb3IgdGhv
c2UgPyBJIGFzc3VtZSB0aGUKPiBJUCBibG9jayBpcyBleGFjdGx5IHRoZSBzYW1lIGZvciB0aGUg
dHdvIFBIWXMsIHJpZ2h0ID8gSWYgc28sIHdlIHNob3VsZAo+IHVzZSB0aGUgc2FtZSBjb21wYXRp
YmxlIHN0cmluZy4KCkZvciB3aGF0IEkgdW5kZXJzdGFuZCwgdGhlIFBIWXMgYXJlIGRpZmZlcmVu
dC4gQXQgbGVhc3QgdGhpcyBpcyBob3cKdGhleSBhcmUgZGVzY3JpYmVkIGluIHRoZSBzcGVjaWZp
Y2F0aW9uLiBJIGNhbiBsaXN0IGF0IGxlYXN0IHR3bwpkaWZmZXJlbmNlcyB2aXNpYmxlIGluIHRo
ZSByZWdpc3RlciBzZXQ6Ciogb25lIGhhcyBPVEcgcmVnaXN0ZXJzLCB0aGUgb3RoZXIgZG9lcyBu
b3QuCiogb25lIGhhcyBjaGFyZ2VyIGRldGVjdGlvbiBjYXBhYmlsaXRpZXMgKGFuZCByZWdpc3Rl
cnMpLCB0aGUgb3RoZXIKICBkb2VzIG5vdC4KCj4gCj4gRGlkbid0IHdlIGRpc2N1c3MgdGhhdCB3
ZSBjYW4gbG9va3VwIGZyb20gdGhlIFBIWSB3aGV0aGVyIHRoZSBVU0IKPiBjb250cm9sbGVyIGl0
IGlzIGNvbm5lY3RlZCB0byBpcyBpbiBob3N0IG1vZGUgb3Igb3RnIG1vZGUgPwoKWWVzLCBidXQg
aGF2aW5nIHR3byBkaWZmZXJlbnQgUEhZcyBtZWFudCBoYXZpbmcgdHdvIGRpZmZlcmVudApjb21w
YXRpYmxlcywgaGVuY2UgdGhlcmUgd2FzIG5vIG5lZWQgaW4gdGhlIGRyaXZlciB0byB1c2UgdGhp
cwpsb29rdXAgYXBwcm9hY2guIEFueXdheSB0aGlzIGlzIGFuIGltcGxlbWVudGF0aW9uIGRldGFp
bCBhbmQgaXQgaXMKYWx3YXlzIHBvc3NpYmxlIHRvIGdvIGJhY2suIAoKPiAKPiA+ICtFeGFtcGxl
Ogo+ID4gKwo+ID4gKwl1c2IyX3V0bWlfaG9zdF9waHk6IHBoeUA1ZjAwMCB7Cj4gPiArCQljb21w
YXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhLTM3MDAtdXRtaS1ob3N0LXBoeSI7Cj4gPiArCQlyZWcg
PSA8MHg1ZjAwMCAweDgwMD47Cj4gPiArCQltYXJ2ZWxsLHVzYi1taXNjLXJlZyA9IDwmdXNiMl9z
eXNjb24+Owo+ID4gKwkJI3BoeS1jZWxscyA9IDwwPjsKPiA+ICsJfTsKPiA+ICsKPiA+ICsJdXNi
Ml9zeXNjb246IHN5c3RlbS1jb250cm9sbGVyQDVmODAwIHsKPiA+ICsJCWNvbXBhdGlibGUgPSAi
bWFydmVsbCx1c2IyLWhvc3QtbWlzY2VsbGFuZW91cyIsICJzeXNjb24iOwo+ID4gKwkJcmVnID0g
PDB4NWY4MDAgMHg4MDA+Owo+ID4gKwl9OyAgCj4gCj4gVGhvc2UgcmVnaXN0ZXJzIGFyZSBjb250
aWd1b3VzIHRvIHRoZSByZWdpc3RlciByYW5nZSBvZiB0aGUgUEhZIGl0c2VsZi4KPiBXaGF0IHdh
cyB0aGUgY3JpdGVyaWEgdXNlZCB0byBkZWNpZGUgdGhhdCB3ZSBuZWVkIHR3byBzZXBhcmF0ZSBE
VCBub2Rlcwo+IGZvciB0aGVzZSA/CgpCZWNhdXNlIHRoaXMgYXJlYSBjb250YWlucyBhIGJ1bmNo
IG9mIHJlZ2lzdGVycywgbW9zdCBvZiB0aGVtIGFyZQp0aGVyZSB0byBtYW5hZ2UgdGhlIFBIWSwg
YnV0IG90aGVycyBhcmUgcmVsYXRlZCB0byB0aGUgVVNCIGNvbnRyb2xsZXIKKGllLiBhIHNvZnR3
YXJlIHJlc2V0KS4gSSBrbm93IHRoZSBjdXJyZW50IFVTQiBjb250cm9sbGVyIGRyaXZlciBkb2Vz
Cm5vdCBhY2Nlc3MgdGhpcyBhcmVhIGJ1dCB3aGF0IGlmIG9uZSBkYXkgd2UgZGVjaWRlIHRvIGRv
IGl0PwoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
