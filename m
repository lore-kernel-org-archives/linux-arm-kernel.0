Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A54C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:17:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B788F20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OSYE1kPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B788F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h6csDxvbKH1sW3oUJISaUn7S/OHI089Ntmb+FXHApZA=; b=OSYE1kPiNnjDnb
	IZhGgg9/lnc9aiUhHRLjMwzho8UWreRIzzS+Exoay/OCc4WkE0bNw/98pg9hOufLoC1sWx5kO225n
	MdsYo0Py79adeM3mdDEwFk/KT5bGaAWcf2QgP4NVud+q12SVQIjAweGvSaCBPiw0fbu7Q+3yceJz1
	nhiXc8FELxfTzwp7vcD2Ro3tQ5vfiRHwcRGr5+MD7ViHurPNg0ZqfREbIGe8OPuVWLVkIZ0IeyJ6f
	PgngUMOjpYI3E3aGBXjyF+8c73C/1est1TnnGaPhC1NmEV7QPHi0VZJZJJR6fZbCm/Cn3lCdv5+07
	ONKZdBajPtBguW8aCChw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwWs-0000g9-7d; Mon, 03 Dec 2018 22:17:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwWo-0000ez-8D
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:17:23 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A9141207AD; Mon,  3 Dec 2018 23:17:09 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id A78A220379;
 Mon,  3 Dec 2018 23:16:56 +0100 (CET)
Date: Mon, 3 Dec 2018 23:16:55 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Message-ID: <20181203231655.4e7dc330@xps13>
In-Reply-To: <154386483105.88331.13970025193347328031@swboyd.mtv.corp.google.com>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <201811231627.H7ojlKLL%fengguang.wu@intel.com>
 <20181123101132.6be3829c@xps13>
 <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
 <20181130112052.73d943ec@xps13>
 <154386483105.88331.13970025193347328031@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_141722_424410_B5FC54FC 
X-CRM114-Status: GOOD (  17.85  )
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
Cc: kbuild test robot <lkp@intel.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>, kbuild-all@01.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlcGhlbiwKClN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGUgb24gTW9u
LCAwMyBEZWMgMjAxOCAxMToyMDozMQotMDgwMDoKCj4gUXVvdGluZyBNaXF1ZWwgUmF5bmFsICgy
MDE4LTExLTMwIDAyOjIwOjUyKQo+ID4gSGkgU3RlcGhlbiwKPiA+IAo+ID4gU3RlcGhlbiBCb3lk
IDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZSBvbiBGcmksIDMwIE5vdiAyMDE4IDAxOjI2OjIwCj4g
PiAtMDgwMDoKPiA+ICAgCj4gPiA+IFF1b3RpbmcgTWlxdWVsIFJheW5hbCAoMjAxOC0xMS0yMyAw
MToxMTozMikgIAo+ID4gPiA+IFdvdWxkIHlvdSBhZ3JlZSB3aXRoIG1lIGFkZGluZyBkdW1teSBm
dW5jdGlvbnMgaW4gdGhlICNlbHNlIHNlY3Rpb24KPiA+ID4gPiBsaWtlOgo+ID4gPiA+IAo+ID4g
PiA+IHN0YXRpYyBpbmxpbmUgdm9pZCBfX2Nsa19kZXZpY2VfbGluayhzdHJ1Y3QgZGV2aWNlICpj
b25zdW1lciwgc3RydWN0IGNsayAqY2xrKQo+ID4gPiA+IHsKPiA+ID4gPiAgICAgICAgcmV0dXJu
Owo+ID4gPiA+IH0KPiA+ID4gPiAKPiA+ID4gPiBzdGF0aWMgaW5saW5lIHZvaWQgX19jbGtfZGV2
aWNlX3VubGluayhzdHJ1Y3QgY2xrICpjbGspCj4gPiA+ID4gewo+ID4gPiA+ICAgICAgICByZXR1
cm47Cj4gPiA+ID4gfQo+ID4gPiA+IAo+ID4gPiA+IERvIHlvdSB3YW50IG1lIHRvIGFsc28gZGVj
bGFyZSB0aGVzZSBmdW5jdGlvbnMgaW4gdGhlICNpZiBzZWN0aW9uCj4gPiA+ID4gKHdpdGggdGhl
IGV4dGVybmFsIGtleXdvcmQpIHRvIGJhbGFuY2UgdGhlIGFib3ZlIGRlY2xhcmF0aW9ucz8gICAg
Cj4gPiA+IAo+ID4gPiBXaHkgY2FuJ3Qgd2UgZG8gdGhlIGxpbmtpbmcgaW4gX19jbGtfZ2V0KCkg
YW5kIF9fY2xrX3B1dCgpPwo+ID4gPiAgIAo+ID4gCj4gPiBCZWNhdXNlIHdlIG5lZWQgdGhlIGNh
bGxlcidzICdzdHJ1Y3QgZGV2aWNlJyB0byBtYWtlIHRoZSBsaW5rIGFuZAo+ID4gdGhpcyBpcyBu
b3QgYXZhaWxhYmxlIGluIF9fY2xrX2dldCgpLiBJIHRyaWVkIHRvIGFkIGl0IGFzIHBhcmFtZXRl
ciBidXQKPiA+IEkgZG9uJ3QgdGhpbmsgaXQgaXMgcG9zc2libGUgdG8gcmV0cmlldmUgYSAnc3Ry
dWN0IGRldmljZScgZnJvbSB0aGUKPiA+IGRldmljZSBuYW1lLiBUaGUgZnVuY3Rpb25zIHdoZXJl
IHRoaXMgaXMgcHJvYmxlbWF0aWMgYXJlOgo+ID4gKiBjbGsuYzpfX29mX2Nsa19nZXRfZnJvbV9w
cm92aWRlcigpCj4gPiAqIGNsa2Rldi5jOmNsa19nZXRfc3lzKCkKPiA+IAo+ID4gQnkgdGhlIHdh
eSBpbiBteSBuZXcgdmVyc2lvbiBJIGNhbGxlZCB0aGUgaGVscGVyczoKPiA+ICogY2xrX3tsaW5r
LHVubGlua31faGllcmFyY2h5KCkKPiA+ICogY2xrX3tsaW5rLHVubGlua31fY29uc3VtZXIoKQo+
ID4gCj4gPiBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHdpdGggdGhlc2UgaGVscGVycywgYnV0
IGlmIHlvdSBoYXZlIGFueXRoaW5nCj4gPiBpbiBtaW5kIHRvIGhlbHAgbWUgYWNoaWV2ZSB0aGUg
YWJvdmUgcmVxdWVzdCwgSSB3aWxsIHdlbGNvbWUgdGhlIGlkZWEuCj4gPiAgIAo+IAo+IFdlIGNh
biBkbyB0aGUgbGlua2luZyBpbiBfX2Nsa19nZXQoKSBhbmQgX19jbGtfcHV0KCkgaWYgd2UgcG9r
ZSBpbnRvIHRoZQo+IHN0cnVjdCBjbGsgLT4gc3RydWN0IGNsa19jb3JlIGFuZCBidXJ5IHRoZSBz
dHJ1Y3QgZGV2aWNlIGludG8gZWFjaAo+IGNsa19jb3JlIHN0cnVjdHVyZS4KPiAKCkkgbWVhbnQg
dGhlIGNvbnN1bWVyIGRldmljZSdzIHN0cnVjdHVyZS4gWWVzLCBmcm9tIGEgc3RydWN0IGNsaywg
dGhlCmZpcnN0IGNoYW5nZSBpbiBwYXRjaCAxLzIgbGV0J3MgdXMgZG8gY2xrLT5jb3JlLT5kZXYg
dG8gZ2V0IHRoZSBjbG9jawpkZXZpY2UuIEJ1dCBmb3IgbGlua2luZyBJIG5lZWQgYm90aCB0aGUg
Y2xvY2sgZGV2aWNlIGFuZCB0aGUgY29uc3VtZXIKZGV2aWNlOyBhbmQgdGhlIGxhdHRlciB3aWxs
IGJlIG1pc3NpbmcgaW4gX19jbGtfZ2V0KCkuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
