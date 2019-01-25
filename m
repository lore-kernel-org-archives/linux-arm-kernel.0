Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62462C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:40:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334A3218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MPad8HWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334A3218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rjh6gqwgXuZBQaKgLvZyNsXCcfkMuMnkljErKn0yf4I=; b=MPad8HWYhdnyGB
	W/Idikd4N9SkgwZ99c608bEszzwEHWYIQ4edXPnysNS3xz8aHRaoyV/rvi7MQatOH4Z2ITyyIXuJD
	SxFUhdzksB8n37RgcNVb2jwJz/WgFRbBF/n8ByOKlTkyKDWFYR9yzjIrXZvF27emKTHShOAf9qEbl
	Kv7SrT71oesricplIJPjUgZSetdG4blJuQFc3vKIPpRn4XYGBmQef1HFtzosnqSSgzgH/LAgwxbXM
	HgkVVxrwIT7UnflDp5Lyo5wrXcvHuUpVSDa9MRh9uB8ZL87dcNmvGsroaOxJqb76CdKQoGFm1BFlk
	17XBTEfPrMvSdl+4P5iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxy4-0006fF-VI; Fri, 25 Jan 2019 09:40:08 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxy0-0005wi-Lm
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:40:06 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmxxv-0002Ax-3H; Fri, 25 Jan 2019 10:39:59 +0100
Message-ID: <1548409197.28802.38.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/5] dt-bindings: dma: fsl-imx-sdma: add fsl,imx8mq
 to the accepted compatible node
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Fri, 25 Jan 2019 10:39:57 +0100
In-Reply-To: <20190125025528.15645-4-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
 <20190125025528.15645-4-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_014004_875796_BAFD9191 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDI0LjAxLjIwMTksIDE5OjU1IC0wNzAwIHNjaHJpZWIgQW5ndXMg
QWluc2xpZSAoUHVyaXNtKToKPiBUaGUgaW14OG1xIGlzIGEgc2xpZ2h0bHkgZGlmZmVyZW50IHZh
cmlhbnQgb24gdGhlIGlteDdkCgpOb3QgcmVhbGx5IEFGQUlDUywgYnV0IGl0J3MgZ29vZCB0byBk
b2N1bWVudCB0aGUgdXNlZCBjb21wYXRpYmxlcwphbnl3YXlzLCBzbzoKClJldmlld2VkLWJ5OiBM
dWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4gU2lnbmVkLW9mZi1ieTogQW5n
dXMgQWluc2xpZSAoUHVyaXNtKSA8YW5ndXNAYWtrZWEuY2E+Cj4gLS0tCj4gwqBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQgfCAxICsKPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQKPiBpbmRleCAzYzlh
NTdhODQ0M2IuLjlkOGJiYWMyN2Q4YiAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQKPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQKPiBAQCAtOSw2ICs5LDcg
QEAgUmVxdWlyZWQgcHJvcGVydGllczoKPiDCoMKgwqDCoMKgwqDCoCJmc2wsaW14NTMtc2RtYSIK
PiDCoMKgwqDCoMKgwqDCoCJmc2wsaW14NnEtc2RtYSIKPiDCoMKgwqDCoMKgwqDCoCJmc2wsaW14
N2Qtc2RtYSIKPiArwqDCoMKgwqDCoMKgImZzbCxpbXg4bXEtc2RtYSIKPiDCoMKgwqBUaGUgLXRv
IHZhcmlhbnRzIHNob3VsZCBiZSBwcmVmZXJyZWQgc2luY2UgdGhleSBhbGxvdyB0byBkZXRlcm1p
bmUgdGhlCj4gwqDCoMKgY29ycmVjdCBST00gc2NyaXB0IGFkZHJlc3NlcyBuZWVkZWQgZm9yIHRo
ZSBkcml2ZXIgdG8gd29yayB3aXRob3V0IGFkZGl0aW9uYWwKPiDCoMKgwqBmaXJtd2FyZS4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
