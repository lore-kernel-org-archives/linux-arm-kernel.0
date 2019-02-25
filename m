Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7655FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:23:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4913020684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SNPt29+J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="heTY1QR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4913020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eWDssC8YuT184wdsYu3K8VKyYNqW8R0ylh8xE1J48bg=; b=SNPt29+JLQF1ur
	BLvdZIt/a300i6WMiaMgVlbJ7XKgaOl9ss3eKK7RXWSjDVwyJUN3436tQWrhFoq/NfHS1o+/Gn07n
	TFTlF+DJc+/pWNmoN0vTDy+O01aafGr2aX0nyxKn31cBJkzCkYM6h5yWy7GtSKVVIt58sn2Jz6TGk
	Lsl+/iz35EIxbXCjXnKxMNF+dJ3qT3mI2cGfYc2TMKkiGqKkldVWZL5iwXkRCFdBvk7zUn1VwSBtt
	LjOig/MvpGnyPREm448I37lD3K+Tb+pRTctWkj+pG+Wit2vblR4XgKZhBKgtFC3duuYhfrNQ3aH33
	2NZXjAVW1Gfvpp1A+yPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJyI-0007RY-JS; Mon, 25 Feb 2019 17:23:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJyF-0007RC-F4
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 17:23:16 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 16BE720684;
 Mon, 25 Feb 2019 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551115395;
 bh=jUVsctHUgvayoQ79L0I7WuO5SYorYv5zFy3yLJyycfU=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=heTY1QR9436fC/F+vwS8v1uF4btWeGRDQJ8ad3d+CJFY1y5pVZdd72ZK9RHSaeJwS
 yXrm2bAgcP9j7LTe+s0g67xd1m8RCkdU3zgUu3RJTTcWOtKjj65aLsike7H2OAUmkf
 Ebqzf3gzMbsJUIxaotVLGkZaBv+aWjcLsHEDZYiI=
MIME-Version: 1.0
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Message-ID: <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
 <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
 <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
To: Abel Vesa <abel.vesa@nxp.com>
Date: Mon, 25 Feb 2019 09:23:14 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_092315_522008_EF2E6A77 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Anson Huang <anson.huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2019-02-23 02:58:14)
> On 19-02-22 09:46:23, Stephen Boyd wrote:
> > Quoting Abel Vesa (2019-02-22 09:07:32)
> > > Make the entire combination of plls to be one single clock. The parents used
> > > for bypasses are specified each as an index in the parents list.
> > > The determine_rate does a lookup throughout all the possible combinations
> > > for all the divs and returns the best possible 'setup' which in turn is used
> > > by set_rate later to set up all the divs and bypasses.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > Tested-by: Lucas Stach <l.stach@pengutronix.de>
> > > Acked-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > I suspect these tested by and acked tags should have been dropped,
> > unless you discussed and tested off-list?
> > 
> 
> Oups, I forgot to drop them.

Ok. Can Lucas re-test?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
