Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6867C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA29F20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eO8N5ZDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA29F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DA0WllCmN4v3XDgQCiwTW7Ti595D+DE0jB1mtMGFjeg=; b=eO8N5ZDTnl1Wqa
	T6fb7JtFXQVKekGZtXKztsQGNpxqKFWjpW7XF1O/V8ZQy+TOoa79YB3dA3fG5DhodMm6I9y+CPn3W
	e39IrHEsaWGejAz945zDg97k/WDnGTRFY4A20Lx0Tuw6jFM19rJT/oC2XI/urV+34TauoS5kMPL4I
	DRGxn6hGoojSuATG7BHrekiebAZiV3BtmvqeSmxIBMbdodIFpwX1bcrF2GnWc5XFMbdEoR304VylU
	mMtWvmF5NOWu/Wp1WlG5osamh1kNLS7AyV2xyK0vJxcCShmwHoqggZ3esVixhW3MUlgSQeCerPN0R
	MGpsKPGKL04rs6sQfmtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwUZc-0007Hl-PH; Wed, 20 Feb 2019 16:18:16 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwUZZ-0007HK-Pa
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 16:18:15 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id EC7AB80E1;
 Wed, 20 Feb 2019 16:18:22 +0000 (UTC)
Date: Wed, 20 Feb 2019 08:18:09 -0800
From: Tony Lindgren <tony@atomide.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Message-ID: <20190220161809.GR15711@atomide.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
 <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_081813_863896_205DCB86 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* Grygorii Strashko <grygorii.strashko@ti.com> [190220 15:26]:
> Deprecate cpsw-phy-sel driver as it's been replaced with new
> TI phy-gmii-sel PHY driver.

I'm not going to pick up this one, seems that Dave can merge
this later on? That is unless Dave wants to ack this one.

Regards,

Tony

> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig | 6 +++---
>  drivers/net/ethernet/ti/cpsw.h  | 6 ++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index bb126be1eb72..8b21b40a9fe5 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -49,10 +49,11 @@ config TI_DAVINCI_CPDMA
>  	  will be called davinci_cpdma.  This is recommended.
>  
>  config TI_CPSW_PHY_SEL
> -	bool
> +	bool "TI CPSW Phy mode Selection (DEPRECATED)"
> +	default n
>  	---help---
>  	  This driver supports configuring of the phy mode connected to
> -	  the CPSW.
> +	  the CPSW. DEPRECATED: use PHY_TI_GMII_SEL.
>  
>  config TI_CPSW_ALE
>  	tristate "TI CPSW ALE Support"
> @@ -64,7 +65,6 @@ config TI_CPSW
>  	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
>  	select TI_DAVINCI_CPDMA
>  	select TI_DAVINCI_MDIO
> -	select TI_CPSW_PHY_SEL
>  	select TI_CPSW_ALE
>  	select MFD_SYSCON
>  	select REGMAP
> diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
> index cf111db3dc27..907e05fc22e4 100644
> --- a/drivers/net/ethernet/ti/cpsw.h
> +++ b/drivers/net/ethernet/ti/cpsw.h
> @@ -21,7 +21,13 @@
>  			 ((mac)[2] << 16) | ((mac)[3] << 24))
>  #define mac_lo(mac)	(((mac)[4] << 0) | ((mac)[5] << 8))
>  
> +#if IS_ENABLED(CONFIG_TI_CPSW_PHY_SEL)
>  void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
> +#else
> +static inline
> +void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
> +{}
> +#endif
>  int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr);
>  
>  #endif /* __CPSW_H__ */
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
