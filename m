Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75893C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:56:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4168120881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JTpzDQST";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kCNnjQu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4168120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ExO7uWldp4feumDazESWqlBM7vOG35vyq4JG31CJ/dc=; b=JTpzDQSTDZZiyr
	9OWq9Zi8fJSZ4mwRh7FQCD0qby7OMFpQDoXG+ru0yGkmrsgPDp8jPBOYCGQCGhPW4fclYAM3+e2wt
	CCUTZey4LNbvcA+lSzMCnoNNeH4OkUU67xLH84wFtnTB9DlVry1DR58Ksf+necPGnXHUMOdApu/9i
	EwW29xa3mbxY6+pcZ22i21DYBhACCL03UB7S9A/nRcpxqhQWaR2mMTlpVwhhyXYQJQqDUjh56jYPK
	C6ipWkc3/wKjhtqyzACbI6NCYmAwZocqEyFncLUM3RistL7QJL+GPBeBghEYww/mbP0Kpm5ATTDOR
	XGYt5iDfLn8hZlb9wA7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzA4-0007Ng-9I; Fri, 25 Jan 2019 10:56:36 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz9T-0006wP-LH
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:56:01 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4aeb1a0000>; Fri, 25 Jan 2019 02:55:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 25 Jan 2019 02:55:59 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 02:55:59 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 10:55:57 +0000
Subject: Re: [PATCH 5/7] soc/tegra: pmc: Make alignment consistent
To: Thierry Reding <thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
 <20190125102255.6862-5-thierry.reding@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e57f4663-fafc-510e-40fb-90fc0b350f59@nvidia.com>
Date: Fri, 25 Jan 2019 10:55:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125102255.6862-5-thierry.reding@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548413723; bh=HvF02YpXx8Q/sSSBRKVK2IRmM2TP0HavckLWGl8BXKs=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=kCNnjQu43PIBMzgNbI64zzlOy0RZi15fRlzE4MgEfOce2Jgx5n3sgNPrB9x5EV/ax
 nxpSv78zikXFwnFzQ2D9JhtvILwdIpvURHLCQSaHcGc2OOO6vcusSjdmy7e2wCELY9
 3FZVfYBlulbFTvyEpQnAHo052USNH52pF8uY6OnVielaAll54pmBIyrJrSlDJhNIie
 j9tUysPgQsX0OAZi5bPjEJyZln9tvPW/3JmnNxTE4kg6IcJTEahGZy/zDGqnpG8sfE
 4/8QKJ3IduPUmbiY9GTDVk9qm3gJREFzJxhy0uK/0iUT1ZrcBRgVwtMLMxgwDKyK6e
 8Dkp6mSfj4xoA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_025559_766699_51ABE9E5 
X-CRM114-Status: GOOD (  16.29  )
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
Cc: linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 25/01/2019 10:22, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Some recently added code used weird alignment and indentation. Fix these
> occurrences to make them consistent with the rest of the code.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 32dd619c098e..2a2e6aaae97e 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -1502,8 +1502,8 @@ static int tegra_io_pad_pinctrl_get_groups_count(struct pinctrl_dev *pctl_dev)
>  	return pmc->soc->num_io_pads;
>  }
>  
> -static const char *tegra_io_pad_pinctrl_get_group_name(
> -		struct pinctrl_dev *pctl, unsigned int group)
> +static const char *tegra_io_pad_pinctrl_get_group_name(struct pinctrl_dev *pctl,
> +						       unsigned int group)
>  {
>  	struct tegra_pmc *pmc = pinctrl_dev_get_drvdata(pctl);
>  
> @@ -1519,6 +1519,7 @@ static int tegra_io_pad_pinctrl_get_group_pins(struct pinctrl_dev *pctl_dev,
>  
>  	*pins = &pmc->soc->io_pads[group].id;
>  	*num_pins = 1;
> +
>  	return 0;
>  }
>  
> @@ -1548,14 +1549,18 @@ static int tegra_io_pad_pinconf_get(struct pinctrl_dev *pctl_dev,
>  		ret = tegra_io_pad_get_voltage(pmc, pad->id);
>  		if (ret < 0)
>  			return ret;
> +
>  		arg = ret;
>  		break;
> +
>  	case PIN_CONFIG_LOW_POWER_MODE:
>  		ret = tegra_io_pad_is_powered(pmc, pad->id);
>  		if (ret < 0)
>  			return ret;
> +
>  		arg = !ret;
>  		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1622,7 +1627,7 @@ static struct pinctrl_desc tegra_pmc_pctl_desc = {
>  
>  static int tegra_pmc_pinctrl_init(struct tegra_pmc *pmc)
>  {
> -	int err = 0;
> +	int err;
>  
>  	if (!pmc->soc->num_pin_descs)
>  		return 0;
> @@ -1635,14 +1640,16 @@ static int tegra_pmc_pinctrl_init(struct tegra_pmc *pmc)
>  					      pmc);
>  	if (IS_ERR(pmc->pctl_dev)) {
>  		err = PTR_ERR(pmc->pctl_dev);
> -		dev_err(pmc->dev, "unable to register pinctrl, %d\n", err);
> +		dev_err(pmc->dev, "failed to register pin controller: %d\n",
> +			err);
> +		return err;
>  	}
>  
> -	return err;
> +	return 0;
>  }
>  
>  static ssize_t reset_reason_show(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> +				 struct device_attribute *attr, char *buf)
>  {
>  	u32 value, rst_src;
>  
> @@ -1656,7 +1663,7 @@ static ssize_t reset_reason_show(struct device *dev,
>  static DEVICE_ATTR_RO(reset_reason);
>  
>  static ssize_t reset_level_show(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> +				struct device_attribute *attr, char *buf)
>  {
>  	u32 value, rst_lvl;
>  
> @@ -1678,16 +1685,16 @@ static void tegra_pmc_reset_sysfs_init(struct tegra_pmc *pmc)
>  		err = device_create_file(dev, &dev_attr_reset_reason);
>  		if (err < 0)
>  			dev_warn(dev,
> -				"failed to create attr \"reset_reason\": %d\n",
> -				err);
> +				 "failed to create attr \"reset_reason\": %d\n",
> +				 err);
>  	}
>  
>  	if (pmc->soc->reset_levels) {
>  		err = device_create_file(dev, &dev_attr_reset_level);
>  		if (err < 0)
>  			dev_warn(dev,
> -				"failed to create attr \"reset_level\": %d\n",
> -				err);
> +				 "failed to create attr \"reset_level\": %d\n",
> +				 err);
>  	}
>  }
>  
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
