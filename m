Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54618C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:32:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F628214DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TkVtLIrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F628214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3BOcvGctOyov3tkgIIJoRoiDGvrZDLlYL81Ib7drkTg=; b=TkVtLIrjmTWMvS
	UZovedMM18Ekkp8qhAwcXJeevse/kPMtQx60m3onaeStWOsg8VYn7lCuLKYu5MhS5OH1mOYdMZScO
	3CbSdNElOSmLmuCcYWKvpleJMkem05Uqa0uEFfWSoOEwRVkLfHFQh6xhPZQ24F+Mmyi+ICeGTR7nn
	gHtmDEXtSB7PYJ5txk7M4sIk6g906OV5zKJXS0ow5SLUlmKdPbtHqSX2/+2SH/Ah1biFDJqr6U7vd
	NPIumUikXd/8rnAMoUeVg2Zexn5bC6yQ4Q9DsSJegQ3Q1MVwQeqbfmR6Wp9o55G0jG91Wh/+8qDxn
	3ZgFRQ1POprAXQXvHqyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUrtN-00069z-SE; Thu, 06 Dec 2018 11:32:30 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUrtK-000684-Ej
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:32:28 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gUrt0-0005hB-Uw; Thu, 06 Dec 2018 12:32:06 +0100
Message-ID: <1544095925.3709.61.camel@pengutronix.de>
Subject: Re: [PATCH 4/5] irqchip/irq-imx-gpcv2: Make error messages more
 consistent
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Marc Zyngier
 <marc.zyngier@arm.com>
Date: Thu, 06 Dec 2018 12:32:05 +0100
In-Reply-To: <20181206073125.7255-5-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
 <20181206073125.7255-5-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_033226_653360_449FAA33 
X-CRM114-Status: GOOD (  13.03  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzozMSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Ogo+IE1ha2UgZXJyb3IgbWVzc2FnZXMgbW9yZSBjb25zaXN0ZW50IGJ5IG1ha2luZyBz
dXJlIGVhY2ggc3RhcnRzIHdpdGgKPiAiJXBPRjoiLgo+IAo+ID4gQ2M6IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPgo+ID4gQ2M6IEphc29uIENvb3BlciA8amFzb25AbGFrZWRh
ZW1vbi5uZXQ+Cj4gPiBDYzogTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNvbT4KPiBD
YzogY3BoZWFseUBnbWFpbC5jb20KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5kZQo+ID4gQ2M6
IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Cj4gPiBDYzogIkEucy4g
RG9uZyIgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgo+ID4gQ2M6IFJpY2hhcmQgWmh1IDxob25neGlu
Zy56aHVAbnhwLmNvbT4KPiBDYzogbGludXgtaW14QG54cC5jb20KPiBDYzogbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcKPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU21pcm5vdiA8YW5kcmV3LnNtaXJub3ZAZ21haWwu
Y29tPgoKUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoK
PiAtLS0KPiDCoGRyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWdwY3YyLmMgfCA0ICsrLS0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWdwY3YyLmMgYi9kcml2ZXJzL2lycWNoaXAv
aXJxLWlteC1ncGN2Mi5jCj4gaW5kZXggMDc3ZDU2YjMxODNhLi5jMmIyYjMxMjhkZGQgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtZ3BjdjIuYwo+ICsrKyBiL2RyaXZlcnMv
aXJxY2hpcC9pcnEtaW14LWdwY3YyLmMKPiBAQCAtMjEyLDcgKzIxMiw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IGlteF9ncGN2Ml9pcnFjaGlwX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpub2RlLAo+
IMKgCj4gPiDCoAljZCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBncGN2Ml9pcnFjaGlwX2RhdGEp
LCBHRlBfS0VSTkVMKTsKPiA+IMKgCWlmICghY2QpIHsKPiA+IC0JCXByX2Vycigia3phbGxvYyBm
YWlsZWQhXG4iKTsKPiA+ICsJCXByX2VycigiJXBPRjoga3phbGxvYyBmYWlsZWQhXG4iLCBub2Rl
KTsKPiA+IMKgCQlyZXR1cm4gLUVOT01FTTsKPiA+IMKgCX0KPiDCoAo+IEBAIC0yMjAsNyArMjIw
LDcgQEAgc3RhdGljIGludCBfX2luaXQgaW14X2dwY3YyX2lycWNoaXBfaW5pdChzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5vZGUsCj4gwqAKPiA+IMKgCWNkLT5ncGNfYmFzZSA9IG9mX2lvbWFwKG5vZGUs
IDApOwo+ID4gwqAJaWYgKCFjZC0+Z3BjX2Jhc2UpIHsKPiA+IC0JCXByX2VycigiZnNsLWdwY3Yy
OiB1bmFibGUgdG8gbWFwIGdwYyByZWdpc3RlcnNcbiIpOwo+ID4gKwkJcHJfZXJyKCIlcE9GOiB1
bmFibGUgdG8gbWFwIGdwYyByZWdpc3RlcnNcbiIsIG5vZGUpOwo+ID4gwqAJCWtmcmVlKGNkKTsK
PiA+IMKgCQlyZXR1cm4gLUVOT01FTTsKPiA+IMKgCX0KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
