Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:01:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA6B21906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lfryk7tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA6B21906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nGlPnQUrkhDNQP497OPb5dXvp6Ey0rCbeN7Njy87vck=; b=Lfryk7tQKw6VW4
	QT5rNZWnpTV3RBKMWiwT77FDxUd8Dcfdbs0I6vZawcVWoUjcMzphEHYkBwp2VQpmxpoK83oiGZ2nM
	0hFfpGp6DKVHcBqs+YOKSF5foTzUvkd7YYYv3W5RHV9ap/YHZvqV8zkIRKBnQkQSvjFcB37E9gWVD
	pS5wb34d7qe9AJTxEgGq0kGUUNeTMmRs4AcW+cHtTXKDQr6Jf+m3dcBvf+7/Eiv4HL4I763sAVj6q
	wtpc+qVcyPMcCF1bF9vWZkC7Hl0lpBSRKZer+cjnnURLl568wzA+wzlsiHluSrzUJPvuLakVNQHya
	2cccI8bcuXs0nPECdFOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaKQq-0004Wo-Bh; Fri, 21 Dec 2018 13:01:36 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaKPu-0003TH-SO
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 13:00:49 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9C429207D4; Fri, 21 Dec 2018 14:00:25 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6B9FC207AD;
 Fri, 21 Dec 2018 14:00:25 +0100 (CET)
Date: Fri, 21 Dec 2018 14:00:25 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
Message-ID: <20181221130025.lbvw7yvy74brf3jn@flea>
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
 <20181220125438.11700-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181220125438.11700-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_050039_678693_7AAE3F85 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 06:24:34PM +0530, Jagan Teki wrote:
> Unfortunately default CSI_SCLK rate cannot work properly to
> drive the connected sensor interface, particularly on few
> Allwinner SoC's like A64.
> 
> So, add mod_rate quirk via driver data so-that the respective
> SoC's which require to alter the default mod clock rate can assign
> the operating clock rate.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++++----
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index ee882b66a5ea..fe002beae09c 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -15,6 +15,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -28,8 +29,13 @@
>  
>  #define MODULE_NAME	"sun6i-csi"
>  
> +struct sun6i_csi_variant {
> +	unsigned long			mod_rate;
> +};
> +
>  struct sun6i_csi_dev {
>  	struct sun6i_csi		csi;
> +	const struct sun6i_csi_variant	*variant;
>  	struct device			*dev;
>  
>  	struct regmap			*regmap;
> @@ -822,33 +828,43 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
>  		return PTR_ERR(sdev->clk_mod);
>  	}
>  
> +	if (sdev->variant->mod_rate)
> +		clk_set_rate_exclusive(sdev->clk_mod, sdev->variant->mod_rate);
> +

It still doesn't make any sense to do it in the probe function...

We discussed this in the previous iteration already.

What we didn't discuss is the variant function that you introduce,
while the previous approach was enough.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
