Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9777C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:54:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC0721874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EIfkMOGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC0721874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lp3ewFQ7KCNvNK+yVpu4FkCucrF+dSyKyDr3V9jJGhk=; b=EIfkMOGnC5sNIL
	o05sBqflwxPZSxPsDbLGu5e6YvDVqQDKrTCYjKX9Em3i/xYj+ySCCrFjBQYuiCl3Coh+gpqc0yVIp
	sRSdhlPruT//31n5OnjzN5CYDm/zRGBbsA/ditmgdEeB7ZzV6OwjxS4DIT2P09I9Ia4wZY616NNRx
	2RlFoyoajTuNhiZoJ2qPWuIx8aa3eto78ZBvi9OlO6p8wz1jIhYhEUjOxB5PETPdkpI0srO/qb07h
	eM1RTJu+O5tsInMogHeLA/ir+y/qGhPQVqGTajbZ/Swlj4JCK44o1NtlMqZWHJJ04g8LlX95Pghe9
	0r0d0lXZUc/9a2LNETZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfRnZ-0001IT-Gw; Fri, 04 Jan 2019 15:54:13 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfRnW-0001I0-BR
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 15:54:12 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 68A8B2075E; Fri,  4 Jan 2019 16:54:07 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr
 [90.88.149.148])
 by mail.bootlin.com (Postfix) with ESMTPSA id 17ED4206A6;
 Fri,  4 Jan 2019 16:54:07 +0100 (CET)
Date: Fri, 4 Jan 2019 16:54:06 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/4] clk: core: link consumer with clock driver
Message-ID: <20190104165406.3b52399a@xps13>
In-Reply-To: <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-3-miquel.raynal@bootlin.com>
 <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_075410_662960_0B49E327 
X-CRM114-Status: GOOD (  21.77  )
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
IT0gTlVMTC4KClRoYW5rcyBmb3IgdGhlIGhlbHA7IEkgdXBkYXRlZCBteSB3b3JrIG9uIHRvcCBv
ZiB5b3VycywgaXQgbG9va3Mgb2sgYnV0CkkgbmVlZCB0byBydW4gc29tZSBtb3JlIHRlc3RzLgoK
SG93ZXZlciBJIGhhZCB0byB0d2VhayBhIHBhcmFtZXRlciBpbiBvbmUgb2YgeW91ciByZWNlbnQg
Y2hhbmdlcywgeW91CnVzZWQgJy0xJyBhcyBpbmRleCBpbiBfX29mX2Nsb2NrX2dldCgpIHdoaWxl
IGl0IGlzIG5vdCBhIHZhbGlkIHZhbHVlCihyZXR1cm5pbmcgYW4gZXJyb3IpLiBBcyBpbiB0aGUg
X19vZl9jbGtfZ2V0X2J5X25hbWUoKSBmdW5jdGlvbiB5b3UKcmVtb3ZlZCBpbmRleCB3YXMganVz
dCBzZXQgdG8gMCBhdCB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbiwgSSB0aGluayB0aGUKYmVsb3cg
Zml4IGlzIHZhbGlkLgoKClRoYW5rcywKTWlxdcOobAoKCi0tLQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL2Nsa2Rldi5jIGIvZHJpdmVycy9jbGsvY2xrZGV2LmMKaW5kZXggYmE0ZDFlMDY3MzJk
Li5mMmY0ZjJhZmQyOGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2xrL2Nsa2Rldi5jCisrKyBiL2Ry
aXZlcnMvY2xrL2Nsa2Rldi5jCkBAIC0xNjMsNyArMTYzLDcgQEAgc3RydWN0IGNsayAqY2xrX2dl
dChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKmNvbl9pZCkKICAgICAgICBzdHJ1Y3Qg
Y2xrX2h3ICpodzsKIAogICAgICAgIGlmIChkZXYgJiYgZGV2LT5vZl9ub2RlKSB7Ci0gICAgICAg
ICAgICAgICBodyA9IG9mX2Nsa19nZXRfaHcoZGV2LT5vZl9ub2RlLCAtMSwgY29uX2lkKTsKKyAg
ICAgICAgICAgICAgIGh3ID0gb2ZfY2xrX2dldF9odyhkZXYtPm9mX25vZGUsIDAsIGNvbl9pZCk7
CiAgICAgICAgICAgICAgICBpZiAoIUlTX0VSUihodykgfHwgUFRSX0VSUihodykgPT0gLUVQUk9C
RV9ERUZFUikKICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGNsa19od19jcmVhdGVfY2xr
KGRldiwgaHcsIGRldl9pZCwgY29uX2lkKTsKICAgICAgICB9CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
