Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F428C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:42:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E352921872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tdOSylL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E352921872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+qCMmdBmVfe7N3qXeQ/xZmgQeB5WHQlbatIAuzsb1I0=; b=tdOSylL4fqqCsZ
	gvZ0NHQaNPj87mlXImf2owEDMhtogxMdUiBfD3KE7sJQ1XtqYBdC6mcPL6SQ23/MeANZjn8AHn0CB
	s00YPvRSTVQwIPm/v9glQ9TSR7ybkwn+tSJllMCJHNEyci000P/+cYTCDE2MBYG36RC0BUqgf6Bbp
	Xjjkgr1ViBOJ3l0DfiAmtuQKumIgSqLelv40Dy5j5gZKy6mZbBsocAii5n3snMPtpVJXKtDcInU4j
	PdMKsntJXdO5gi0zLVX2by1ZLJwhaqVsE4XxeEYHnEJngPiD0NZzVpgS6pKsViK3A7Yx2SUAl+xbz
	rJVzgaesfn6KPNCU0y4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grh86-0000pb-61; Thu, 07 Feb 2019 10:42:02 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grh7m-0000St-N7
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 10:41:45 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1grh7i-00089c-Sj; Thu, 07 Feb 2019 11:41:38 +0100
Message-ID: <1549536098.4557.9.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] arm64: dts: hisilicon: hi3670: Add reset controller
 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 xuwei5@hisilicon.com, robh+dt@kernel.org
Date: Thu, 07 Feb 2019 11:41:38 +0100
In-Reply-To: <20190201153841.21903-3-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
 <20190201153841.21903-3-manivannan.sadhasivam@linaro.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_024143_020159_48053F1B 
X-CRM114-Status: GOOD (  11.51  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMDE5LTAyLTAxIGF0IDIxOjA4ICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
d3JvdGU6Cj4gQWRkIHJlc2V0IGNvbnRyb2xsZXIgc3VwcG9ydCBmb3IgSGlTaWxpY29uIEhJMzY3
MCBTb0MuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFu
bmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4KPiAtLS0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9o
aXNpbGljb24vaGkzNjcwLmR0c2kgfCA2ICsrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvaGlzaWxpY29u
L2hpMzY3MC5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjcwLmR0c2kK
PiBpbmRleCBhNWJkNmQ4MGIyMjYuLjgzOTUwMTE5MTAwZSAxMDA2NDQKPiAtLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2hpc2lsaWNvbi9oaTM2NzAuZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvaGlzaWxpY29uL2hpMzY3MC5kdHNpCj4gQEAgLTE1MSw2ICsxNTEsMTIgQEAKPiAgCQkJ
I2Nsb2NrLWNlbGxzID0gPDE+Owo+ICAJCX07Cj4gIAo+ICsJCWNyZ19yc3Q6IGNyZ19yc3RfY29u
dHJvbGxlciB7Cj4gKwkJCWNvbXBhdGlibGUgPSAiaGlzaWxpY29uLGhpMzY3MC1yZXNldCI7CgpU
aGlzIGNvdWxkIGJlCgoJCQljb21wYXRpYmxlID0gImhpc2lsaWNvbixoaTM2NzAtcmVzZXQiLMKg
Imhpc2lsaWNvbixoaTM2NjAtcmVzZXQiOwoKcmVnYXJkcwpQaGlsaXBwCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
