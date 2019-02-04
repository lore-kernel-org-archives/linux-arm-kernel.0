Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F9C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:56:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DD72082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KQOsCRWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DD72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SDHRX7cwUxvLxTdllcHNtXMWtQoi57fvs30k+00GTpQ=; b=KQOsCRWpCeppAE
	GlGG7nFoczfiJRUnxOuxHlJ9xfEAqgG2VX8PpJbhy3nWmYW+X6bh5n+Dz21w8EH/Y2lIxCWZZaL5G
	ODjfl4qZzc8X5KWuxYZA5zIJvV3md9UzaxMOISCbNbNnw+xs1NUSMjGHvJCKs8iRY5ZDcJ+N9IAB3
	hOvum4OW9Of7uBGTSjLtRn8pd1H4EmMEr5MpwRGohfAV0oJUSkatN5Gdx3phGDLSij9Wjwsje/D4M
	h+WJJ91x+OLDs3fPvbvuFKZlyBqUs0dctCxuZFC7v30vuf2Y+QjwOKXO8bj1dnlQp3MkWgfSPez8u
	jD5adkkphhOse13U50eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqgbX-0004Wr-36; Mon, 04 Feb 2019 15:56:15 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqgbT-0004W4-4d
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 15:56:12 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id B9D1E808C;
 Mon,  4 Feb 2019 15:56:16 +0000 (UTC)
Date: Mon, 4 Feb 2019 07:56:04 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190204155604.GH5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190202055827.12956-1-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_075611_220313_CBCF4B76 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: linux-omap@vger.kernel.org, khilman@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 letux-kernel@openphoenux.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Andreas Kemnade <andreas@kemnade.info> [190202 06:01]:
> Enabling off mode was only reachable deeply hidden
> in the debugfs. As powersaving is an important feature,
> move the option out of its shady place.

How about let's enable always if we have the twl4030
configured to allow it? You can just check if the dts has
"ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
properties set.

In order to enable deeper idle states, the user space still
needs to idle the UARTs and possibly other hardware blocking
idle. So we should be safe there.

> The debugfs file can still be used to override the default.

Yes let's keep the debugfs switch around. But it should
be optional for CONFIG_DEBUGFS like I think it now is.

> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -416,7 +416,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  	if (!pwrst)
>  		return -ENOMEM;
>  	pwrst->pwrdm = pwrdm;
> -	pwrst->next_state = PWRDM_POWER_RET;
> +
> +	if (IS_ENABLED(CONFIG_OMAP3_PM_OFFMODE))
> +		pwrst->next_state = PWRDM_POWER_OFF;
> +	else
> +		pwrst->next_state = PWRDM_POWER_RET;
> +
>  	list_add(&pwrst->node, &pwrst_list);
>  
>  	if (pwrdm_has_hdwr_sar(pwrdm))

You can check for the PMIC properties by adding a function
for omap3_pm_check_pmic() or similar and call it
from omap3_pm_init(). And then you can set the needed flags
in omap3_pm_check_pmic() such as omap3_has_twl and off mode.
You might want to make it somewhat PMIC independent as in
theory somebody may still want to add support for other
PMICs such as cpacp for omap3 although that's unlikely.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
