Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F30FC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:33:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F0120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gg04f62J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F0120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kPHl/1/drAlYU8j8S1PVpl8TAotBfJ1DMLoQ359OBjM=; b=gg04f62J8dHFo3
	GnjTn0gUfsZFB64SaaL9RNcV/lTefkykwUJXFqsBKiA+lBXA8ikj+IC+QlBMSH2FFgASMBScIL+Ku
	RSFhegNLb3R/206dKZ2pC9roZRiFL1s9uERX2DARhiSZ+f+m25q+wscv3q8JSvidrz3Lqnvj6+TD2
	jhjBE2NcqTIQh4FSGGyws3q8Rt/nH46nYOhsLycmJy7xQkULavJOHK/w9YklThZG2+ZaMcYEW7OX0
	oC7mmdEuamXNcRwHYuL+AJ8xcDvOnZ6TMoGzlIRPi4bZsT3Amv4GCJWRo2kwSHHb+J+OplbUjjnJ+
	8h4Sjvfkat4g+aT5WOJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXS3Q-0006QB-Mm; Thu, 13 Dec 2018 14:33:32 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXS3N-0006Ng-M0
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 14:33:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 307032079D; Thu, 13 Dec 2018 15:33:18 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4F74D20510;
 Thu, 13 Dec 2018 15:33:07 +0100 (CET)
Date: Thu, 13 Dec 2018 15:33:06 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper
 <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 10/12] ARM64: dts: marvell: armada-3720-espressobin:
 declare PCIe reset GPIO
Message-ID: <20181213153306.4fc3b511@xps13>
In-Reply-To: <20181212102142.16053-11-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-11-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_063329_860887_90FC99A2 
X-CRM114-Status: GOOD (  14.25  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZSBv
biBXZWQsIDEyIERlYyAyMDE4CjExOjIxOjQwICswMTAwOgoKPiBBZGQgYSByZXNldC1ncGlvcyBw
cm9wZXJ0eSB0byB0aGUgUENJZSBub2RlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXlu
YWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gLS0tCj4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvbWFydmVsbC9hcm1hZGEtMzcyMC1lc3ByZXNzb2Jpbi5kdHMgfCAzICsrKwo+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWFydmVsbC9hcm1hZGEtMzcyMC1lc3ByZXNzb2Jpbi5kdHMgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRzCj4gaW5kZXggMDk0OTk0
YTljNjhlLi43NmE1MDhkYTgwYjkgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2FybWFkYS0zNzIwLWVzcHJlc3NvYmluLmR0cwo+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWFydmVsbC9hcm1hZGEtMzcyMC1lc3ByZXNzb2Jpbi5kdHMKPiBAQCAtNDYsNiArNDYs
OSBAQAo+ICAvKiBKOSAqLwo+ICAmcGNpZTAgewo+ICAJc3RhdHVzID0gIm9rYXkiOwo+ICsJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiArCXBpbmN0cmwtMCA9IDwmcGNpZV9waW5zPjsKPiAr
CXJlc2V0LWdwaW9zID0gPCZncGlvc2IgMyBHUElPX0FDVElWRV9ISUdIPjsKPiAgfTsKPiAgCj4g
IC8qIEo2ICovCgpXaGlsZSB0aGlzIGNoYW5nZSBtYXkgYmUgZmluZSBmb3IgcGxhdGZvcm1zIGJh
c2VkIG9uIEFybWFkYSAzNzAwIFNvQywKaXQgaXMgbm90IGZvciB0aGUgRXNwcmVzc29CaW4gdGhh
dCBoYXMgbm8gcmVzZXQgR1BJTyBmb3IgUENJZSBhbmQKaW5zdGVhZCB1c2VzIHRoaXMgcGluIHRv
IGNvbnRyb2wgdGhlIEV0aGVuZXQgc3dpdGNoLgoKSSB3aWxsIHJlLXNlbmQgYSBzZXJpZXMgd2l0
aG91dCB0aGlzIHBhdGNoLiBJIHRoaW5rIGl0IGRvZXMgbm90IGh1cnQgdG8Ka2VlcCB0aGUgcHJl
dmlvdXMgcGF0Y2ggYWRkaW5nIHRoZSBwaW5tdXggc2V0dGluZyBpbiB0aGUKQXJtYWRhLTM3eHgu
ZHRzaSBmaWxlIGV2ZW4gd2l0aG91dCB1c2luZyBpdCwgc28gSSB3aWxsIGRyb3Agb25seSB0aGlz
CnBhdGNoLgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
