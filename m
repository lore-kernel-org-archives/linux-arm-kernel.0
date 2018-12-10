Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A797C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:09:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680CB2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HqBrFFTC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="a3hy1qKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680CB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tc+B1emvtmdQtXOVGEYIbGkVw90RfWam32Vmcz1oY9o=; b=HqBrFFTCRl/jT1
	PxSmzydGE1dL7RS4eXhfT0+TQ1iRHel5VKC8Jo+nmDXv4Egbdwid5Qyh+m2p47tickuwp2eHLvqrm
	x46W5PRxsU7WwozxN9CiCCvWn3Yqz94QPT1qiDv01m2yuJxViKRV4Q0I0A36chxIQRQUiY/mOxX0r
	1iwCMZrHFg7Mv6Fzb+dORWel9you2GXRs5OYOWf9lzayCrojqTCg0XR7bvb10d8yo5vMmyQQlMMXz
	sTyD3zvF4epRq6VcnfWn1nIZpDXvXVByqsfTXqJrKKHeqitOfaZ2xT/CFqdS3AMU8RZWs1HIF0Q10
	uhchwyD9mBjRofouDCMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKN9-0008HB-4s; Mon, 10 Dec 2018 12:09:15 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKN5-0008Fv-7o
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:09:13 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 7249025BE52;
 Mon, 10 Dec 2018 23:08:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544443739; bh=lU4/HdYSsk53TmCPVDmJNHFJFDyZh6EuuOpYKe4MpUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a3hy1qKrM+3eP3rJQw8AgKNjlCA5mXfZy8z1ymUHVruKWnvBzCwZJKbl4CAeRIj60
 bH51reNiG822n6VcHtCs8pR0mYG5lqFj92pqc8HF6J5KEFwkjzOsqi18OJfQGBIdbZ
 13ufuhtyjcqmys4OL3IBKN89pRhVZ0uCqSMF/Xm4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id E60029402E1; Mon, 10 Dec 2018 13:08:57 +0100 (CET)
Date: Mon, 10 Dec 2018 13:08:57 +0100
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Fix R-Car Gen2 regulator quirk
Message-ID: <20181210120857.puyfajkncvrznley@verge.net.au>
References: <20181207202858.17129-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207202858.17129-1-marek.vasut+renesas@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_040911_431517_66B0F5B8 
X-CRM114-Status: GOOD (  21.76  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 09:28:58PM +0100, Marek Vasut wrote:
> The quirk code currently detects all compatible I2C chips with a shared
> IRQ line on all I2C busses, adds them into a list, and registers a bus
> notifier. For every chip for which the bus notifier triggers, the quirk
> code performs I2C transfer on that I2C bus for all addresses in the list.
> The problem is that this may generate transfers to non-existing chips on
> systems with multiple I2C busses.
> 
> This patch adds a check to verify that the I2C bus to which the chip with
> shared IRQ is attached to matches the I2C bus of the chip which triggered
> the bus notifier and only starts the I2C transfer if they match.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org

Thanks,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> index d4774d8ff997..f78e5348bd4c 100644
> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> @@ -40,6 +40,7 @@
>  struct regulator_quirk {
>  	struct list_head		list;
>  	const struct of_device_id	*id;
> +	struct device_node		*np;
>  	struct of_phandle_args		irq_args;
>  	struct i2c_msg			i2c_msg;
>  	bool				shared;	/* IRQ line is shared */
> @@ -102,6 +103,9 @@ static int regulator_quirk_notify(struct notifier_block *nb,
>  		if (!pos->shared)
>  			continue;
>  
> +		if (pos->np->parent != client->dev.parent->of_node)
> +			continue;
> +
>  		dev_info(&client->dev, "clearing %s@0x%02x interrupts\n",
>  			 pos->id->compatible, pos->i2c_msg.addr);
>  
> @@ -167,6 +171,7 @@ static int __init rcar_gen2_regulator_quirk(void)
>  		memcpy(&quirk->i2c_msg, id->data, sizeof(quirk->i2c_msg));
>  
>  		quirk->id = id;
> +		quirk->np = np;
>  		quirk->i2c_msg.addr = addr;
>  
>  		ret = of_irq_parse_one(np, 0, argsa);
> -- 
> 2.18.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
