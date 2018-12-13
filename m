Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C258C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:07:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B01620873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cfFRGsPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B01620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aBISH20rtJ6Dpnsxhbkhi/GTHjUhxYxOIQq2+pe1gu4=; b=cfFRGsPWYNlVn1
	uVA1yqx9USYL+s+B5YHX48kyra2kVxTK6m69WXm72NnJsNf8CLNX6PnO71jPDld7G0mHgu14L4A09
	DJSkfU4C9KDzHMQp1NUlJiHNN3jhmy6JA7kBnC0ltjwN2OusC3oytJpsSEqtzyDMmHYr1PLsjBDAX
	XV0z5p7gh1OKq5RZDhLqK0kXCCCQvcRom3hi+luq7Ww3uIzdWODq5W9GxNoKUEr86FBw80SX/pRCr
	zytoilog1tH5sZC4xpaMdg2dC0RnPbjUUfKuBFMp+Et57F81SpQKYQo3IbAamwAv9ZsbbdC+c/Jej
	+MOvS3vkGAf8Vb1U4N3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXNu3-0007uo-Dy; Thu, 13 Dec 2018 10:07:35 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXNtz-0007sb-PK
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:07:33 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gXNtl-00047C-Pu; Thu, 13 Dec 2018 11:07:17 +0100
Message-ID: <1544695636.3137.27.camel@pengutronix.de>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <hongxing.zhu@nxp.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>,  "andrew.smirnov@gmail.com"
 <andrew.smirnov@gmail.com>
Date: Thu, 13 Dec 2018 11:07:16 +0100
In-Reply-To: <AM0PR0402MB35705EF0F4A77BD7B0AAFDDD8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
 <1544692768.3137.25.camel@pengutronix.de>
 <AM0PR0402MB35705EF0F4A77BD7B0AAFDDD8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_020731_978113_0A17B93C 
X-CRM114-Status: GOOD (  17.37  )
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDEzLjEyLjIwMTgsIDA5OjU3ICswMDAwIHNjaHJpZWIgUmljaGFy
ZCBaaHU6Cj4gSGkgTHVjYXM6Cj4gCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4g
PiA+IEZyb206IEx1Y2FzIFN0YWNoIFttYWlsdG86bC5zdGFjaEBwZW5ndXRyb25peC5kZV0KPiA+
IFNlbnQ6IDIwMTjlubQxMuaciDEz5pelIDE3OjE5Cj4gPiA+ID4gPiA+IFRvOiBSaWNoYXJkIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOwo+ID4gbG9yZW56
by5waWVyYWxpc2lAYXJtLmNvbTsgYW5kcmV3LnNtaXJub3ZAZ21haWwuY29tCj4gPiA+ID4gPiA+
IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7Cj4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gPiBTdWJqZWN0
OiBSZTogW3YyXSBQQ0k6IGlteDogbWFrZSBtc2kgd29yayB3aXRob3V0IHBjaWVwb3J0YnVzCj4g
PiAKPiA+IEhpIFJpY2hhcmQsCj4gPiAKPiA+IEFtIERvbm5lcnN0YWcsIGRlbiAxMy4xMi4yMDE4
LCAwODowMiArMDAwMCBzY2hyaWViIFJpY2hhcmQgWmh1Ogo+ID4gPiBNU0lfRU4gb2YgaU1YIFBD
SWUgUkMgd291bGQgYmUgYXNzZXJ0ZWQgd2hlbiBQQ0lFUE9SVEJVUyBkcml2ZXIgaXMKPiA+ID4g
c2VsZWN0ZWQuCj4gPiA+IFRodXMsIHRoZSBNU0kgd29ya3MgZmluZSBvbiBpTVggUENJZSBiZWZv
cmUuCj4gPiA+IEFzc2VydCBpdCB1bmNvbmRpdGlvbmFsbHkgd2hlbiBNU0kgaXMgc3VwcG9ydGVk
Lgo+ID4gPiBPdGhlcndpc2UsIHRoZSBNU0kgd291bGRuJ3QgYmUgdHJpZ2dlcmVkIGFsdGhvdWdo
IHRoZSBFUCBpcyBwcmVzZW50Cj4gPiA+IGFuZCB0aGUgTVNJcyBhcmUgYXNzaWduZWQuCj4gPiAK
PiA+IFRoYW5rcyBmb3IgZGlnZ2luZyBpbnRvIHRoaXMgaXNzdWUuIFRoaXMgc2VlbXMgbGlrZSB0
aGUgcmlnaHQgd2F5IGZvcndhcmQuCj4gPiBIb3dldmVyLCBkaWQgeW91IHRlc3QgdGhpcyB3aXRo
IGRldmljZXMgdXNpbmcgbGVnYWN5IElSUXM/Cj4gPiBJLmUuIGJvb3Rpbmcgd2l0aCAibm9tc2ki
IG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIHRvIHNlZSBpZiBsZWdhY3kgSVJRcyBzdGlsbAo+
ID4gd29yayBpZiB0aGlzIGJpdCBpcyBzZXQsIG9yIGlmIHdlIG5lZWQgdG8gYXZvaWQgc2V0dGlu
ZyB0aGlzIHdoZW4gdGhlIHVzZXIKPiA+IGV4cGxpY2l0bHkgcmVxdWVzdHMgdG8gZGlzYWJsZSBN
U0lzPwo+ID4gCj4gPiBSZWdhcmRzLAo+ID4gTHVjYXMKPiA+IAo+IAo+IFtSaWNoYXJkIFpodV0g
VGhhbmtzIGZvciB5b3VyIHJldmlldy4KPiBUaGUgTGVnYWN5IElOVHggaXMgYnJva2VuLgo+IFRo
ZSBNU0lfRU4gYml0IHNob3VsZG4ndCBiZSBhc3NlcnRlZCB3aGVuIHRoZSB1c2VyIGV4cGxpY2l0
bHkgcmVxdWVzdHMgdG8gZGlzYWJsZSBNU0lzLgoKT2theSwgc28gdGhpcyBwYXRjaCBzaG91bGQg
YmUgZXh0ZW5kZWQgd2l0aCBhIGNoZWNrIGZvcgpwY2lfbXNpX2VuYWJsZWQoKSB0byBzZWUgaWYg
dGhlIHVzZXIgZXhwbGljaXRseSB3YW50IGxlZ2FjeSBJUlFzLgoKPiBCVFcsIHJlZ2FyZGluZyB0
byBCYXJ1Y2gncyBjb21tZW50cywgaXQgc2VlbXMgdGhhdCBhbGwgdGhlIChJU19FTkFCTEVEKENP
TkZJR19QQ0lfTVNJKSBjaGVjayBpbgo+IMKgdGhlIGR3YyBob3N0IGRyaXZlcnMgYXJlIG5vdCBy
ZXF1aXJlZCBhbnltb3JlLCBzaW5jZSB0aGUgZGVwZW5kcyBvbiBQQ0lfTVNJX0lSUV9ET01BSU4s
IHJpZ2h0PwoKVGhhdCdzIGNvcnJlY3QuIFRoaXMgaXMgbW9zdGx5IGEgaGlzdG9yaWNhbCBhcnRp
ZmFjdCBmcm9tIHRoZSB0aW1lIHdoZW4KIHdlIHdlcmUgYWJsZSB0byBidWlsZCB3aXRob3V0IE1T
SSBzdXBwb3J0LiBUaG9zZSBjaGVja3MgY291bGQgYmUKY2xlYW5lZCB1cCBub3cgdGhhdCB3ZSBk
ZXBlbmQgb24gdGhlIE1TSSBvcHRpb25zLgoKUmVnYXJkcywKTHVjYXMKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
