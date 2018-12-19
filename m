Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF548C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:09:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D02C217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V6xaCLKK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+HpzBzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D02C217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PSjvdbn9eNBCNngFuolj++6u1rmF+Az7lQqppKqOkOA=; b=V6xaCLKKqsUw0i
	pcSwGtGID+Jo2W3O3T7WdnRgGHzmpBL9lwOhjf8p5fsuXEXfN1/kD5UQH5zuZREO8ALwcK9Cy2e09
	DRK/bjjqJewvdypHzMOQVMsbeYJGm9OCOzokrKAuDffdH9IeOTV9Ajvz3XsVOjAfYFtpm+iQCjUlN
	zyyZWH3tBASbglDX7es2NpZJctJR4aVptXUyK5WrqL8nuNE+g/kC4Hn5fQEVV2xgk12OIap7419g8
	ViuXx8veqOOf1a28PlxcAEskDuyg+8i+T6wvR2l2pTSQti2TeCFvT81uneSBll+djgyKGk7m6a0Td
	NeDz9+NXI9f64qji7J1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZTB7-0007zk-J5; Wed, 19 Dec 2018 04:09:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZTB2-0007yo-TR
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 04:09:47 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 90721217D6;
 Wed, 19 Dec 2018 04:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545192573;
 bh=9z1vdxsKHK1NMWKam1ZY98y9lqdHp7yfFFZgwu4/YfU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T+HpzBzIZD7dUtvJxdIFUC9B8zCGWlMasPebNqFun5kPEF1N9u6Pw8Tpz/M0opzJb
 g8+w6QpT9oRmM1O4J9xwd6KipPj3QqV5uMz2rLXF3UgvXRbfo2Ofs6l/GPjdcaiHAi
 6XfFpBWlEjVvxLIlPbIiaR7hK1pAb+sD4ngnzyFk=
Date: Wed, 19 Dec 2018 12:08:22 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andy Tang <andy.tang@nxp.com>
Subject: Re: [PATCH] arm64: dts: nxp: ls208xa: add more thermal zone support
Message-ID: <20181219040820.GA13728@dragon>
References: <20181031044742.26327-1-andy.tang@nxp.com>
 <VI1PR04MB433351E63826CC2128153943F3BD0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR04MB433351E63826CC2128153943F3BD0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_200945_305911_6384DC87 
X-CRM114-Status: GOOD (  11.78  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBEZWMgMTgsIDIwMTggYXQgMDc6MDE6MzJBTSArMDAwMCwgQW5keSBUYW5nIHdyb3Rl
Ogo+IEhpLAo+IAo+IFBJTkcuCj4gCj4gQlIsCj4gQW5keQo+IAo+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0KPiA+IEZyb206IFl1YW50aWFuIFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPgo+
ID4gU2VudDogMjAxOOW5tDEw5pyIMzHml6UgMTI6NDgKPiA+IFRvOiBzaGF3bmd1b0BrZXJuZWwu
b3JnCj4gPiBDYzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5v
cmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOwo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsKPiA+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IHJ1aS56aGFuZ0BpbnRlbC5jb207IGRhbmllbC5sZXpjYW5vQGxpbmFy
by5vcmc7Cj4gPiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPgo+ID4gU3ViamVjdDogW1BB
VENIXSBhcm02NDogZHRzOiBueHA6IGxzMjA4eGE6IGFkZCBtb3JlIHRoZXJtYWwgem9uZSBzdXBw
b3J0Cj4gPiAKPiA+IExzMjA4eGEgaGFzIHNldmVyYWwgdGhlcm1hbCBzZW5zb3JzLiBBZGQgYWxs
IHRoZSBzZW5zb3IgaWQgdG8gZHRzIHRvIGVuYWJsZQo+ID4gdGhlbS4KPiA+IAo+ID4gVG8gbWFr
ZSB0aGUgZHRzIGNsZWFuZXIsIHJlLW9yZ2FuaXplIHRoZSBub2RlcyB0byBzcGxpdCBvdXQgdGhl
IGNvbW1vbiBwYXJ0IHNvCj4gPiB0aGF0IGl0IGNhbiBiZSBzaGFyZWQgd2l0aCBvdGhlciBTb0Nz
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWFudGlhbiBUYW5nIDxhbmR5LnRhbmdAbnhwLmNv
bT4KClBsZWFzZSB0YWtlIGEgbG9vayBhdCBwYXRjaCBiZWxvdy4KCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTA2ODU4MTUvCgpTaGF3bgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
