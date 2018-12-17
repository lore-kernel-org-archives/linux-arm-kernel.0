Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D62C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:56:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9A72146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LchQtj0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9A72146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i7LVI7cQWBzsLWRm+amH1oukrfKS0hMnkxJA5wGFAj4=; b=LchQtj0gATL39h
	7ZXM4vSsqU/zGsa4XxtpfqKDrxSiJtA7SpuMVc+kl5+oHD7PQG2dwL5HB3BjpEOOJO2cFPT3gvAqB
	eG5jPzVa2Lzg6jBaruGsaxCjyiyScRxm2NsDfnf5K+c+z0enT/hqK7cwtIjLUI3tY+1e4CU2Se3XC
	tqtsWQzmzIuXtL6R6Bf6w5sPlEjmoGIzFw2WHLEGKIVzGVIPksErqnEqABwVM0FjMzSIhrZYzjY+8
	/WXIvPPk1x9HgyFEwX6VU6F282THNmqoduVWUIa9jZ98RKr5gp15XiSTl3A8nFiwj6PQSi/L1oJLS
	dTRsqHHqP4O/X1nNOFPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYvGA-0000kl-SC; Mon, 17 Dec 2018 15:56:46 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYvFo-0000Ib-T5
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:56:30 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 7E03A20733; Mon, 17 Dec 2018 16:56:13 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0DA1C20726;
 Mon, 17 Dec 2018 16:56:03 +0100 (CET)
Date: Mon, 17 Dec 2018 16:56:03 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/7] phy: add A3700 COMPHY support
Message-ID: <20181217165603.602a7a42@xps13>
In-Reply-To: <20181217165223.6f98b8a4@windsurf>
References: <20181213083908.14180-1-miquel.raynal@bootlin.com>
 <20181213083908.14180-4-miquel.raynal@bootlin.com>
 <20181217164857.68df3f84@xps13> <20181217165223.6f98b8a4@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_075625_735988_6975CCC0 
X-CRM114-Status: GOOD (  16.48  )
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
 Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Evan Wang <xswang@marvell.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVGhvbWFzLAoKVGhvbWFzIFBldGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNv
bT4gd3JvdGUgb24gTW9uLCAxNyBEZWMKMjAxOCAxNjo1MjoyMyArMDEwMDoKCj4gSGVsbG8sCj4g
Cj4gT24gTW9uLCAxNyBEZWMgMjAxOCAxNjo0ODo1NyArMDEwMCwgTWlxdWVsIFJheW5hbCB3cm90
ZToKPiAKPiA+IEkgcmVjZWl2ZWQgdGhlIGZvbGxvd2luZyBidWcgcmVwb3J0IGJlY2F1c2UgSSBh
ZGRlZCBhIGRlcGVuZGVuY3kgb24KPiA+IENPTVBJTEVfVEVTVCBpbiBLY29uZmlnOgo+ID4gCj4g
PiAgICAgICAgIGNvbmZpZzogaTM4Ni1hbGxtb2Rjb25maWcgKGF0dGFjaGVkIGFzIC5jb25maWcp
IGNvbXBpbGVyOgo+ID4gICAgICAgICBnY2MtNyAoRGViaWFuIDcuMy4wLTEpIDcuMy4wIHJlcHJv
ZHVjZToKPiA+ICAgICAgICAgICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8g
bGludXggYnVpbGQgdHJlZQo+ID4gICAgICAgICAgICAgICAgIG1ha2UgQVJDSD1pMzg2IAo+ID4g
Cj4gPiAgICAgICAgIEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToKPiA+ICAg
Cj4gPiAgICAgICAgID4+IEVSUk9SOiAiX19hcm1fc21jY2Nfc21jIiBbZHJpdmVycy9waHkvbWFy
dmVsbC9waHktbXZlYnUtYTM3MDAtY29tcGh5LmtvXSB1bmRlZmluZWQhICAgICAgCj4gPiAKPiA+
IFVubGVzcyBzb21lb25lIGNvbXBsYWlucywgSSB3aWxsIGRyb3AgdGhlIGRlcGVuZGVuY3kgb24g
Q09NUElMRV9URVNUIGluCj4gPiBLY29uZmlnLiAgCj4gCj4gS2VlcCBDT01QSUxFX1RFU1QsIGFu
ZCBhZGQ6Cj4gCj4gCWRlcGVuZHMgb24gSEFWRV9BUk1fU01DQ0MKPiAKPiBwZXJoYXBzID8KCk9o
IHRoYXQncyBhIGNvb2wgS2NvbmZpZyBlbnRyeS4gRm9yZ290IGFib3V0IGl0LCB0aGFua3MgZm9y
IHRoZQpwb2ludGVyIQoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
