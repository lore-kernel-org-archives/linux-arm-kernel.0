Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B7CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:45:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D552520836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FYqGh2R4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulrEh7IF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D552520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XjPpzUUvWc4oMbQ42izTELgDnZ9ACUzmKsETcId4C8c=; b=FYqGh2R44UaKZP
	Y8IB7jrTmRiZ+fN+h8/RLvSk2k5dWw7l/6L/ItsEusUHLvFeyo1IEr5xdoLLS3r4q7iaBjPlxyqXb
	qhm68bs7uKMg/Excli0RVD5ZsEgE55nYM1/+vB+qsrdzTYY1tweKv90JFYKHstgt05k8g1jgLRQrv
	q0p0J+uRYUCd1I3/4rllcw7QfTBjZVrWgqva+dtiIiC+ZOF7YCSe/rfb/u6jxQ/R4vjglLfZKjkW6
	ZErEssr9Vx53aSXwSXmZnBj+xp7fBIz7nb5SUqIi+naqUPvy1Ia3tdUXc5dOEYHX77AzTis/N+jHb
	v2VKblMQ92FP9rdN8DdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvDS-0003LX-Ut; Thu, 21 Feb 2019 20:45:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvDB-0002jt-No
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 20:44:55 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 584F5206C0;
 Thu, 21 Feb 2019 20:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550781893;
 bh=UtI9MJV/kzN3+zq9QLlWk5QQr4uns4VCMffVh4P15s0=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=ulrEh7IFuc29MGfe5zz7rG4T/WmUR/kbA6KKLXsoFeh4cYcR1xsATTo06azncvqd8
 hKJIyqGHoNUYmTBp9YrtpjHdGTUyHLOGfbcS14XMAx7nxF3jUSbL5VI3B+9AO//rzG
 6zbydBXvSsDG9ojQ7iAIivwKGrMYlvzp8N5QUdPE=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: imx8mq: Fix the CLKO2 source select list
Message-ID: <155078189263.77512.18004354775400355628@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190130192102.7065-1-festevam@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190130192102.7065-1-festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Feb 2019 12:44:52 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_124453_878887_4DE9E8A8 
X-CRM114-Status: UNSURE (   8.91  )
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
Cc: Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, rogerio.silva@nxp.com, shawnguo@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Fabio Estevam (2019-01-30 11:21:02)
> The CLKO2 clock source select list is the following as per the i.MX8M
> Reference Manual:
> 
> 000 - 25M_REF_CLK
> 001 - SYSTEM_PLL2_DIV5
> 010 - SYSTEM_PLL1_DIV2
> 011 - SYSTEM_PLL2_DIV6
> 100 - SYSTEM_PLL3_CLK
> 101 - AUDIO_PLL1_CLK
> 110 - VIDEO_PLL1_CLK
> 111 - 32K_REF_CLK
> 
> However, in imx8mq_clko2_sels[] only the first four entries are correct.
> 
> Fix it by adding the missing "sys3_pll2_out" entry in order to match
> the description from the manual.
> 
> Fixes: b80522040cd3f ("clk: imx: Add clock driver for i.MX8MQ CCM")
> Reported-by: Rogerio Pimentel <rogerio.silva@nxp.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
