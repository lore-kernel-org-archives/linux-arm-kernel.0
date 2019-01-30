Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC10C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA5720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QSgR9CwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA5720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=izZ9FWafG4u4ZHIY1enObFUF7JuRVbOE9p75wrJDISQ=; b=QSgR9CwU27hjTT
	iamZ8J0VI1b3nU4xpsjUQlrSPDW+XCF4YJWO91cejoMtEVbklgnsX6yeczmsbCEXMguHAnzG8eWlA
	7G7bkiZ+Emis8F88XT3KDAtKPsIMnEwwwxWTiD+2bQZtJigncSN4e4VjQqR456OxusCgwsJ86fFEc
	NijLFdp704XciHe+8vOfxGcayVqvgG7smrKpEoBKcK3izU+aqoiPT/Iy1y0KJk0eWsDgEe8zR+jti
	wdkIFfvNzdtPMqTHCqoX8b70QnazZCKegxndRzNEvf/3zAehe5W6hoJbzk+hMpnUTdbHl6703qITe
	2El5hy8FIh/+ejW5IzpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goq4n-0004W2-BM; Wed, 30 Jan 2019 13:38:49 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goq4k-0004VO-K8; Wed, 30 Jan 2019 13:38:48 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jan 2019 05:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="139178088"
Received: from wchen25-mobl9.ccr.corp.intel.com ([10.249.173.109])
 by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2019 05:38:42 -0800
Message-ID: <1548855520.2161.3.camel@intel.com>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
From: Zhang Rui <rui.zhang@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Pi-Hsun Shih
 <pihsun@chromium.org>
Date: Wed, 30 Jan 2019 21:38:40 +0800
In-Reply-To: <49dbd0af-975e-cafb-d1b9-4e491a6c9383@linaro.org>
References: <20190109055724.184692-1-pihsun@chromium.org>
 <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
 <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
 <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
 <49dbd0af-975e-cafb-d1b9-4e491a6c9383@linaro.org>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_053846_706129_F3ED4F09 
X-CRM114-Status: GOOD (  19.30  )
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
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Michael.Kao@mediatek.com,
 Eduardo Valentin <edubezval@gmail.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24g5LiJLCAyMDE5LTAxLTMwIGF0IDExOjA0ICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToK
PiBPbiAzMC8wMS8yMDE5IDEwOjI1LCBQaS1Ic3VuIFNoaWggd3JvdGU6Cj4gPiAKPiA+IE9uIFdl
ZCwgSmFuIDMwLCAyMDE5IGF0IDM6NDQgUE0gRGFuaWVsIExlemNhbm8KPiA+IDxkYW5pZWwubGV6
Y2Fub0BsaW5hcm8ub3JnPiB3cm90ZToKPiA+ID4gCj4gPiA+IAo+ID4gPiBPbiAzMC8wMS8yMDE5
IDA3OjA0LCBQZXRlciBTaGloIHdyb3RlOgo+ID4gPiA+IAo+ID4gPiA+IEFkZGluZyBNaWNoYWVs
IEthbyB0byBjYyBsaXN0Lgo+ID4gPiA+IAo+ID4gPiA+IE9uIFdlZCwgSmFuIDksIDIwMTkgYXQg
MTo1NyBQTSBQaS1Ic3VuIFNoaWggPHBpaHN1bkBjaHJvbWl1bS5vcgo+ID4gPiA+IGc+IHdyb3Rl
Ogo+ID4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRoZSBtdGtfdGhlcm1hbCBzdHJ1Y3Qg
Y29udGFpbnMgYSAnc3RydWN0IG10a190aGVybWFsX2JhbmsKPiA+ID4gPiA+IGJhbmtzW107JywK
PiA+ID4gPiA+IGJ1dCB0aGUgYWxsb2NhdGlvbiBvbmx5IGFsbG9jYXRlcyBzaXplb2Yoc3RydWN0
IG10a190aGVybWFsKQo+ID4gPiA+ID4gYnl0ZXMsCj4gPiA+ID4gPiB3aGljaCBjYXVzZSBvdXQg
b2YgYm91bmQgYWNjZXNzIHdpdGggdGhlIC0+YmFua3NbXSBtZW1iZXIuCj4gPiA+ID4gPiBDaGFu
Z2UgaXQgdG8KPiA+ID4gPiA+IGEgZml4ZWQgc2l6ZSBhcnJheSBpbnN0ZWFkLgo+ID4gPiBFdmVu
IGlmIHRoZSBmaXggaXMgY29ycmVjdCwgaXQgcHVzaGVzIGJhY2sgdGhlIGJ1ZyBsYXRlciBpbiB0
aW1lCj4gPiA+IGlmIGEKPiA+ID4gbmV3IGJvYXJkIGNvbnRhaW5pbmcgbW9yZSB0aGFuIE1BWF9O
VU1fWk9ORVMgaXMgaW50cm9kdWNlZC4gSQo+ID4gPiBzdWdnZXN0IHRvCj4gPiA+IGR5bmFtaWNh
bGx5IGFsbG9jYXRlIHRoZSBhcnJheSB3aXRoIHRoZSAnbnVtX2JhbmtzJyB2YWx1ZS4KPiA+ID4g
Cj4gPiBGb3IgdGhlIGN1cnJlbnQgY29kZSBzdHJ1Y3R1cmUsIHRob3NlIG10a190aGVybWFsX2Rh
dGEgYXJlCj4gPiBzdGF0aWNhbGx5IGRlY2xhcmVkLAo+ID4gc28gaWYgdGhlcmUncyBuZXcgYm9h
cmQgY29udGFpbmluZyBtb3JlIHRoYW4gTUFYX05VTV9aT05FUyBvZgo+ID4gYmFua19kYXRhLCBp
dAo+ID4gd291bGQgYWN0dWFsbHkgYmUgYSBjb21waWxlIGVycm9yLgo+ID4gCj4gPiBJJ20gZmlu
ZSB3aXRoIGVpdGhlciB3YXksIGJ1dCBmZWVsIGxpa2UgdGhhdCB0aGlzIGlzIHNpbXBsZXIgdGhh
bgo+ID4gbWFudWFsbHkKPiA+IGNhbGN1bGF0aW5nIHRoZSBzaXplIG5lZWRlZCBmb3IgYWxsb2Nh
dGlvbi4KPiBSaWdodCwgSSBtaXNzZWQgaXQgY2FuIGJlIGNhdWdodCBhdCBjb21waWxlIHRpbWUu
Cj4gCj4gUmV2aWV3ZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8u
b3JnPgo+IApBcyB0aGlzIGlzIGEgYnVnZml4LCBJIHdpbGwgdGFrZSBpdCBhbmQgcXVldWUgaXQg
Zm9yIG5leHQgLXJjLgoKdGhhbmtzLApydWkKPiAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
