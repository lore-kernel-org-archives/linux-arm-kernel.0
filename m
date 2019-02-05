Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C457C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:59:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F035F20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gRe7judt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="zE77ajz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F035F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OKcn5DlqZLXAbjMJPf8BHbEbFl2d9HddIq5fOjOtPEg=; b=gRe7judt7jrHaKSAXlHyf7raw
	vYVk3Row/vMzzmSBhISbUsw8tbrKAshFxtK/+fSwny6Lnir9S+W6vV+uFMXzzbg/cargWHvVNj7ON
	zOrwE6DPwr57etizsiUF7ExX300flzEvDXiiWQ87e4AreCVj5Sgvnih6zqjfxHcxOzDO3VkwdMP9c
	pfJ3NRTUlUp6a3uKxCEjcLnTnZTeSuou3SGIR7ZCKLkgtUvejCVzjRYKiVm2rCT7yzd2P7npQulOJ
	lHSCyg4coVQc/cG9gbMJDpLrpw1zA8aPHQy8zQjZmYUZqo4wKrGlGw1GKO0WG0sz/Dt2l+4VkYmL9
	UXWd4g5rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqp5M-000301-0B; Tue, 05 Feb 2019 00:59:36 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqp5I-0002zh-LV
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 00:59:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PSnCQDoU2fGVJP8IEZNRsTvLSs6qKZVL6I48FtBgFpc=; b=zE77ajz0qyk16+By8TxySg9Uo4
 yCPh9SZYcY46gAgL1hZh03sUz1ueqBV0ARwKR/gnujkf7i5iicLWfGuwvc9T1C9GFyh1b9xhUk4Sr
 CmvUVPa8Mku11vvuVbGrWeqAv/cfT70rmQGZSORQZ5tyo4hzWDJQ25EpCEneRmNhpsO8nFxHmGrBs
 ZGdDmF/7ldRqJ3NLS6AVHzK+ohbPzhLwYRo+rPA14MtP6gAWT0x6nCrxcoLgdhAsmr/gKH/wxOM/p
 vK8h5Wy1vSdBBFwTl3rrSBH7e+iepPgRsOqjF346VuMwXmzxGCPLdJ/WZ2LhWpZNIydGMZTFzcpsI
 gKEojK8Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:32862 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqp1n-0001my-M1
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 19:55:55 -0500
Subject: Re: [PATCH 33/35] ARM: davinci: prepare to remove mach/irqs.h
To: linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-34-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <be89b447-5191-6220-5234-f42ba53c5044@lechnology.com>
Date: Mon, 4 Feb 2019 18:59:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-34-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_165932_861759_922438FA 
X-CRM114-Status: GOOD (  16.41  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since we now select SPARSE_IRQ in davinci, the mach/irqs.h header is
> no longer included from asm/irq.h. All interrupt numbers for devices
> should be defined as platform device resources. Let's prepare for the
> removal of mach/irqs.h by moving all defines that we want to keep to
> relevant headers (davinci.h, common.h) and replacing others with
> simple literals.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/board-da830-evm.c     |  2 +-
>   arch/arm/mach-davinci/board-da850-evm.c     |  4 ++--
>   arch/arm/mach-davinci/board-dm644x-evm.c    |  2 +-
>   arch/arm/mach-davinci/board-dm646x-evm.c    |  2 +-
>   arch/arm/mach-davinci/da830.c               |  2 +-
>   arch/arm/mach-davinci/da850.c               |  2 +-
>   arch/arm/mach-davinci/davinci.h             |  2 ++
>   arch/arm/mach-davinci/include/mach/common.h |  5 +++++
>   arch/arm/mach-davinci/include/mach/irqs.h   | 18 ------------------
>   9 files changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index b3a0148f7f1a..950e98e4eda5 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -488,7 +488,7 @@ static int da830_evm_ui_expander_teardown(struct i2c_client *client, int gpio,
>   }
>   
>   static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
> -	.gpio_base	= DAVINCI_N_GPIO,
> +	.gpio_base	= 144,

I think it would be better to keep the *_N_GPIO macros.

>   	.setup		= da830_evm_ui_expander_setup,
>   	.teardown	= da830_evm_ui_expander_teardown,
>   };


...

> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 9cf9b090efeb..74cbab153e59 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
> @@ -730,7 +730,7 @@ static const struct davinci_cp_intc_config da830_cp_intc_config = {
>   		.end		= DA8XX_CP_INTC_BASE + SZ_8K,
>   		.flags		= IORESOURCE_MEM,
>   	},
> -	.num_irqs		= DA830_N_CP_INTC_IRQ,
> +	.num_irqs		= 96,

This change could be avoided by using 96 in the first place in
"ARM: davinci: cp-intc: add the new config structures for da8xx SoCs"

>   };
>   
>   void __init da830_init_irqs(void)
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index b9ebdcde68eb..644f4eec8d5c 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -658,7 +658,7 @@ static const struct davinci_cp_intc_config da850_cp_intc_config = {
>   		.end		= DA8XX_CP_INTC_BASE + SZ_8K,
>   		.flags		= IORESOURCE_MEM,
>   	},
> -	.num_irqs		= DA850_N_CP_INTC_IRQ,
> +	.num_irqs		= 101,

same here

>   };
>   
>   void __init da850_init_irqs(void)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
