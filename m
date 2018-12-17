Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26665C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:24:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A9E20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s54+T5WA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A9E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SQIV5gcHfo9CPP0pWh5Fp7JK8k1HEahdmE3yg7TwOmc=; b=s54+T5WAog4bT+
	WymzPVmJ11ujaA5QVnlIIYLn5TIUFs/JCn55x+bdBolG0jVDuPB65nsYHClo29F14vW1xHJICwX69
	5uztgi5CqJMeKiicRSOafP8HSocA5mBnSDP5opIUXCKqz3p9sVNkN8gqUxVKPWsgmC75SHpXZNy2g
	+tiAvE15QXvRK8CFaZqZCGaAA6QcH/KVjLYFg70e0T89U8lo0/A2sb0Vtg6ySjnfJgqTX+Fn7Ri/B
	NaqRjYvuDKA0xXYWWtQ3EFhLAduQlj2rlPdVwXnfrO5hBkheYAWt+Z586oV/hgqF+tgbFvT/Xg27H
	OoyHbPmVm7gPQU608hEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtpC-0006TK-Ac; Mon, 17 Dec 2018 14:24:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtp9-0006Qs-2W
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:24:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8AA0320CDB; Mon, 17 Dec 2018 15:24:35 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3517720DC3;
 Mon, 17 Dec 2018 15:24:25 +0100 (CET)
Date: Mon, 17 Dec 2018 15:24:25 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/4] clk: core: link consumer with clock driver
Message-ID: <20181217152425.7d76a8de@xps13>
In-Reply-To: <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-3-miquel.raynal@bootlin.com>
 <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_062447_246530_36E48EEE 
X-CRM114-Status: GOOD (  18.73  )
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
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlcGhlbiwKClN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGUgb24gVHVl
LCAxMSBEZWMgMjAxOCAwOToxMjo1NQotMDgwMDoKCj4gU29ycnksIEknbSBub3QgcmV2aWV3aW5n
IHRoZSB3aG9sZSBwYXRjaCByaWdodCBub3csIGp1c3QgdGhpcyBvbmUgbGl0dGxlCj4gYml0IGJl
Y2F1c2UgSSdtIGFsc28gd29ya2luZyBpbiB0aGUgc2FtZSBhcmVhLgo+IAo+IFF1b3RpbmcgTWlx
dWVsIFJheW5hbCAoMjAxOC0xMi0wNCAxMToyNDozOCkKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2Nsay1wcm92aWRlci5oIGIvaW5jbHVkZS9saW51eC9jbGstcHJvdmlkZXIuaAo+ID4g
aW5kZXggNjBjNTE4NzFiMDRiLi43MjFkNmI1NWIyZmEgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2Nsay1wcm92aWRlci5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Nsay1wcm92aWRl
ci5oCj4gPiBAQCAtNzgxLDYgKzc4MSw4IEBAIHZvaWQgZGV2bV9jbGtfaHdfdW5yZWdpc3Rlcihz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjbGtfaHcgKmh3KTsKPiA+ICBjb25zdCBjaGFyICpf
X2Nsa19nZXRfbmFtZShjb25zdCBzdHJ1Y3QgY2xrICpjbGspOwo+ID4gIGNvbnN0IGNoYXIgKmNs
a19od19nZXRfbmFtZShjb25zdCBzdHJ1Y3QgY2xrX2h3ICpodyk7Cj4gPiAgc3RydWN0IGNsa19o
dyAqX19jbGtfZ2V0X2h3KHN0cnVjdCBjbGsgKmNsayk7Cj4gPiArdm9pZCBjbGtfbGlua19jb25z
dW1lcihzdHJ1Y3QgZGV2aWNlICpjb25zdW1lciwgc3RydWN0IGNsayAqY2xrKTsKPiA+ICt2b2lk
IGNsa191bmxpbmtfY29uc3VtZXIoc3RydWN0IGNsayAqY2xrKTsgIAo+IAo+IFdlIHNob3VsZG4n
dCBuZWVkIHRvIGFkZCB0aGVzZSBmdW5jdGlvbnMgYXMgZmFyIGFzIEkgY2FuIHRlbGwuIFRoYXQn
cwo+IGJlY2F1c2UgX19jbGtfZ2V0KCkgaGFzIGJlY29tZSBhbiBpbnRlcm5hbCBBUEkgYmV0d2Vl
biBjbGtkZXYuYyBhbmQKPiBjbGsuYyB0aGF0IGRvZXMgbm90aGluZyBub3cgb24gaW1wbGVtZW50
YXRpb25zIHRoYXQgYXJlbid0IHRoZSBDQ0YuIFdlCj4gY2FuIGV2ZW4gY2hhbmdlIHRoaXMgQVBJ
IHRvIHRha2UgYSBjbGtfaHcgcG9pbnRlciBpbnN0ZWFkIG9mIGEgY2xrCj4gcG9pbnRlci4KPiAK
PiBJJ2QgcmF0aGVyIHNlZSB1cyBwbHVtYiBhIHN0cnVjdCBkZXZpY2UgYW5kIGNsa19odyBzdHJ1
Y3R1cmUgZG93biBpbnRvCj4gX19jbGtfZ2V0KCkgYW5kIGZvbGQgaXQgYWxsIGludG8gX19jbGtf
Y3JlYXRlX2NsaywgcG9zc2libHkgZXZlbgo+IHJlbmFtaW5nIF9fY2xrX2NyZWF0ZV9jbGsgdG8g
Y2xrX2h3X2NyZWF0ZV9jbGsoKS4gVGhhdCB3YXkgd2UgY2FuIGdldAo+IHRoZSBjYWxsaW5nIGRl
dmljZSBhbmQgY2xrX2h3IHBvaW50ZXIgaW4gb25lIGNhbGwgaW4gdGhlIGNsayBmcmFtZXdvcmss
Cj4gYWxvbmcgd2l0aCB0aGUgZGV2aWNlIG5hbWUgYW5kIGNvbm5lY3Rpb24gbmFtZSwgYW5kIHRo
ZW4gZ2VuZXJhdGUgdGhlCj4gc3RydWN0IGNsayByaWdodCB0aGVyZS4gVGhpcyBjYW4gc2ltcGxp
Znkgc29tZSBjb2RlIGFuZCBtYWtlIGl0IGVhc2llcgo+IHRvIGV4dGVuZCB0aGlzIHRvIGFzc29j
aWF0ZSBjYWxsaW5nIGRldmljZXMgd2l0aCB0aGUgY2xrIGNvbnN1bWVyCj4gc29tZWhvdy4KPiAK
PiBIZXJlJ3MgdGhlIGRpZmYuIFdpdGggdGhpcywgeW91IHNob3VsZCBiZSBhYmxlIHRvIGFkZCBh
bmQgcmVtb3ZlIGRldmljZQo+IGxpbmtzIGluIGNsa19od19jcmVhdGVfY2xrKCkgd2hlbiBkZXYg
IT0gTlVMTC4KClRoYW5rcyBmb3IgdGhlIHBvaW50ZXJzLCBpZiB5b3UgdGhpbmsgd2Ugc2hvdWxk
IG1vZGlmeSB0aGUgQVBJIHRoZW4KaXQncyBmaW5lIGJ5IG1lLCBJIHdpbGwgaW50ZWdyYXRlIHlv
dXIgZGlmZiBhbmQgdHJ5IHRvIHByb3Bvc2UKc29tZXRoaW5nIGluIHN5bmMgd2l0aCB5b3VyIGNv
bW1lbnRzIHRoaXMgd2Vlay4KClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
