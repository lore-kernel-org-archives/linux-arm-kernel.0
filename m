Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA16C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30825217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mlgs2uiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30825217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kO8HRtZReVZ0nqsj1XykLcIlNg/MKR56G+Ge01ZF0e8=; b=mlgs2uiPl4wXC8
	TlpzWn3OPbD1tFww5FR00gBG+HQ899AL/aZw+aiPIAIOkw4ILBwdV5AEUJIJ+7kohSNDCHpsZ/w8F
	4M8BmdayT/LNa0a0xysEEe2gBQuTF2TPQLwIRPppYpHvGa5UtjfeBkUcdwWzSqjze55MvIYmLYnMt
	9+6ECYLxyjR8TPS4RkQSKnHf1Z8jF4evFBvEvPsazynxWdrorSV5OIIqZKKY2+dmirgYQ/8qKU/X2
	QN2ZaEhluB8kVqocLQ2BHV1btc+CD1HUhiOJW2DNCWbVpLszsAbIh2lvYSdA8pCwjP2DSwSODjC05
	4J2N0IF+as2QNo9tCIUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpAa-0006hA-FH; Mon, 17 Dec 2018 09:26:36 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpAT-0006Sb-FH
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:26:31 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gYpAH-000311-5X; Mon, 17 Dec 2018 10:26:17 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gYpAG-0007Su-LU; Mon, 17 Dec 2018 10:26:16 +0100
Date: Mon, 17 Dec 2018 10:26:16 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in
 i2c_imx_clk_notifier_call().
Message-ID: <20181217092616.sd4yv4ezu72xzlxb@pengutronix.de>
References: <m3o9a2hni5.fsf@t19.piap.pl>
 <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
 <m3va3sh5zl.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m3va3sh5zl.fsf@t19.piap.pl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_012629_759660_1EEDB572 
X-CRM114-Status: GOOD (  11.02  )
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
Cc: Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMTcsIDIwMTggYXQgMTA6MTI6MTRBTSArMDEwMCwgS3J6eXN6dG9mIEhhxYJh
c2Egd3JvdGU6Cj4gOTBhZDJjYmU4OGMyMmQwMjE1MjI1YWI5NTk0ZWVlYWQwZWIyNGZkZSBjaGFu
Z2VkIHRoZSBpLk1YIEkyQyBidXMgZHJpdmVyCj4gdG8gdXNlIGEgbm90aWZpZXIgd2hlbmV2ZXIg
dGhlIGJhc2UgY2xvY2sgKCJpcGciIC0gNjYgTUh6IHBlcmlwaGVyYWwKPiBjbG9jaykgcmF0ZSBj
aGFuZ2VzLgo+IAo+IFVuZm9ydHVuYXRlbHkgb25lIGNhbid0IHVzZSB0aGUgY29udGFpbmVyX29m
KCkgbWFjcm8gdGhpcyB3YXkgLSB0aGUKPiBmaXJzdCBhcmd1bWVudCBoYXMgdG8gcG9pbnQgdG8g
YSBtZW1iZXIgb2YgdGhlIGJpZ2dlciBzdHJ1Y3QgKGxhc3QKPiBhcmd1bWVudCkuIE1lcmVseSBw
b2ludGluZyB0byB0aGUgc2FtZSB2YWx1ZSBpc24ndCBlbm91Z2ggKHRoZSBjbGsKPiB2YXJpYWJs
ZSB3aGljaCBoYXMgaXRzIGFkZHJlc3MgcGFzc2VkIHRvIHRoZSBtYWNybyBpcyB0aGUgY2xrIGlu
Cj4gbm90aWZpZXJfYmxvY2ssIG5vdCB0aGUgb25lIGluIGlteF9pMmNfc3RydWN0LCBldmVuIHRo
b3VnaCBib3RoIHBvaW50ZXJzCj4gcG9pbnQgdG8gdGhlIHNhbWUgY2xrIHN0cnVjdCkuCj4gCj4g
VGhpcyBidWcgY2F1c2VzIGtlcm5lbCBwYW5pYyB3aGVuIHRoZSBJUEcgY2xvY2sgcmF0ZSBjaGFu
Z2VzIChlLmcuIGlmCj4gYW55IGNsb2NrIGRlcml2ZWQgZnJvbSBJUEcgY2hhbmdlcykuCj4gCj4g
U2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEhhbGFzYSA8a2hhbGFzYUBwaWFwLnBsPgoKSSBkaWRu
J3QgbG9vayBhdCB0aGUgcGF0Y2gsIGJ1dCBJIHN1Z2dlc3QgYSBGaXhlczogbGluZSBoZXJlIMOg
IGxhOgoKRml4ZXM6IDkwYWQyY2JlODhjMiAoImkyYzogaW14OiB1c2UgY2xrIG5vdGlmaWVyIGZv
ciByYXRlIGNoYW5nZXMiKQoKQmVzdCByZWdhcmRzClV3ZQogCi0tIApQZW5ndXRyb25peCBlLksu
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAg
IHwKSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwgaHR0cDovL3d3
dy5wZW5ndXRyb25peC5kZS8gIHwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
