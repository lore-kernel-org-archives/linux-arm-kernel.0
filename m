Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:35:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6AF20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KxYYeK8a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="21v7zS0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6AF20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ff8XyQJ38fxUZ+/gxxl3UOnzYrySkVtvUg18kzGJ9Nk=; b=KxYYeK8aIWO72K
	QMpQb5+YImT1+FEnDw9CFq6U9lezMMczEF+h9zEMEV+pAhVHm3oiUjKVd8ErWWA/tE7/ZbKhBDXQz
	Q5bsVGSTpfOeksYJRbP/a5O4obo0HpFrRgBF87DFl/VKxWd7syFiu1GwSehBvvikNtxlKx3V5h/pw
	z0Q0ofhiv6AxWPRsHnIHnIk+XiTiW78CDeRtAY1DwhAvC1xdZxuiI2q23cc2yHyjXZW3/XSeirxze
	HSyPRh4cZsg0pnJ8afsRYmjUWjnxsDtOylgG98Q2RFEcBXWvNeGBLgUxCfsQIQGDOQJPVtRXXhkcW
	MAinr/gmtzdmUAuJniPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghwxg-0000Sf-3U; Fri, 11 Jan 2019 13:35:00 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwww-0008Cn-NS
 for linux-arm-kernel@bombadil.infradead.org; Fri, 11 Jan 2019 13:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fieQD5mdlQbQcBrRxiWBRA0RYHLY7zLqiKA+no3hZ8I=; b=21v7zS0FeLrXdN36GszZhkVYqq
 tFK1CB3PwDzIEjbfwmxGy+lrpCZ0kqm/7wvCOFBQyAKEjxwatz4Kn5euz+0Igu7IjpJfxDINgpUdC
 Xja+JcqqWBNTc+szzIq9fp1uijYaSky5+YPndLG3Ln3CPEdOtxQ6wwNCNNo73eBHC957ycjx32eta
 bdbEVGx0AOXdwl2iOlXwS+6VvtdUp5f8aszDrEZzVfDnbHbz0TKEjNLKnVgcl2T7rXNySjh5E4SzT
 REfuBpt7pEa5JVD+YrE07c0brkdsiHBap5EhIGwy3NYC/O5A239pIQAVJuGsL3AjWa8eDgDJqu2KN
 oOM48xRw==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwwt-0000iW-5U
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:34:12 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9BBAD22445; Fri, 11 Jan 2019 14:34:05 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3B926206A7;
 Fri, 11 Jan 2019 14:34:05 +0100 (CET)
Date: Fri, 11 Jan 2019 14:34:04 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/7] Bring suspend to RAM support to MVEBU SATA
Message-ID: <20190111143404.518723a3@xps13>
In-Reply-To: <35c5cdcf-0d89-9236-7937-0c750a781d13@kernel.dk>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
 <35c5cdcf-0d89-9236-7937-0c750a781d13@kernel.dk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_083411_332154_8FA9B880 
X-CRM114-Status: GOOD (  17.42  )
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
 Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmVucywKCkplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4gd3JvdGUgb24gVHVlLCA0IERl
YyAyMDE4IDE3OjExOjE4IC0wNzAwOgoKPiBPbiAxMi80LzE4IDEyOjI4IFBNLCBNaXF1ZWwgUmF5
bmFsIHdyb3RlOgo+ID4gSGVsbG8sCj4gPiAKPiA+IEFzIHBhcnQgb2YgYW4gZWZmb3J0IHRvIGJy
aW5nIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQgdG8gQXJtYWRhIDM3MDAKPiA+IFNvQ3MgKG1haW4g
dGFyZ2V0OiBFU1BSRVNTT2JpbiksIHRoaXMgc2VyaWVzIGhhbmRsZXMgdGhlIHdvcmsgYXJvdW5k
Cj4gPiB0aGUgU0FUQSBJUC4KPiA+IAo+ID4gRmlyc3QsIGEgY2hhbmdlIGluIHRoZSBsaWJhaGNp
IHBsYXRmb3JtIGFkZHMgc3VwcG9ydCBmb3IgdGhlIG5ldyBQSFkKPiA+IGZyYW1ld29yayBieSBm
b2xsb3dpbmcgdGhlIHBoeV9zZXRfbW9kZSgpL3BoeV9wb3dlcl9vbigpCj4gPiBzZXF1ZW5jZS4g
VGhlbiwgdGhlIEFIQ0kgTVZFQlUgZHJpdmVyIGlzIGEgYml0IHVwZGF0ZWQgKHBhdGNoIDIgJiAz
KQo+ID4gYW5kIGEgbWlzc2luZyBpbml0aWFsaXphdGlvbiBpcyBhZGRlZCBmb3IgdGhlIEEzNzAw
IGluIHBhdGNoIDQgKG9ubHkKPiA+IGRvbmUgYnkgdGhlIEJvb3Rsb2FkZXIgYmVmb3JlKS4gTWlz
c2luZyBjbG9jayBzdXBwb3J0IGlzIGltcGxlbWVudGVkCj4gPiBpbiBwYXRjaCA1IHRvIGJlIHN1
cmUgdGhlIGNsb2NrIHdpbGwgYmUgcmVzdW1lZCBiZWZvcmUgdGhpcyBkcml2ZXIKPiA+IChzZWUg
WzFdIGZvciB0aGUgc2VyaWVzIGFkZGluZyBkZXZpY2UgbGlua3MgdG8gdGhlIGNsb2NrIGNvcmUp
Lgo+ID4gCj4gPiBGaW5hbGx5LCBkZXZpY2UgdHJlZXMgYXJlIHVwZGF0ZWQgdG8gcmVmbGVjdCB0
aGUgaGFyZHdhcmU6IHRoZSBtaXNzaW5nCj4gPiBQSFkgaXMgYWRkZWQgdG8gdGhlIEVTUFJFU1NP
YmluIERULCBhbmQgdGhlIGNsb2NrIGlzIGFkZGVkIHRvIHRoZSBTb0MKPiA+IERUIChwYXRjaCA2
ICYgNykuIEJpbmRpbmdzIGFscmVhZHkgZG9jdW1lbnQgdGhlIGNsb2NrIGFuZCB0aGUgUEhZIHNv
Cj4gPiBubyB1cGRhdGUgaXMgbmVlZGVkIG9uIHRoaXMgcmVnYXJkLiAgCj4gCj4gUHJvYmFibHkg
dGhlIGJlc3QvZWFzaWVzdCB0byBxdWV1ZSB0aGlzIHRocm91Z2ggdGhlIGxpYmF0YSB0cmVlIGZv
cgo+IDQuMjEuIEFncmVlPwo+IAoKSXQgbG9va3MgbGlrZSB0aGlzIHBhdGNoc2V0IGdvdCBsZWZ0
IGFzaWRlIGZvciA1LjAsIHNoYWxsIEkgcmUtc2VuZD8gKEkKcmViYXNlZCBvbiB0b3Agb2YgNS4w
IGFuZCB0aGUgc2VyaWVzIGFwcGxpZWQgZmluZSkuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
