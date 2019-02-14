Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE0DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:32:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C040D21928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WeiapCKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C040D21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=27OLAdS+9PUWcuYxCzptoiVOXi8WkMYEo1PmiHmDj/c=; b=WeiapCKwk1NxSq
	OW++WbOapFcyX1INfSkFAjZD64iXL/K7meFgKSFTLNDroCqXvGa8jiQVk3AdCRvyMynbTHNBKcv88
	oGorp+ImHOE2vGllRS41/IVvFz93zQqVX8v5F+AVJl/qbxE+prJycR9ZQp9Li0MEFpzPhc8TF/qhS
	q2Xujr5qjnliVvaSdMDGD6vIZBNLomKjzLdxfXfhRMofi0Ntwk2JugleWNwUsLZZ8ca9yDTvItvsW
	2n42PUkdaQf9qrvOisay2+cq9fPxdX0iQFvceyg6Km/uD3+SQ+0Y4f6li81jb3pqxITVt46KnXvbL
	DQLKpsofxzwUc1dF/Svg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKsZ-00065Y-2K; Thu, 14 Feb 2019 17:32:55 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKsT-0005xl-1o
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:32:51 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1guKsL-00085S-10; Thu, 14 Feb 2019 18:32:41 +0100
Message-ID: <1550165560.2546.50.camel@pengutronix.de>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>
Date: Thu, 14 Feb 2019 18:32:40 +0100
In-Reply-To: <1550165185.2546.48.camel@pengutronix.de>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
 <1550159428.2546.40.camel@pengutronix.de>
 <20190214171806.kufhw7ouguxt5jhq@fsr-ub1664-175>
 <1550165185.2546.48.camel@pengutronix.de>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_093249_281379_1382077C 
X-CRM114-Status: GOOD (  20.13  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Anson Huang <anson.huang@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Mike Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Angus Ainslie <angus.ainslie@puri.sm>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDE0LjAyLjIwMTksIDE4OjI2ICswMTAwIHNjaHJpZWIgTHVjYXMg
U3RhY2g6Cj4gQW0gRG9ubmVyc3RhZywgZGVuIDE0LjAyLjIwMTksIDE3OjE4ICswMDAwIHNjaHJp
ZWIgQWJlbCBWZXNhOgo+ID4gT24gMTktMDItMTQgMTY6NTA6MjgsIEx1Y2FzIFN0YWNoIHdyb3Rl
Ogo+ID4gPiBIaSBBYmVsCj4gPiA+IAo+ID4gPiBBbSBNaXR0d29jaCwgZGVuIDEzLjAyLjIwMTks
IDE5OjA1ICswMDAwIHNjaHJpZWIgQWJlbCBWZXNhOgo+ID4gPiA+IEFkZCB0aGUgb3BwIHRhYmxl
IGNvbnRhaW5pbmcgb25seSBub24gb3ZlciBkcml2ZSBvcHBzLgo+ID4gPiA+IEFsc28gYWRkIHRo
ZSBjcHUtc3VwcGx5IG5vZGVzIGZvciB0aGUgQTUzIGNvcmVzIGluIHRoZSBFVksKPiA+ID4gPiBi
b2FyZC4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBYmVsIFZlc2EgPGFiZWwudmVz
YUBueHAuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1xLWV2ay5kdHMgfCAxNwo+ID4gPiA+ICsrKysrKysrKysrKysrKysrCj4gPiA+
ID4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzacKgwqDCoMKgfCAy
Mwo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDQwIGluc2VydGlvbnMoKykKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2ay5kdHMKPiA+ID4gPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gPiA+ID4gaW5kZXggNTQ3Mzdi
Zi4uMTE0MzU5ZSAxMDA2NDQKPiA+ID4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXEtZXZrLmR0cwo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gPiA+ID4gQEAgLTMxLDYgKzMxLDIzIEBACj4gPiA+ID4g
wqAJCWdwaW8gPSA8JmdwaW8yIDE5IEdQSU9fQUNUSVZFX0hJR0g+Owo+ID4gPiA+IMKgCQllbmFi
bGUtYWN0aXZlLWhpZ2g7Cj4gPiA+ID4gwqAJfTsKPiA+ID4gPiArCj4gPiA+ID4gK307Cj4gPiA+
ID4gKwo+ID4gPiA+ICsmQTUzXzAgewo+ID4gPiA+ICsJY3B1LXN1cHBseSA9IDwmc3cxYV9yZWc+
Owo+ID4gPiA+ICt9Owo+ID4gPiA+ICsKPiA+ID4gPiArJkE1M18xIHsKPiA+ID4gPiArCWNwdS1z
dXBwbHkgPSA8JnN3MWFfcmVnPjsKPiA+ID4gPiArfTsKPiA+ID4gPiArCj4gPiA+ID4gKyZBNTNf
MiB7Cj4gPiA+ID4gKwljcHUtc3VwcGx5ID0gPCZzdzFhX3JlZz47Cj4gPiA+ID4gK307Cj4gPiA+
ID4gKwo+ID4gPiA+ICsmQTUzXzMgewo+ID4gPiA+ICsJY3B1LXN1cHBseSA9IDwmc3cxYV9yZWc+
Owo+ID4gPiA+IMKgfTsKPiA+ID4gCj4gPiA+IFRoaXMgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0
Y2guCj4gPiA+IAo+ID4gCj4gPiBPSywgd2lsbCBzZW5kIGFzIHNlcGFyYXRlIHBhdGNoZXMgaW4g
dGhlIG5leHQgdmVyc2lvbi4KPiA+IAo+ID4gPiBBbmQgQUZBSUNTIHRoaXMgaXMgd3JvbmcsIHN3
MWEgb24gdGhlIE1YOE0tRVZLIGlzIHRoZSBHUFUgc3VwcGx5LAo+ID4gPiB0aGUKPiA+ID4gQ1BV
IGlzIHN1cHBsaWVkIGJ5IGEgZGVkaWNhdGVkIHN3aXRjaGVyIHRoYXQgaXMgY29udHJvbGxlZCB2
aWEgYQo+ID4gPiBHUElPLgo+ID4gPiAKPiA+IAo+ID4gSG1tLCBJIHRoaW5rIHlvdSdyZSByaWdo
dC4gQXQgbGVhc3QgdGhpcyBpcyB3aGF0IHRoZSBmb2xsb3dpbmcKPiA+IGRvY3VtZW50IHNheXMu
Cj4gPiAKPiA+IGh0dHBzOi8vd3d3Lm1vdXNlci5jb20vZHMvMi8zMDIvSU1YOE1EUUxRRVZLSFVH
LTEyODAzMzMucGRmCj4gPiAKPiA+IFNvIEkgZ3Vlc3MgdGhpcyBtZWFucyB0aGVyZSB3aWxsIG5v
dCBiZSBhbnkgY3B1LXN1cHBseSBwcm9wZXJ0aWVzLsKgCj4gCj4gVGhlcmUgaXMgYSB2YXJpYWJs
ZSB2b2x0YWdlIENQVSBzdXBwbHksIGJ1dCB5b3UgbmVlZCB0byBtb2RlbCBpdCBhcyBhCj4gZ3Bp
by1yZWd1bGF0b3IgaW4gdGhlIERULCBpdCdzIG5vdCBwYXJ0IG9mIHRoZSBQTUlDIHByb3ZpZGVk
IHJhaWxzLgoKSW4gdGhlIHNjaGVtYXRpY3MgaXQncyB0aGUgbGluZSBjYWxsZWQgUFdNX0xFRCAo
YWN0dWFsbHkgaXQncyBqdXN0CkdQSU8xX0lPMTMpIHRoYXQgY29udHJvbHMgdGhlIHZvbHRhZ2Uu
IFRoaXMgY2hhbmdlcyB0aGUgZmVlZGJhY2sgb2YgdGhlCkRDREMgc3dpdGNoZXIsIHNvIGl0IGNh
biB0b2dnbGUgYmV0d2VlbiAwLjlWIGFuZCAxLjBWLgoKUmVnYXJkcywKTHVjYXMKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
