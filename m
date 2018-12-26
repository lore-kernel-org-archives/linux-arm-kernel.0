Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CEFC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:19:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E9E2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l5VplZD+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SRbPBtkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E9E2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ymk3Y5vAR1r7uW+qVUGK+ii7BTpvdtW/OGpmG/G3fDU=; b=l5VplZD+XgFeNL
	F+9OssKd2Phglpps6Ey/0H9Qlo2or0S5UadllpYOtvmDV/RU3V9fZyhWgRbkBPZoksEKvQdfblHnf
	zomHyj8wLHbuYpH6aUCWCC2wnw0Mejfn6K656rTDlCe1Ri0MmkJOczw2BWFPTU0NxUUXbPq67bS4F
	3GtHXnadGlHzScITG3qz0vFhLh8HtGNw3v0n0wm4NvulGTNJeYpnHQN2BOc1P05nJLmdYgOBqGsM7
	GEC4ipdkSnymJpH+89ab8O5P4BGdYHvtIOhHBdC0yVuTZAM4BM6MUlYHb4UOWRZO8LO3ppHaDxn6Q
	pxYYM2iPOGuHv5BCHhbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcAyJ-0000LD-QZ; Wed, 26 Dec 2018 15:19:47 +0000
Received: from smtprelay4.synopsys.com ([198.182.47.9]
 helo=smtprelay.synopsys.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcAyG-0000KB-LX
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 15:19:46 +0000
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
 by smtprelay.synopsys.com (Postfix) with ESMTP id 71D3324E25BD;
 Wed, 26 Dec 2018 07:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1545837572; bh=7bJtq6WlClTOgEY7fy1zvuHrsJ8CUhuisiP3TTvq/+M=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=SRbPBtkC3Z3nS7TICXEHiLd85s6l+TDsSetXFfo1HiwCoUBTr2ezU8xiwch6Wivdu
 62TZOte2PQH4GxI0nNxvrJF8Kum07PsBrylzbcfjZcNwW0Ug3LuBNUnNFhRfbPL3Y1
 D7ahbBTJE12viywm5RbI0TIT7ZjLCelyCLV3D2r+rmL6MoSjWYp/djjJikwm4BU7/h
 PLUgLh5y5E3FHfIerLGv8Ew/b6v1t6XGd5Zxeo0YnjAgqFS4WAQskAhllEglAfhfEK
 JitZMQSwozkpvSem1TM4kOgkCvFn0ATGCXxCMh3RJV0IPCpGrxRiRg8GDICagtAUVE
 Nuv1wHRPCeKlA==
Received: from US01WEHTC2.internal.synopsys.com
 (us01wehtc2.internal.synopsys.com [10.12.239.237])
 by mailhost.synopsys.com (Postfix) with ESMTP id E67D53577;
 Wed, 26 Dec 2018 07:19:31 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 07:19:31 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 16:19:29 +0100
Received: from [10.225.2.19] (10.225.2.19) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Wed, 26 Dec 2018 16:19:29 +0100
Subject: Re: [PATCH 11/21] PCI: designware: Make use of BIT() in constant
 definitions
To: Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-12-andrew.smirnov@gmail.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <86e8172d-d1dc-59d6-0b64-b11ce014b6a4@synopsys.com>
Date: Wed, 26 Dec 2018 15:14:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-12-andrew.smirnov@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.225.2.19]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_071944_712095_7E81B755 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 21/12/2018 07:27, Andrey Smirnov wrote:
> Avoid using explicit left shifts and convert various definitions to
> use BIT() instead. No functional change intended.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index d123ac290b9e..086e87a40316 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -300,7 +300,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  	}
>  
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);

This is unrelated with the patch description purpose.

>  }
>  
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 58735fd01668..348e91b6daa2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -40,11 +40,11 @@
>  #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
>  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
>  #define PCIE_PORT_DEBUG1		0x72C
> -#define PCIE_PORT_DEBUG1_LINK_UP		(0x1 << 4)
> -#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	(0x1 << 29)
> +#define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
> +#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
>  
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> -#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
> +#define PORT_LOGIC_SPEED_CHANGE		BIT(17)
>  #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
>  #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
>  #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
> @@ -58,8 +58,8 @@
>  #define PCIE_MSI_INTR0_STATUS		0x830
>  
>  #define PCIE_ATU_VIEWPORT		0x900
> -#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
> -#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
> +#define PCIE_ATU_REGION_INBOUND		BIT(31)
> +#define PCIE_ATU_REGION_OUTBOUND	0
>  #define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
>  #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
>  #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
> @@ -69,8 +69,8 @@
>  #define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
>  #define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
>  #define PCIE_ATU_CR2			0x908
> -#define PCIE_ATU_ENABLE			(0x1 << 31)
> -#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
> +#define PCIE_ATU_ENABLE			BIT(31)
> +#define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
>  #define PCIE_ATU_LOWER_BASE		0x90C
>  #define PCIE_ATU_UPPER_BASE		0x910
>  #define PCIE_ATU_LIMIT			0x914
> @@ -81,7 +81,7 @@
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
>  #define PCIE_MISC_CONTROL_1_OFF		0x8BC
> -#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
> +#define PCIE_DBI_RO_WR_EN		BIT(0)
>  
>  /*
>   * iATU Unroll-specific register definitions
> @@ -108,7 +108,7 @@
>  		((region) << 9)
>  
>  #define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
> -		(((region) << 9) | (0x1 << 8))
> +		(((region) << 9) | BIT(8))
>  
>  #define MAX_MSI_IRQS			256
>  #define MAX_MSI_IRQS_PER_CTRL		32
> 

Regards,

Gustavo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
