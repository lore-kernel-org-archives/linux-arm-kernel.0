Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C17C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:29:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A44A2077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dTkleTU7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUGCvQfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A44A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:To:References:
	Message-ID:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NYD/AfmnnurloeLIJB0zByWphWlIfqHQ+AFevdc2DqU=; b=dTkleTU71TYhRP
	gq1Wyy7zELqBLSljfP2wPKNBL7uGDv9pod70pXlLQ77Tf6ELBmRaG6fe67OnOTmIL+Rp8CLXgK31Y
	Yf78B5arTMe4Bt5J9N9uq2TUh4USRIJJU8BFNwrLuFjf/S4QNByvn7i6oDa4RpP0eS39jbhXj6Rou
	KJuJWiIyyFhbppXC1KFNdzVZtibzNVEErmOCAibJZswct0R5Y3FTRZ7uIJ+FglDNuQrJgqTxMXVO1
	+Az31aGv1EHBh9jJXtzrYEmbLgg+IHu9oT2MxTjh8LC5Stxq/CeQ2nkyzeEYMX7+wAvLA98T0tjrt
	Asgm1CiLfdrN385YdObA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr9DF-0008HH-Gj; Tue, 05 Feb 2019 22:29:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr9DB-0008Ge-VA
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 22:29:03 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 934E02077B;
 Tue,  5 Feb 2019 22:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549405741;
 bh=6WHkd1+UkKwPg7U2XsHUH+zvzu5O/W+hf3bYnca/eo8=;
 h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
 b=VUGCvQfWJ/HziulJGaKFh2GPkmaVoBfXLxKewKXu49Ciu3SlAnDZwHimrtaV51t/1
 6abUMQFihWxlmtyDl/xBDuG/FvBFCMSWiPkaiP3uhZm16OaWBExFD26RFJz5u7Ocog
 ebZCQnIFRFiQ/Y5ce3aO8Ifqq/GlKnI7Exjd7nK0=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: imx8mq: Fix the CLKO2 source select list
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940574088.169292.15304825462770873584@swboyd.mtv.corp.google.com>
References: <20190130192102.7065-1-festevam@gmail.com>
User-Agent: alot/0.8
To: Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20190130192102.7065-1-festevam@gmail.com>
Date: Tue, 05 Feb 2019 14:29:00 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_142902_019551_395E0D0D 
X-CRM114-Status: UNSURE (   8.79  )
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

Do I need to fast track this into v5.0 final? Or this is a non-critical
fix for something that isn't used right now?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
