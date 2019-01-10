Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF8CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:32:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC98214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YuB7sakT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC98214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=itaqgQLEjppHpdP1ym+AOtGL4YxAmiaEKXvrcBJ3Vmo=; b=YuB7sakT+5Zq1w
	XETvLj5s+zr47M06/wjnJ5+h7bpe0kxh+K6jwrt9vaZSLRuDUAQiAWxQlwfF2iW19WJ5OMVY9DXEL
	9Tf1LSAMwwboP/c329ALlBzmbhUpepl8YPFAso9FY+QoFoucUych2N2zKSZmLFnsS9jJS2icEONN7
	s3WUyA3M5heKLdT0Jdxg48Ca9fdvAWIQtWoYdNBCPvh1fYeGRV5Kk8RRhG3qJbBrBDo74xnsPt2zL
	w6fEEMbtjRv8FCDrspulV9Mr6v2j4kvp1hLNntqZwgXSZrekleP7UfF/ORQXc2ndo93F782qTFemw
	U8KY4wsdkbVT3MZE8LhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZV8-0007nP-EA; Thu, 10 Jan 2019 12:31:58 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZV0-0007mb-V1; Thu, 10 Jan 2019 12:31:52 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ghZUs-00035U-Mx; Thu, 10 Jan 2019 13:31:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new rockchip,
 force-bvalid property.
Date: Thu, 10 Jan 2019 13:31:41 +0100
Message-ID: <4750582.8aBUlXA8d6@phil>
In-Reply-To: <CAFqH_538JF7gmpQzgyShw-8nhUEtkVrGQ6vjkdc5neJd8JCAOQ@mail.gmail.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815222604.GB8193@rob-hp-laptop>
 <CAFqH_538JF7gmpQzgyShw-8nhUEtkVrGQ6vjkdc5neJd8JCAOQ@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_043151_147002_881518CD 
X-CRM114-Status: GOOD (  22.76  )
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
 Alexandru Stan <amstan@chromium.org>, Guenter Roeck <groeck@google.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Wang <frank.wang@rock-chips.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, kieran.bingham@ideasonboard.com,
 Kishon Vijay Abraham I <kishon@ti.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, kernel@collabora.com,
 Benson Leung <bleung@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRW5yaWMsCkFtIERvbm5lcnN0YWcsIDEwLiBKYW51YXIgMjAxOSwgMTA6MDY6MzggQ0VUIHNj
aHJpZWIgRW5yaWMgQmFsbGV0Ym8gU2VycmE6Cj4gTWlzc2F0Z2UgZGUgUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4gZGVsIGRpYSBkai4sIDE2IGTigJlhZy4gMjAxOCBhIGxlcyAwOjI2Ogo+
ID4KPiA+IE9uIFdlZCwgQXVnIDE1LCAyMDE4IGF0IDExOjU5OjM0QU0gKzAyMDAsIEVucmljIEJh
bGxldGJvIGkgU2VycmEgd3JvdGU6Cj4gPiA+IFRoaXMgcHJvcGVydHkgaXMgdXNlZCB3aGVuIHRo
ZSBvdGctaWQgcGluIGlzIG5vdCBjb25uZWN0ZWQuIFdoZW4gdGhpcwo+ID4gPiBwcm9wZXJ0eSBp
cyBzZXQgaXQgZm9yY2VzIHRvIHNldCB0aGUgQi1EZXZpY2UgU2Vzc2lvbiBWYWxpZCBiaXQgd2hl
biB0aGUKPiA+ID4gcG9ydCB3b3JrcyBhcyBkZXZpY2UgYW5kIGNsZWFycyB0aGF0IGJpdCB3aGVu
IHRoZSBwb3J0IHdvcmtzIGFzIGhvc3QuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEVucmlj
IEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+Cj4gPiA+IC0t
LQo+ID4gPgo+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1yb2NrY2hpcC1p
bm5vLXVzYjIudHh0ICAgICAgIHwgNSArKysrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BoeS9waHktcm9ja2NoaXAtaW5uby11c2IyLnR4dCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LXJvY2tjaGlwLWlubm8tdXNiMi50eHQKPiA+
ID4gaW5kZXggMmQ0ODA4ZDM5MjBiLi41NTc2MWY0NjZjNDEgMTAwNjQ0Cj4gPiA+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LXJvY2tjaGlwLWlubm8tdXNi
Mi50eHQKPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9w
aHktcm9ja2NoaXAtaW5uby11c2IyLnR4dAo+ID4gPiBAQCAtNDgsNiArNDgsMTEgQEAgT3B0aW9u
YWwgcHJvcGVydGllczoKPiA+ID4gICAgICAgICAgICAgICBTZWUgLi9waHktYmluZGluZ3MudHh0
IGZvciBkZXRhaWxzLgo+ID4gPiAgIC0gcm9ja2NoaXAsdXRtaS1hdmFsaWQgOiBib29sZWFuLCB1
c2UgdGhlIGF2YWxpZCByZWdpc3RlciB0byBnZXQgdmJ1cyBzdGF0dXMuCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIE90aGVyd2lzZSwgdXNlIHRoZSBidmFsaWQgcmVnaXN0ZXIuCj4gPiA+
ICsgLSByb2NrY2hpcCxmb3JjZS1idmFsaWQgOiBib29sZWFuLCBzZXQgdGhpcyB0byBmb3JjZSB0
aGUgQi1EZXZpY2UgU2Vzc2lvbgo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBWYWxpZCBi
aXQgd2hlbiB0aGUgdXNiIHBvcnQgaXMgaW4gZGV2aWNlIG1vZGUuIFRoaXMKPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgaXMgdXNlZCB3aGVuIHRoZSBvdGctaWQgcGluIGlzIG5vdCBjb25u
ZWN0ZWQuCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIE9ubHkgc3VwcG9ydGVkIGluIGNh
c2Ugb2YgY29tcGF0aWJsZSBiZWluZzoKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgKiAi
cm9ja2NoaXAscmszMzk5LXVzYjJwaHkiCj4gPgo+ID4gU2hvdWxkbid0IHlvdSBkZXNjcmliZSB0
aGUgcHJvcGVydHkgb2YgdGhlIGgvdyB0aGF0IElEIHBpbiBpcyBub3QKPiA+IGNvbm5lY3RlZCwg
cmF0aGVyIHRoYW4gd2hhdCB5b3UgZG8gd2l0aCB0aGF0IGluZm9ybWF0aW9uLgo+ID4KPiAKPiBX
aGF0IGFib3V0ICJyb2NrY2hpcCwgb3RnLWlkLW5vdC1jb25uZWN0ZWQiPwoKanVzdCBwb2ludGlu
ZyBiYWNrIHRvIG91ciBkaXNjdXNzaW9uIGluIHBhdGNoMyBhYm91dCBzaW1wbHkgYXNzdW1pbmcK
aWQtbm90LWNvbm5lY3RlZCBpbiB0aGUgY2FzZSBvZiB0aGUgZXh0Y29uIG1pc3NpbmcKCkkgc3Rp
bGwgdGhpbmsgdGhhdCBtaWdodCBiZSB0aGUgY2xlYW5lciB2YXJpYW50PyBCdXQgSSBndWVzcyB5
b3UncmUKcHJvYmFibHkgYWxyZWFkeSBsb29raW5nIGludG8gZG9pbmcgdGhhdCBhcyBzbyBmYXIg
eW91IG9ubHkgcmVzZW5kIHRoZQpjbGVhbnVwIHBhdGNoZXMgOi0pIC4KCgpIZWlrbwoKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
