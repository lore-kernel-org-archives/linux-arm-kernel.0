Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9CEC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:39:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC2A20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PgMz635l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC2A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=abx8mM6AkAuiVXK8yBs1cxD4JGhrlUsnshclmFQ/Kgs=; b=PgMz635l8jLrzW
	zGTTXrF5UqnEeq8SwiUb4dygn0Q0TpeuTCwTzO8vaONs3TXUQA+IE1yS2u8icKhJBqKVuagEOCnZj
	N0Oxme7iRehF9921l48igsZmVZzeSTrnRVDhLs+oRkkH828ZzYSMvdMTLb90Pb8RqpNJNOkIAaly4
	+ssjUu5d2tYuvbfzI6Bi/o5/iz9JwRP+lSbDuIV/OEfnU97VTYNmskWoj6ASyMbQeY8URIoQtWbMJ
	P18zYlJBjaToFHPTr0XLpN2ynxq3fp2PJLhvUTJCJEaWe4lvHouB/N2/8rAbGzpDkvjfRihXNoTTG
	13cUzhdqyl3O9PRzU6hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXHqk-0004CV-Mw; Thu, 13 Dec 2018 03:39:46 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXHqg-0004BV-J7; Thu, 13 Dec 2018 03:39:45 +0000
X-UUID: c892295cf96d4f7fb7d669c2537ff3c8-20181213
X-UUID: c892295cf96d4f7fb7d669c2537ff3c8-20181213
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 629260881; Thu, 13 Dec 2018 11:39:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 11:39:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 11:39:16 +0800
Message-ID: <1544672356.26338.4.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
From: Ryder Lee <ryder.lee@mediatek.com>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Date: Thu, 13 Dec 2018 11:39:16 +0800
In-Reply-To: <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_193943_059160_6A2F87EF 
X-CRM114-Status: GOOD (  17.93  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Thu, 2018-12-06 at 09:09 +0800, Jianjun Wang wrote:
> MT7629 is an arm platform SoC which has the same PCIe IP with MT7622.
> 
> The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> in arm64 but bogus alignment values at arm32, the pcie device and devices
> behind this bridge will not be enabled. Fix it's BAR0 resource size to
> guarantee the pcie devices will be enabled correctly.
> 
> The HW default value of its device id is invalid, fix it's device id to
> match the hardware implementation.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 26 ++++++++++++++++++++++++++
>  include/linux/pci_ids.h                |  1 +
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index d20cf461ba00..f8937cc3c87c 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -73,6 +73,7 @@
>  #define PCIE_MSI_VECTOR		0x0c0
>  
>  #define PCIE_CONF_VEND_ID	0x100
> +#define PCIE_CONF_DEVICE_ID	0x102
>  #define PCIE_CONF_CLASS_ID	0x106
>  
>  #define PCIE_INT_MASK		0x420
> @@ -135,12 +136,14 @@ struct mtk_pcie_port;
>  /**
>   * struct mtk_pcie_soc - differentiate between host generations
>   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> + * @need_fix_device_id: whether this host's device ID needed to be fixed or not
>   * @ops: pointer to configuration access functions
>   * @startup: pointer to controller setting functions
>   * @setup_irq: pointer to initialize IRQ functions
>   */
>  struct mtk_pcie_soc {
>  	bool need_fix_class_id;
> +	bool need_fix_device_id;
>  	struct pci_ops *ops;
>  	int (*startup)(struct mtk_pcie_port *port);
>  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> @@ -692,6 +695,11 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		writew(val, port->base + PCIE_CONF_CLASS_ID);
>  	}
>  
> +	if (soc->need_fix_device_id) {
> +		val = PCI_DEVICE_ID_MEDIATEK_7629;

<just_checking>
  Could we have a generic way to fix it? It's better not to add SoC
specific settings in shared function.
</just_checking>

> +		writew(val, port->base + PCIE_CONF_DEVICE_ID);
> +	}
> +
>  	/* 100ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
>  				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> @@ -1238,11 +1246,29 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
>  	.setup_irq = mtk_pcie_setup_irq,
>  };
>  
> +static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
> +	.need_fix_class_id = true,
> +	.need_fix_device_id = true,
> +	.ops = &mtk_pcie_ops_v2,
> +	.startup = mtk_pcie_startup_port_v2,
> +	.setup_irq = mtk_pcie_setup_irq,
> +};
> +
> +static void mtk_fixup_bar_size(struct pci_dev *dev)
> +{
> +	struct resource *dev_res = &dev->resource[0];
> +	/* 32bit resource length will calculate size to 0, set it smaller */
> +	dev_res->end = 0xfffffffe;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MEDIATEK, PCI_DEVICE_ID_MEDIATEK_7629,
> +			 mtk_fixup_bar_size);
> +
>  static const struct of_device_id mtk_pcie_ids[] = {
>  	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
>  	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
>  	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
>  	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
> +	{ .compatible = "mediatek,mt7629-pcie", .data = &mtk_pcie_soc_mt7629 },
>  	{},
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 69f0abe1ba1a..77b278bac3a8 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2126,6 +2126,7 @@
>  #define PCI_VENDOR_ID_MYRICOM		0x14c1
>  
>  #define PCI_VENDOR_ID_MEDIATEK		0x14c3
> +#define PCI_DEVICE_ID_MEDIATEK_7629	0x7629
>  
>  #define PCI_VENDOR_ID_TITAN		0x14D2
>  #define PCI_DEVICE_ID_TITAN_010L	0x8001



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
