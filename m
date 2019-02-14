Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0EEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B29D222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CYLsF5fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B29D222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GIrxqwak/RD1gKo1FFnS3wNNwY6heqgmYKSon/cQyTw=; b=CYLsF5fzCgViw8
	CFBTDg12LGSw+EXy2sKuzNr91rja4GCQ8vOcmyLpwVsnacL3eHJASqF1qKJ7adKxMY67M9sqMsuc3
	STb0zVUxv0a+NlSk24acWvpKIjEZLPsnk2blyfavbw/hKhl37L8YxNWWQFVwMqCECH8WzWB5M0pfU
	o/R5dqHCy3m/amR5IftfyB4IueVM/DRCBbllQJXAuVmqV2QHA3PO9H4/OAR9Z2zFmI0QUr0VtFLcu
	E016AtSMBm69GtugFw9XSe7XrIRbC6854UxgiTG8jrbnCB4Zxei3AdfJaNamiEbCv79L3smMbxHHc
	3P2ADYjWZmt1hR1K9u+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJIs-0004f1-Ik; Thu, 14 Feb 2019 15:51:58 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJIo-0004bL-K7
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:51:56 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1guJIg-0004RD-Sd; Thu, 14 Feb 2019 16:51:46 +0100
Message-ID: <1550159506.2546.42.camel@pengutronix.de>
Subject: Re: [RFC 2/5] dt-bindings: imx8mq-clock: Add the missing ARM clock
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mike
 Turquette <mturquette@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Angus Ainslie
 <angus.ainslie@puri.sm>, Anson Huang <anson.huang@nxp.com>
Date: Thu, 14 Feb 2019 16:51:46 +0100
In-Reply-To: <1550084693-9797-3-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075154_835750_F81D5120 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAxMy4wMi4yMDE5LCAxOTowNSArMDAwMCBzY2hyaWViIEFiZWwgVmVz
YToKPiBBZGQgdGhlIG1pc3NpbmcgQVJNIGNsb2NrIHdoaWNoIHdpbGwgYmUgdXNlZCBieSBjcHVm
cmVxCj4gCj4gU2lnbmVkLW9mZi1ieTogQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4KClJl
dmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4gLS0tCj4g
wqBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDhtcS1jbG9jay5oIHwgNCArKystCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1xLWNsb2NrLmggYi9pbmNsdWRl
L2R0LQo+IGJpbmRpbmdzL2Nsb2NrL2lteDhtcS1jbG9jay5oCj4gaW5kZXggMDRmN2FjMy4uNDdj
NzkwYyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDhtcS1jbG9j
ay5oCj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg4bXEtY2xvY2suaAo+IEBA
IC0zOTEsNSArMzkxLDcgQEAKPiDCoAo+IMKgI2RlZmluZSBJTVg4TVFfQ0xLX05BTkRfVVNESENf
QlVTX1JBV05BTkRfQ0xLCTI2Nwo+IMKgCj4gLSNkZWZpbmUgSU1YOE1RX0NMS19FTkQJCQkJMjY4
Cj4gKyNkZWZpbmUgSU1YOE1RX0NMS19BUk0JCQkJMjY4Cj4gKwo+ICsjZGVmaW5lIElNWDhNUV9D
TEtfRU5ECQkJCTI2OQo+IMKgI2VuZGlmIC8qIF9fRFRfQklORElOR1NfQ0xPQ0tfSU1YOE1RX0gg
Ki8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
