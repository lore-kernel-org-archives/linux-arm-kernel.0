Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34694C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:03:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013C7218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PX3GI1CM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zU0WCnis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013C7218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Subject:To:In-Reply-To:
	Message-ID:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XRcQpGfEkyQUcztSob8BdUf/ls5zq24z2rk54WwSboA=; b=PX3GI1CMQhWIPV
	RIk1Vdiutv8TU1gxPnAexCI8tRCzolM2VXeKSrsPEr0lcDWQC9REsb7YKJnm8nciXK2IBfXITuzc5
	UuOLbHbDAmgDL2fGjht3tYeVpqmgvFUxoyvUK42imwqR87nvBem6H8qIbhd0VfWjq85+BbQ9BKVTu
	y/NABqPKoFU7jNjJEOySkVXnfO2T+vGj5onrWmiiqd749qS76ntTFeh3bsLJQAPZf6aESXsdYDMhU
	RV/BXMCahGYT1fjT9+VlB8ct7nDmivi4rcZ/blNmPhlP/VCmOQboZ3H2Cv5cO0AIlXA5Ns44pg+P8
	dl92N9t9SRVWLHIeG2kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZPKx-0002ZM-K3; Wed, 19 Dec 2018 00:03:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZPKu-0002YG-WB
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 00:03:42 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A309218AD;
 Wed, 19 Dec 2018 00:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545177810;
 bh=l9X3UQoXgIeCGAP/aU9OPQ/7WsOloIc3sY+fcmmC0fU=;
 h=References:In-Reply-To:To:Cc:Subject:From:Date:From;
 b=zU0WCnisjRLfQquJ/mvI8tmCfBNSPpUXGRg0ViDwKeRDtgaNkmBX733A3lerUAXCF
 o9FoGX3J+NZ2ukLKM3jS2aSRby+/FugJSGTfGnssuPqgLC1rMw1tAl3HIZZqr8q9fd
 g0nGjXFtUyPolQvS+rSYkzk55Q2d4bB7NQDWev8g=
MIME-Version: 1.0
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-2-miquel.raynal@bootlin.com>
Message-ID: <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com>
In-Reply-To: <20181204192440.12125-2-miquel.raynal@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Russell King <linux@armlinux.org.uk>
User-Agent: alot/0.8
Subject: Re: [PATCH v3 1/4] clk: core: clarify the check for runtime PM
From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 18 Dec 2018 16:03:29 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_160341_054768_F767E0BB 
X-CRM114-Status: GOOD (  17.72  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Miquel Raynal (2018-12-04 11:24:37)
> Currently, the core->dev entry is populated only if runtime PM is
> enabled. Doing so prevents accessing the device structure in any
> case.
> 
> Keep the same logic but instead of using the presence of core->dev as
> the only condition, also check the status of
> pm_runtime_enabled(). Then, we can set the core->dev pointer at any
> time as long as a device structure is available.
> 
> This change will help supporting device links in the clock subsystem.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/clk.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index af011974d4ec..b799347c5fd6 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -97,7 +97,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
>  {
>         int ret = 0;
>  
> -       if (!core->dev)
> +       if (!core->dev || !pm_runtime_enabled(core->dev))

This looks potentially dangerous. What if runtime PM is disabled for the
clk when this function is called? Shouldn't we just stash a bool away in
the clk_core structure when it's registered? And then we can replace the
check for !core->dev with a check for 'core->rpm_enabled' instead. That
would be a more exact transformation.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
