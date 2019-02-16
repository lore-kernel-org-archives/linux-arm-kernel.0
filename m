Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350EEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:55:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034642192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i2KWpPud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034642192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9fhGd3vtGM5gTwXTcibSP6GcdJ4bujcu5L6UNmJluzQ=; b=i2KWpPudNfB/cP
	c9jpyx5iGEjcuG2J0TyON3LCmb5GvVjq+qUZuazCJmwteamjvJba0sQAkk5uLKB+sr006nlQ9HH9F
	5+toxSgDMIy/5H00lDCJN3ERrxgStbSHdITec3zaEE7an7xy/+uHc4U/DQpXkcxbybFz3FI3SpAiT
	NMGEXBAWeKxnzBBljYkVJYNzI90GEVvkDVTyCbHDE8t+7O5YNO79v3/8lCSwDz13Z/eOYq4BaZ9q1
	uodSTDakutWs3RbzJnZp+OrYk+bJj3mpygBTD+S2MBfT6B1Y4X9CdO6qjajgnzQnuGIvWPHRUhlxG
	43XnB7QWdnZ5xpCHJ09A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guq8L-0006mO-8C; Sat, 16 Feb 2019 02:55:17 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guq8H-0006m1-Nw; Sat, 16 Feb 2019 02:55:15 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 8F6BB26C2F0
Message-ID: <aa2f376897ffb4fef02bd3e64812c8e1dbe4987a.camel@collabora.com>
Subject: Re: [PATCH] arm64: dts: rock960: Enable tsadc device
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Fri, 15 Feb 2019 23:55:01 -0300
In-Reply-To: <4625663.tZDl4lH1EQ@diego>
References: <20190215152539.16606-1-ezequiel@collabora.com>
 <4625663.tZDl4lH1EQ@diego>
Organization: Collabora
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_185513_912797_05A253E3 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU2F0LCAyMDE5LTAyLTE2IGF0IDAwOjE0ICswMTAwLCBIZWlrbyBTdMO8Ym5lciB3cm90ZToK
PiBIaSBFemVxdWllbCwKPiAKPiBBbSBGcmVpdGFnLCAxNS4gRmVicnVhciAyMDE5LCAxNjoyNToz
OSBDRVQgc2NocmllYiBFemVxdWllbCBHYXJjaWE6Cj4gPiBFbmFibGUgdGhlIHRoZXJtYWwgc2Vu
c29yLiBUaGlzIGRldmljZSBhbHNvIHByb3ZpZGVzCj4gPiB0ZW1wZXJhdHVyZSBzaHV0ZG93biBw
cm90ZWN0aW9uLiBUaGUgc2h1dGRvd24gdmFsdWUgaXMKPiA+IHNldCBhdCAxMTBDLCBhcyB0ZXN0
ZWQgYnkgdGhlIHZlbmRvci4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogRXplcXVpZWwgR2FyY2lh
IDxlemVxdWllbEBjb2xsYWJvcmEuY29tPgo+ID4gLS0tCj4gPiAgYXJjaC9hcm02NC9ib290L2R0
cy9yb2NrY2hpcC9yazMzOTktcm9jazk2MC5kdHNpIHwgNyArKysrKysrCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9yb2NrY2hpcC9yazMzOTktcm9jazk2MC5kdHNpCj4gPiBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcm9ja2NoaXAvcmszMzk5LXJvY2s5NjAuZHRzaSBpbmRleAo+ID4gZDY0ZDVhYzA4MDRh
Li41OTljOTc1MmVkNGQgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tj
aGlwL3JrMzM5OS1yb2NrOTYwLmR0c2kKPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9j
a2NoaXAvcmszMzk5LXJvY2s5NjAuZHRzaQo+ID4gQEAgLTYzNCwzICs2MzQsMTAgQEAKPiA+ICAg
ICAgICAgIG1hbGktc3VwcGx5ID0gPCZ2ZGRfZ3B1PjsKPiA+ICAgICAgICAgIHN0YXR1cyA9ICJv
a2F5IjsKPiA+ICB9Owo+IAo+IGRvZXNuJ3QgYXBwbHkgYWdhaW5zdCBteSA1LjEvZHRzNjQgYnJh
bmNoIGFuZCBvdXIgcm9jazk2MC5kdHNpCj4gYWxzbyBkb2VzIG5vdCBoYXZlIGEgbWFsaSBub2Rl
IHlldCAoZXNwZWNpYWxseSBhbHNvIG5vdCBvbmUgd2l0aAo+IHNwYWNlLWluZGVudGF0aW9uIDst
KSApLgo+IAo+IAoKU29ycnkgYWJvdXQgdGhhdCwgaXQgd2FzIGJhc2VkIG9uIHlvdXIgZm9yLW5l
eHQgYnJhbmNoLApidXQgYSBtYWxpIHBhdGNoIHNsaXBwZWQgdGhyb3VnaC4KCj4gSGVpa28KPiAK
PiA+ICsKPiA+ICsmdHNhZGMgewo+ID4gKwlyb2NrY2hpcCxody10c2h1dC1tb2RlID0gPDE+Owo+
ID4gKwlyb2NrY2hpcCxody10c2h1dC1wb2xhcml0eSA9IDwxPjsKPiA+ICsJcm9ja2NoaXAsaHct
dHNodXQtdGVtcCA9IDwxMTAwMDA+Owo+ID4gKwlzdGF0dXMgPSAib2theSI7Cj4gPiArfTsKPiAK
PiAKPiAKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
