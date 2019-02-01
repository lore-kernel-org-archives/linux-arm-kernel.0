Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAE0C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C18D2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0KqSy8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C18D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oaNDJBCkV/wjunaT8iHT12O7/0q6f/tWPu+Q2zgdy2s=; b=K0KqSy8V1lAizb
	kG0DeuPVOM9MqZdPCVvIjDbAdX/licAT2oqcUml8ELcDWYSTg/VLnxzzvvtplT8XsYP9vKFZLyxV4
	QJ8KNWrpoUHHoyRsTqmm1BsTMLpXlPUnCtJ3cI7Vyy0gHuD32aKiRLfs2E9Vusdx2Q/Ig1XXoDsPu
	aV+JJnKEx5oZ2V04G1DCUCiX7Na8B1fWGYJqQtOJu1lDMf4IWQAsm/IfmTULPy3nBpGY8LKhDu35T
	TY7HUZgrtQ0RhMZJMfgY6wJF5XrC6M30MiHlYTws9XpggPvP4R7ma/a45Xka7zThjZcw+fkiJLE0a
	YHkJsZnwTHlKFrq0uA4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpcAc-0003aX-Ls; Fri, 01 Feb 2019 17:00:02 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpcAY-0003Zx-Nf
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 17:00:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3331B15BE;
 Fri,  1 Feb 2019 08:59:58 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFCEF3F71E;
 Fri,  1 Feb 2019 08:59:55 -0800 (PST)
Date: Fri, 1 Feb 2019 16:59:50 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v6 2/4] PCI: imx6: Mark PHY functions as i.MX6 specific
Message-ID: <20190201165950.GA22887@e107981-ln.cambridge.arm.com>
References: <20190124201522.8973-1-andrew.smirnov@gmail.com>
 <20190124201522.8973-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124201522.8973-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_085958_769253_2E03865C 
X-CRM114-Status: GOOD (  18.44  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Trent Piepho <tpiepho@impinj.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 12:15:20PM -0800, Andrey Smirnov wrote:
> PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
> so none of the code in current implementation of imx6_setup_phy_mpll()
> is applicable.

So :) ? Add a conclusive statement to the commit log.

Lorenzo

> Tested-by: Trent Piepho <tpiepho@impinj.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index efff3d5e9162..c55d93c1187d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -41,8 +41,11 @@ enum imx6_pcie_variants {
>  	IMX7D,
>  };
>  
> +#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> +
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
> +	u32 flags;
>  };
>  
>  struct imx6_pcie {
> @@ -256,6 +259,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	u32 tmp;
>  
> +	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> +		return;
> +
>  	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
>  	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
>  		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> @@ -573,6 +579,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
>  	int mult, div;
>  	u32 val;
>  
> +	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> +		return 0;
> +
>  	switch (phy_rate) {
>  	case 125000000:
>  		/*
> @@ -1088,12 +1097,15 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  static const struct imx6_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
