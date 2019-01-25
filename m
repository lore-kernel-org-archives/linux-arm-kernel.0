Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD190C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:05:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B521218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aOf/p+lZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B521218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cUgMKY2d5FGmvLBgxuWZdPGDzKIzw42ZPy2IyKLdBRU=; b=aOf/p+lZTv+M7H
	VkG61y3uaZlmu501XlUBq2R0VhVyUJ1w8XZ/3cECLoNEfUw6fQVu+BD6shIBpjvzLdfLuB4RbqBfh
	WGw9pVh19qbKc7ca2oUHYIlfAUsK9RUK08AnlKuXFCpCafcSZMG2i0lWsdtqck05bVb0NziMIu7mO
	hquq4Tv2wIh/rfmlD5hZ6DemCEsWsafwxazRFA2EnGmUTfRQy9vzOQY3fBU6tCTwcnL6mjMDVhmfr
	6muVhJvHz+xcFidhw1id9ho8NM7u0LPTiS2Awq/ZRSdzMYKw5IUX5kwkvwvqfMf3AcegOB3ues268
	LLMK8yYb2aDK8lOW7aZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyMh-0006As-RN; Fri, 25 Jan 2019 10:05:35 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyMe-0006A9-92
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:05:33 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9753120798; Fri, 25 Jan 2019 11:05:30 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 315D6206A6;
 Fri, 25 Jan 2019 11:05:30 +0100 (CET)
Date: Fri, 25 Jan 2019 11:05:30 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190125110530.0ff11a54@xps13>
In-Reply-To: <20190123170509.GB1157@e107981-ln.cambridge.arm.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
 <20190123170509.GB1157@e107981-ln.cambridge.arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_020532_456536_C353A0D3 
X-CRM114-Status: GOOD (  20.40  )
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
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTG9yZW56bywKCkxvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
PiB3cm90ZSBvbiBXZWQsIDIzIEphbiAyMDE5CjE3OjA1OjA5ICswMDAwOgoKPiBPbiBUdWUsIEph
biAwOCwgMjAxOSBhdCAwNToyNDoyNVBNICswMTAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+ID4g
SGVsbG8sCj4gPiAKPiA+IEFzIHBhcnQgb2YgYW4gZWZmb3J0IHRvIGJyaW5nIHN1c3BlbmQgdG8g
UkFNIHN1cHBvcnQgdG8gQXJtYWRhIDM3MDAKPiA+IFNvQ3MgKG1haW4gdGFyZ2V0OiBFU1BSRVNT
T2JpbiksIHRoaXMgc2VyaWVzIGhhbmRsZXMgdGhlIHdvcmsgYXJvdW5kCj4gPiB0aGUgUENJZSBJ
UC4KPiA+IAo+ID4gRmlyc3QsIG1vcmUgY29uZmlndXJhdGlvbiBpcyBkb25lIGluIHRoZSAnc2V0
dXAnIGhlbHBlciBhcyBpbnNwaXJlZAo+ID4gZnJvbSB0aGUgVS1Cb290IGRyaXZlci4gVGhpcyBp
cyBuZWVkZWQgdG8gZW50aXJlbHkgaW5pdGlhbGl6ZSB0aGUgSVAKPiA+IGR1cmluZyBmdXR1cmUg
cmVzdW1lIG9wZXJhdGlvbiAocGF0Y2ggMSkuCj4gPiAKPiA+IFRoZW4sIHJlc2V0IEdQSU8sIFBI
WSBhbmQgY2xvY2sgc3VwcG9ydCBhcmUgaW50cm9kdWNlZCAocGF0Y2ggMi00KS4gQXMKPiA+IGN1
cnJlbnQgZGV2aWNlIHRyZWVzIGRvIG5vdCBwcm92aWRlIHRoZSBjb3JyZXNwb25kaW5nIHByb3Bl
cnRpZXMsIG5vdAo+ID4gZmluZGluZyBvbmUgb2YgdGhlc2UgcHJvcGVydGllcyBpcyBub3QgYW4g
ZXJyb3IgYW5kIGp1c3QgcHJvZHVjZXMgYQo+ID4gd2FybmluZy4gSG93ZXZlciwgaWYgdGhlIHBy
b3BlcnR5IGlzIHByZXNlbnQsIGFuIGVycm9yIGR1cmluZyBQSFkKPiA+IGluaXRpYWxpemF0aW9u
IHdpbGwgZmFpbCB0aGUgcHJvYmUgb2YgdGhlIGRyaXZlci4KPiA+IAo+ID4gTm90ZTogVG8gYmUg
c3VyZSB0aGUgY2xvY2sgd2lsbCBiZSByZXN1bWVkIGJlZm9yZSB0aGlzIGRyaXZlciwgYSBmaXJz
dAo+ID4gc2VyaWVzIGFkZGluZyBsaW5rcyBiZXR3ZWVuIGNsb2NrcyBhbmQgY29uc3VtZXJzIGhh
cyBiZWVuIHN1Ym1pdHRlZCwKPiA+IHNlZSBbMV0uIEFueXdheSwgaGF2aW5nIHRoZSBjbG9jayBz
ZXJpZXMgYXBwbGllZCBmaXJzdCBpcyBub3QgbmVlZGVkLiAgCj4gCj4gSSBkbyBub3QgdW5kZXJz
dGFuZCB3aGF0IHRoaXMgbWVhbnMsIGluIHBhcnRpY3VsYXIgaW4gcmVsYXRpb24KPiB0byB0aGUg
YmxvY2tpbmcgY2xvY2sgY2FsbHMgaW4gdGhlIHN1c3BlbmQvcmVzdW1lIE5PSVJRIGhvb2tzLgoK
SSBhbSBub3Qgc3VyZSB0byB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24uCgpBcyB0aGVyZSBhcmUg
bXVsdGlwbGUgcG9pbnRzIGluIHRoaXMgc2VudGVuY2UgSSB3aWxsIGRldGFpbCBlYWNoIG9mCnRo
ZW0gc28gcGxlYXNlIGNvbW1lbnQgb24gdGhlIG9uZSB3aGljaCBpcyBib3RoZXJpbmcgeW91Ogoq
IEkgYW0gd29ya2luZyBpbiBwYXJhbGxlbCBvbiBhIHNlcmllcyBhZGRpbmcgZGV2aWNlIGxpbmtz
IHRvIHRoZSBjbG9jawogIGZyYW1ld29yay4gVGhpcyB3YXkgd2hlbiBhIGRyaXZlciBjb25zdW1l
cyBhIGNsb2NrLCB0aGUgY2xvY2sKICBwcm92aWRlciBkcml2ZXIgd2lsbCBiZSByZXN1bWVkIGZp
cnN0LgoqIElmIHRoZSBjbG9jayBzZXJpZXMgSSBhbSB0YWxraW5nIGFib3V0IGlzIGFwcGxpZWQg
YWZ0ZXIgdGhpcyBvbmUsCiAgdGhlcmUgaXMgbm8gYnVpbGQgaXNzdWUuIE9mIGNvdXJzZSBzdXNw
ZW5kaW5nIHRoZSBwbGF0Zm9ybSBtYXkKICBub3Qgd29yayBidXQgdGhpcyBpcyBhIG5ldyBmZWF0
dXJlIHNvIG5vdGhpbmcgd2lsbCBiZSBicm9rZW4uCiogRGV2aWNlIGxpbmtzIGRvIG5vdCBlbmZv
cmNlIGFueSBwcmlvcml0eSBpZiB0aGUgc3VzcGVuZC9yZXN1bWUgcGhhc2UKICBiZXR3ZWVuIHR3
byBkcml2ZXJzIGlzIG5vdCB0aGUgc2FtZS4gVGhlIFBDSWUgZHJpdmVyIHN1c3BlbmRzIGluIHRo
ZQogIE5PSVJRIHBoYXNlLiBJZiB3ZSB3YW50IHRoZSBjbG9jayBkcml2ZXIgdG8gc3VzcGVuZCAq
YWZ0ZXIqIFBDSWUsIGl0cwogIHN1c3BlbmQvcmVzdW1lIGNhbGxiYWNrcyBtdXN0IGJlIHByb21v
dGVkIHRvIHRoZSBOT0lSUSBwaGFzZSBhcyB3ZWxsCiAgKGFuZCB0aGlzIGlzIHBhcnQgb2YgYW5v
dGhlciBzZXJpZXMpLiBBcyBvZiB0b2RheSB0aGVyZSBpcwogIG5vIGFsdGVybmF0aXZlLgoKClRo
YW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
