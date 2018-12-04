Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8706CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:12:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5764A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="szsMeyji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5764A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lhDmkTJWRGMengZZB5luzygbkeLr43ACvX80Kgm/9Ps=; b=szsMeyji+HNeOE
	MbZs6QPjMw/1vOlenPFW3e/M0fv9khrnaRcPlxUtOXYNHHw/vqPPFnaFxuMmcncz+GGgvA+43VubR
	bWZ/z5H4KZdw0WCTGxhpL5Xx6dXXJwQ3OEi4uO9kNuEPaHoMov35Lnf52OiZXWN0d2urIVDLHsRYx
	mJVG267juy7fpT9IeBASupF5FYbhtGokz8KQtjsM5xJTi1CkuUZkg8mj9axQ8p/VaD6qmzl34SVne
	yewfNlyPS2Mth8B9tSjIH3jB0hT8tScdRr7wH3I8+Ig4q1CGXOe2LndkU3FFd15B7C4c9o7MKO4ji
	MywaxAx+cNQApclrgHBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCNV-0001GM-Q2; Tue, 04 Dec 2018 15:12:49 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCNQ-0001Bn-Ry
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:12:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D42C80D;
 Tue,  4 Dec 2018 07:12:34 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18F763F614;
 Tue,  4 Dec 2018 07:12:31 -0800 (PST)
Date: Tue, 4 Dec 2018 15:12:27 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v4 2/2] PCI: uniphier: Add UniPhier PCIe host controller
 support
Message-ID: <20181204151227.GA29926@e107981-ln.cambridge.arm.com>
References: <1543377866-16634-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1543377866-16634-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543377866-16634-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_071244_911949_C8AE2226 
X-CRM114-Status: GOOD (  16.32  )
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
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Rob Herring <robh+dt@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 01:04:26PM +0900, Kunihiko Hayashi wrote:

[...]

> +static void uniphier_pcie_irq_ack(struct irq_data *d)
> +{
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	u32 val;
> +
> +	val = readl(priv->base + PCL_RCV_INTX);
> +	val &= ~PCL_RCV_INTX_ALL_STATUS;
> +	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
> +	writel(val, priv->base + PCL_RCV_INTX);
> +}
> +
> +static void uniphier_pcie_irq_mask(struct irq_data *d)
> +{
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	u32 val;
> +
> +	val = readl(priv->base + PCL_RCV_INTX);
> +	val &= ~PCL_RCV_INTX_ALL_STATUS;
> +	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
> +	writel(val, priv->base + PCL_RCV_INTX);
> +}
> +
> +static void uniphier_pcie_irq_unmask(struct irq_data *d)
> +{
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	u32 val;
> +
> +	val = readl(priv->base + PCL_RCV_INTX);
> +	val &= ~PCL_RCV_INTX_ALL_STATUS;

I have noticed this operation is carried out on ACK/MASK/UNMASK,
what's its purpose ?

Lorenzo

> +	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
> +	writel(val, priv->base + PCL_RCV_INTX);
> +}
> +
> +static struct irq_chip uniphier_pcie_irq_chip = {
> +	.name = "PCI",
> +	.irq_ack = uniphier_pcie_irq_ack,
> +	.irq_mask = uniphier_pcie_irq_mask,
> +	.irq_unmask = uniphier_pcie_irq_unmask,
> +};
> +
> +static int uniphier_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				  irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &uniphier_pcie_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops uniphier_intx_domain_ops = {
> +	.map = uniphier_pcie_intx_map,
> +};
> +
> +static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> +{
> +	struct pcie_port *pp = irq_desc_get_handler_data(desc);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long reg;
> +	u32 val, bit, virq;
> +
> +	/* INT for debug */
> +	val = readl(priv->base + PCL_RCV_INT);
> +
> +	if (val & PCL_CFG_BW_MGT_STATUS)
> +		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
> +	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
> +		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> +	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> +		dev_dbg(pci->dev, "Root Error\n");
> +	if (val & PCL_CFG_PME_MSI_STATUS)
> +		dev_dbg(pci->dev, "PME Interrupt\n");
> +
> +	writel(val, priv->base + PCL_RCV_INT);
> +
> +	/* INTx */
> +	chained_irq_enter(chip, desc);
> +
> +	val = readl(priv->base + PCL_RCV_INTX);
> +	reg = FIELD_GET(PCL_RCV_INTX_ALL_STATUS, val);
> +
> +	for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
> +		virq = irq_linear_revmap(priv->legacy_irq_domain, bit);
> +		generic_handle_irq(virq);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	struct device_node *np = pci->dev->of_node;
> +	struct device_node *np_intc;
> +
> +	np_intc = of_get_child_by_name(np, "legacy-interrupt-controller");
> +	if (!np_intc) {
> +		dev_err(pci->dev, "Failed to get legacy-interrupt-controller node\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->irq = irq_of_parse_and_map(np_intc, 0);
> +	if (!pp->irq) {
> +		dev_err(pci->dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
> +						&uniphier_intx_domain_ops, pp);
> +	if (!priv->legacy_irq_domain) {
> +		dev_err(pci->dev, "Failed to get INTx domain\n");
> +		return -ENODEV;
> +	}
> +
> +	irq_set_chained_handler_and_data(pp->irq, uniphier_pcie_irq_handler,
> +					 pp);
> +
> +	return 0;
> +}
> +
> +static int uniphier_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	int ret;
> +
> +	ret = uniphier_pcie_config_legacy_irq(pp);
> +	if (ret)
> +		return ret;
> +
> +	uniphier_pcie_irq_enable(priv);
> +
> +	dw_pcie_setup_rc(pp);
> +	ret = uniphier_pcie_establish_link(pci);
> +	if (ret)
> +		return ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
> +	.host_init = uniphier_pcie_host_init,
> +};
> +
> +static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> +				  struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &priv->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pp->ops = &uniphier_pcie_host_ops;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq < 0)
> +			return pp->msi_irq;
> +	}
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(priv->rst);
> +	if (ret)
> +		goto out_clk_disable;
> +
> +	uniphier_pcie_init_rc(priv);
> +
> +	ret = phy_init(priv->phy);
> +	if (ret)
> +		goto out_rst_assert;
> +
> +	ret = uniphier_pcie_wait_rc(priv);
> +	if (ret)
> +		goto out_phy_exit;
> +
> +	return 0;
> +
> +out_phy_exit:
> +	phy_exit(priv->phy);
> +out_rst_assert:
> +	reset_control_assert(priv->rst);
> +out_clk_disable:
> +	clk_disable_unprepare(priv->clk);
> +
> +	return ret;
> +}
> +
> +static void uniphier_pcie_host_disable(struct uniphier_pcie_priv *priv)
> +{
> +	uniphier_pcie_irq_disable(priv);
> +	phy_exit(priv->phy);
> +	reset_control_assert(priv->rst);
> +	clk_disable_unprepare(priv->clk);
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = uniphier_pcie_establish_link,
> +	.stop_link = uniphier_pcie_stop_link,
> +	.link_up = uniphier_pcie_link_up,
> +};
> +
> +static int uniphier_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_pcie_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pci.dev = dev;
> +	priv->pci.ops = &dw_pcie_ops;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	priv->pci.dbi_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(priv->pci.dbi_base))
> +		return PTR_ERR(priv->pci.dbi_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
> +	priv->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->rst = devm_reset_control_get_shared(dev, NULL);
> +	if (IS_ERR(priv->rst))
> +		return PTR_ERR(priv->rst);
> +
> +	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
> +	if (IS_ERR(priv->phy))
> +		return PTR_ERR(priv->phy);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = uniphier_pcie_host_enable(priv);
> +	if (ret)
> +		return ret;
> +
> +	return uniphier_add_pcie_port(priv, pdev);
> +}
> +
> +static int uniphier_pcie_remove(struct platform_device *pdev)
> +{
> +	struct uniphier_pcie_priv *priv = platform_get_drvdata(pdev);
> +
> +	uniphier_pcie_host_disable(priv);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id uniphier_pcie_match[] = {
> +	{ .compatible = "socionext,uniphier-pcie", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_pcie_match);
> +
> +static struct platform_driver uniphier_pcie_driver = {
> +	.probe  = uniphier_pcie_probe,
> +	.remove = uniphier_pcie_remove,
> +	.driver = {
> +		.name = "uniphier-pcie",
> +		.of_match_table = uniphier_pcie_match,
> +	},
> +};
> +builtin_platform_driver(uniphier_pcie_driver);
> +
> +MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
> +MODULE_DESCRIPTION("UniPhier PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
