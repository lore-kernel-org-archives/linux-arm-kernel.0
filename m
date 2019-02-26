Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:00:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5D721850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WV9Rtbv3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/pSooiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5D721850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1MZVhfof4kyfmVd2aAfHxc6mx/xVDsv2zRWl+83U+yo=; b=WV9Rtbv3+GhwIM
	bE+CCnN73L1EvMcTh/N6ljOMpH59XO1hEaGa3QSZGze5ptKmz2Xx5X2o1Qta76ZXu8murz5gdliK3
	dVa9FUhxw+5wjwz0g/nPf+iPaVbNemejpzcTf3FK/c8E8HDuwCauY1WY+5mhiDoRIPS4HZyrM8llf
	34fJv9LRIdsI9IBGimDO6NPXDJu2JDWMvTw3JvnbvegqnUcq8Bnlkr0CDqidWaRseCfdJRLQVeTOE
	bQF+x9kU2btdT+6hSWxBmK7+jhj/qvvq8Xl9LIqgjpqVAzOYKwR9wBxyix/A+yhRYhlcnukzhtRiR
	zzMu079bcxzapURu/Ijg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyh1h-0000N0-Kd; Tue, 26 Feb 2019 18:00:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyh1e-0000Md-MY
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:00:19 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49EB9206B8;
 Tue, 26 Feb 2019 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551204018;
 bh=73yotcdHld+L1e6oBpOPCpusDnidGBSb2ABlfKzMayY=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=s/pSooiOhpPbc9OLbutzInI6b7PNGzVZqhLh4MWd7wSyG18cQoNHnJkEazK00gVTn
 Zj5lQ4W4GsGvy0fBeYg9TuZnI6KMrey9kGk+YC6ZUmbk73B6ZpkgSUV8Yt0dRGsf0t
 dW1kXcK87LjOnEEZ4VV4Bu6DxDjFSHCY49GQBXwk=
MIME-Version: 1.0
To: "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
 Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
References: <1550891665-29082-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <155120401746.260864.13314128182651447991@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550891665-29082-1-git-send-email-Anson.Huang@nxp.com>
Date: Tue, 26 Feb 2019 10:00:17 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_100018_754366_A9B1EAF1 
X-CRM114-Status: UNSURE (   6.55  )
X-CRM114-Notice: Please train this message.
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Anson Huang (2019-02-22 19:19:03)
> i.MX8MQ has clock gate for each GPIO bank, add them
> into clock tree for GPIO driver to manage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change since V1, just drop 1 patch from V1 patch series.

This doesn't apply to clk-imx branch or clk-next. Please rebase and
resend.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
