Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B3AC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:47:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071712087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ktP5h5jD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V83uW5Dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071712087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ONdVYeRWqOHzBMN+PEgH4CkuC7Jfz084Nen6uSGoUqk=; b=ktP5h5jDRRSHy7
	jPQf4tlh4TlyMtThc8VgZtxGti/mrKhGhlmbuMkQO92pTnv4tYfXzN50weDhtjqvnO5xm7KELf4eC
	LXiy8pgRZxVjhO5varo425xvfuaGM82i3sA121HA5mxIn4mN3UzCdPL208B9GrE0jujqpSQ0bHXJI
	N+5+W236yIobeoulPpEwV5bDmKSVSjLl2LoXB/1WmihAMVnd97jxAioRygTYvYDr2UFcbCJmHsMoz
	4oqPt6kGR1aaxZXgZ1ztlYgFLbQ6ttp9gSitbWOCFkvhT1x9zFPlUsEaEQRFfTGfb0xUP8dZUqIB5
	mss7pWKakOO+7ixsj8jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnPF2-0000wM-8m; Sat, 26 Jan 2019 14:47:28 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnPEz-0000vz-DE
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 14:47:27 +0000
Received: by mail-pf1-x442.google.com with SMTP id b85so6023431pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 06:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Bf7xZE/Gt9Krzz5Kp61NPYGkKO50EUKxBnoHUsv86/I=;
 b=V83uW5DzhiWlRvwKUrcjI8MWwHaqTAiJVq9zGoLINnXrJCMxESC9QyyuZk0d2vWrkp
 T+Dy0wX1O5SPMS8Ryzh/a3kAZaUtAlOBfm1mnEZ/iPIf0dYGoGjaZZyyqWxGsfrhOpUR
 n+p6iqF51W3koryQ9QtInE//644nSIolXY+c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Bf7xZE/Gt9Krzz5Kp61NPYGkKO50EUKxBnoHUsv86/I=;
 b=DyqOUwa9zjzOcOx1aaN8Ti98TRL7S2TvW61Q/GM5e5aSlXsPqySWsY0CFoZk4b1aix
 RdEMFqcHgohLGtS+XOOOE5wVrdWM3UWM+r3ojKC0G0Jy1lb3ZBqWBu+P9JnERVedah7F
 0MBgyHHeox7AQjrKLp/VKwAm0PwUv9q2F48tBzwsN8vSySx32SKnJmzxOMBi4K84HeMh
 Rk3JxOEb2wSs63ghBbvRmvjkJ6RCIdp/jaWrR6ajVt2evmPFggAj42+kikYoGf2F4FB2
 /YC27w606zEbQ+97UlDTuvKZLmUs2Q4BV/KQBQxb72yG0TnDTjCLyiRIJ/bm9PCSzirw
 Dx7Q==
X-Gm-Message-State: AJcUukf/uzvQ4VT8XxmS0oVBbl5h0Ofoc1kZvVge+0GUN5nsFvS9MSM3
 CZ8zW255KkNpr6E2NZm/9XRf
X-Google-Smtp-Source: ALg8bN5VAdk0S/F5DmuPTmXd2cqc2NzYPUDcrALhNnpxTSErMjgnxOIbQJtT0H0HrjU15dUqbjqkmQ==
X-Received: by 2002:a62:8985:: with SMTP id n5mr15334779pfk.255.1548514044113; 
 Sat, 26 Jan 2019 06:47:24 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:807:9f85:b1bd:9891:c622:302d])
 by smtp.gmail.com with ESMTPSA id o189sm54970454pfg.117.2019.01.26.06.47.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 26 Jan 2019 06:47:23 -0800 (PST)
Date: Sat, 26 Jan 2019 20:17:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 3/3] scsi: ufs: Add HI3670 SoC UFS driver support
Message-ID: <20190126144711.GA14260@Mani-XPS-13-9360>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190105072859.9134-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_064725_460877_3D5C6861 
X-CRM114-Status: GOOD (  23.95  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, john.stultz@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 05, 2019 at 12:58:59PM +0530, Manivannan Sadhasivam wrote:
> Add HI3670 SoC UFS driver support by extending the common ufs-hisi
> driver. One major difference between HI3660 ad HI3670 SoCs interms of
> UFS is the PHY. HI3670 has a 10nm variant PHY and hence this parameter is
> used to distinguish the configuration.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Hello,

Ping on this patch!

Thanks,
Mani

> ---
>  drivers/scsi/ufs/ufs-hisi.c | 127 +++++++++++++++++++++++++++++-------
>  drivers/scsi/ufs/ufs-hisi.h |   4 ++
>  2 files changed, 109 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
> index 452e19f8fb47..f2d3df357a97 100644
> --- a/drivers/scsi/ufs/ufs-hisi.c
> +++ b/drivers/scsi/ufs/ufs-hisi.c
> @@ -66,7 +66,7 @@ static int ufs_hisi_check_hibern8(struct ufs_hba *hba)
>  	return err;
>  }
>  
> -static void ufs_hi3660_clk_init(struct ufs_hba *hba)
> +static void ufs_hisi_clk_init(struct ufs_hba *hba)
>  {
>  	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
>  
> @@ -80,7 +80,7 @@ static void ufs_hi3660_clk_init(struct ufs_hba *hba)
>  	ufs_sys_ctrl_set_bits(host, BIT_SYSCTRL_REF_CLOCK_EN, PHY_CLK_CTRL);
>  }
>  
> -static void ufs_hi3660_soc_init(struct ufs_hba *hba)
> +static void ufs_hisi_soc_init(struct ufs_hba *hba)
>  {
>  	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
>  	u32 reg;
> @@ -139,6 +139,7 @@ static void ufs_hi3660_soc_init(struct ufs_hba *hba)
>  
>  static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
>  {
> +	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
>  	int err;
>  	uint32_t value;
>  	uint32_t reg;
> @@ -153,6 +154,14 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8121, 0x0), 0x2D);
>  	/* MPHY CBOVRCTRL3 */
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8122, 0x0), 0x1);
> +
> +	if (host->caps & UFS_HISI_CAP_PHY10nm) {
> +		/* MPHY CBOVRCTRL4 */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8127, 0x0), 0x98);
> +		/* MPHY CBOVRCTRL5 */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8128, 0x0), 0x1);
> +	}
> +
>  	/* Unipro VS_MphyCfgUpdt */
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xD085, 0x0), 0x1);
>  	/* MPHY RXOVRCTRL4 rx0 */
> @@ -173,10 +182,21 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8113, 0x0), 0x1);
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xD085, 0x0), 0x1);
>  
> -	/* Tactive RX */
> -	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x4), 0x7);
> -	/* Tactive RX */
> -	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x5), 0x7);
> +	if (host->caps & UFS_HISI_CAP_PHY10nm) {
> +		/* RX_Hibern8Time_Capability*/
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0092, 0x4), 0xA);
> +		/* RX_Hibern8Time_Capability*/
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0092, 0x5), 0xA);
> +		/* RX_Min_ActivateTime */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008f, 0x4), 0xA);
> +		/* RX_Min_ActivateTime*/
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008f, 0x5), 0xA);
> +	} else {
> +		/* Tactive RX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x4), 0x7);
> +		/* Tactive RX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x5), 0x7);
> +	}
>  
>  	/* Gear3 Synclength */
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0095, 0x4), 0x4F);
> @@ -208,7 +228,8 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
>  	if (err)
>  		dev_err(hba->dev, "ufs_hisi_check_hibern8 error\n");
>  
> -	ufshcd_writel(hba, UFS_HCLKDIV_NORMAL_VALUE, UFS_REG_HCLKDIV);
> +	if (!(host->caps & UFS_HISI_CAP_PHY10nm))
> +		ufshcd_writel(hba, UFS_HCLKDIV_NORMAL_VALUE, UFS_REG_HCLKDIV);
>  
>  	/* disable auto H8 */
>  	reg = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
> @@ -253,7 +274,7 @@ static int ufs_hisi_link_startup_post_change(struct ufs_hba *hba)
>  	return 0;
>  }
>  
> -static int ufs_hi3660_link_startup_notify(struct ufs_hba *hba,
> +static int ufs_hisi_link_startup_notify(struct ufs_hba *hba,
>  					  enum ufs_notify_change_status status)
>  {
>  	int err = 0;
> @@ -391,6 +412,28 @@ static void ufs_hisi_set_dev_cap(struct ufs_hisi_dev_params *hisi_param)
>  
>  static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
>  {
> +	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
> +
> +	if (host->caps & UFS_HISI_CAP_PHY10nm) {
> +		/*
> +		 * Boston platform need to set SaveConfigTime to 0x13,
> +		 * and change sync length to maximum value
> +		 */
> +		/* VS_DebugSaveConfigTime */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0xD0A0), 0x13);
> +		/* g1 sync length */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1552), 0x4f);
> +		/* g2 sync length */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1554), 0x4f);
> +		/* g3 sync length */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1556), 0x4f);
> +		/* PA_Hibern8Time */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x15a7), 0xA);
> +		/* PA_Tactivate */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x15a8), 0xA);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xd085, 0x0), 0x01);
> +	}
> +
>  	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME) {
>  		pr_info("ufs flash device must set VS_DebugSaveConfigTime 0x10\n");
>  		/* VS_DebugSaveConfigTime */
> @@ -429,7 +472,7 @@ static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
>  	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd046), 32767);
>  }
>  
> -static int ufs_hi3660_pwr_change_notify(struct ufs_hba *hba,
> +static int ufs_hisi_pwr_change_notify(struct ufs_hba *hba,
>  				       enum ufs_notify_change_status status,
>  				       struct ufs_pa_layer_attr *dev_max_params,
>  				       struct ufs_pa_layer_attr *dev_req_params)
> @@ -567,25 +610,72 @@ static int ufs_hi3660_init(struct ufs_hba *hba)
>  		return ret;
>  	}
>  
> -	ufs_hi3660_clk_init(hba);
> +	ufs_hisi_clk_init(hba);
> +
> +	ufs_hisi_soc_init(hba);
> +
> +	return 0;
> +}
> +
> +static int ufs_hi3670_init(struct ufs_hba *hba)
> +{
> +	int ret = 0;
> +	struct device *dev = hba->dev;
> +	struct ufs_hisi_host *host;
> +
> +	ret = ufs_hisi_init_common(hba);
> +	if (ret) {
> +		dev_err(dev, "%s: ufs common init fail\n", __func__);
> +		return ret;
> +	}
> +
> +	ufs_hisi_clk_init(hba);
> +
> +	ufs_hisi_soc_init(hba);
>  
> -	ufs_hi3660_soc_init(hba);
> +	/* Add cap for 10nm PHY variant on HI3670 SoC */
> +	host = ufshcd_get_variant(hba);
> +	host->caps |= UFS_HISI_CAP_PHY10nm;
>  
>  	return 0;
>  }
>  
> -static struct ufs_hba_variant_ops ufs_hba_hisi_vops = {
> +static struct ufs_hba_variant_ops ufs_hba_hi3660_vops = {
>  	.name = "hi3660",
>  	.init = ufs_hi3660_init,
> -	.link_startup_notify = ufs_hi3660_link_startup_notify,
> -	.pwr_change_notify = ufs_hi3660_pwr_change_notify,
> +	.link_startup_notify = ufs_hisi_link_startup_notify,
> +	.pwr_change_notify = ufs_hisi_pwr_change_notify,
>  	.suspend = ufs_hisi_suspend,
>  	.resume = ufs_hisi_resume,
>  };
>  
> +static struct ufs_hba_variant_ops ufs_hba_hi3670_vops = {
> +	.name = "hi3670",
> +	.init = ufs_hi3670_init,
> +	.link_startup_notify = ufs_hisi_link_startup_notify,
> +	.pwr_change_notify = ufs_hisi_pwr_change_notify,
> +	.suspend = ufs_hisi_suspend,
> +	.resume = ufs_hisi_resume,
> +};
> +
> +static const struct of_device_id ufs_hisi_of_match[] = {
> +	{ .compatible = "hisilicon,hi3660-ufs", .data = &ufs_hba_hi3660_vops },
> +	{ .compatible = "hisilicon,hi3670-ufs", .data = &ufs_hba_hi3670_vops },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, ufs_hisi_of_match);
> +
>  static int ufs_hisi_probe(struct platform_device *pdev)
>  {
> -	return ufshcd_pltfrm_init(pdev, &ufs_hba_hisi_vops);
> +	const struct of_device_id *of_id;
> +	struct ufs_hba_variant_ops *vops;
> +	struct device *dev = &pdev->dev;
> +
> +	of_id = of_match_node(ufs_hisi_of_match, dev->of_node);
> +	vops = (struct ufs_hba_variant_ops *)of_id->data;
> +
> +	return ufshcd_pltfrm_init(pdev, vops);
>  }
>  
>  static int ufs_hisi_remove(struct platform_device *pdev)
> @@ -596,13 +686,6 @@ static int ufs_hisi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id ufs_hisi_of_match[] = {
> -	{ .compatible = "hisilicon,hi3660-ufs" },
> -	{},
> -};
> -
> -MODULE_DEVICE_TABLE(of, ufs_hisi_of_match);
> -
>  static const struct dev_pm_ops ufs_hisi_pm_ops = {
>  	.suspend	= ufshcd_pltfrm_suspend,
>  	.resume		= ufshcd_pltfrm_resume,
> diff --git a/drivers/scsi/ufs/ufs-hisi.h b/drivers/scsi/ufs/ufs-hisi.h
> index 3df9cd7acc29..667dfe39b57e 100644
> --- a/drivers/scsi/ufs/ufs-hisi.h
> +++ b/drivers/scsi/ufs/ufs-hisi.h
> @@ -91,6 +91,9 @@ enum {
>  #define UFS_HISI_LIMIT_HS_RATE	PA_HS_MODE_B
>  #define UFS_HISI_LIMIT_DESIRED_MODE	FAST
>  
> +#define UFS_HISI_CAP_RESERVED		BIT(0)
> +#define UFS_HISI_CAP_PHY10nm		BIT(1)
> +
>  struct ufs_hisi_host {
>  	struct ufs_hba *hba;
>  	void __iomem *ufs_sys_ctrl;
> @@ -112,4 +115,5 @@ struct ufs_hisi_host {
>  	ufs_sys_ctrl_writel((host),                                            \
>  			    ((~(mask)) & (ufs_sys_ctrl_readl((host), (reg)))), \
>  			    (reg))
> +
>  #endif /* UFS_HISI_H_ */
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
