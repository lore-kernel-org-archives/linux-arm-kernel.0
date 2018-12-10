Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C0CC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:41:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A4720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSOsYRup";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wIY1Q/II"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A4720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nmnWr6FDpAYpe/i+90cgfKqXhiEDUK9UPsk8abCWDqA=; b=bSOsYRupGW6I0L
	l/dl53cgHERYyTpkm8Pr2qnmE6/u9Gicm4idBi/u8JnVjvRfaUphACUgUkcJF4sLQYD8Wi7ZEZPns
	kPCTA2jGFye2buJkRE6EByDmc4KTHnunqiHJ9w9vceizryH4eImcLrBhnka0Zx9+iO52SBEVWDuBL
	RBdxi2E2NsQB/M/7U57qHblniWt807okNps8PKNdZv4m8hlyke9ofPywEvYe80aVBomJP2o0aiCHE
	2ygGHr/+Hxrb8Mj/GnEJXgCff46sKCfVk+7B5QrSx6INBz8Io/ILYYwJ5K0Q+r3N3D0PsxENjqjBB
	f4eVYEVQU6Mymhbkeh5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRR4-0005hr-MR; Mon, 10 Dec 2018 19:41:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRQd-0005HT-GV
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:41:22 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D57DC2086D;
 Mon, 10 Dec 2018 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544470874;
 bh=eT6QUacECgY13eWEa+Kk0VTLFDH2pcazlSIC8G7U32A=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=wIY1Q/IIrFIZtIWm1DfzrQ6DMxBeNDT7ajhrQ5bneLqlRX16c3NhUIfVTZrhy0/P5
 5LtOOBvFwKoxoj6ILyBpVGMQBGuZ5XbN/wj+CC1cAigwGhfQH/eqZxT1T6td78BkGT
 Utu5GBavY8LlRALWrm28Xiiq93UQTWZ8dYe01g9o=
MIME-Version: 1.0
In-Reply-To: <20181115143028.19087-3-l.stach@pengutronix.de>
Message-ID: <154447087417.17204.15229374543848791608@swboyd.mtv.corp.google.com>
To: Lucas Stach <l.stach@pengutronix.de>,
 Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 3/3] clk: imx6q: handle ENET PLL bypass
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181115143028.19087-1-l.stach@pengutronix.de>
 <20181115143028.19087-3-l.stach@pengutronix.de>
Date: Mon, 10 Dec 2018 11:41:14 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_114119_646660_8D5CFE4F 
X-CRM114-Status: UNSURE (   6.06  )
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
Cc: devicetree@vger.kernel.org, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Lucas Stach (2018-11-15 06:30:28)
> The ENET PLL is different from the other i.MX6 PLLs, as it has
> multiple outputs with different post-dividers, which are all
> bypassed if the single bypass bit is activated. The hardware setup
> looks something like this:
>                                 _
> refclk-o---PLL---o----DIV1-----| \

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
