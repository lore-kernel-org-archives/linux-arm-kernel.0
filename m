Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07273C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:28:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C7B2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tcnrUFBX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1RGs6CXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C7B2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vGLwSPtaCWrYlA2rDuI6iONZCcDg9oXDksjNbU7AVoU=; b=tcnrUFBXuETj+i
	tdhhqgD1exukCHNVCpjlEriVlxLeUrEIdCGE5mqMkOulVrW4P6mmBhZh+kjDocD6TbF7IYCcc3WY0
	m5VS9Tv1qRSNjKA7j+Wvw14N2FCUDIDdvUAe3AbbV9oW469nxYCcToWO4UeRErCBvqgA7Qq1QVJrf
	Fe2KMt5J8i2EIwiR1C+XZdTHOnojh/5e2Fpc2IYYFp5RNgqC19Pn6jZFv/jZoFcPzpFTfmFhRaD4G
	W3vYL1ZgNbKqG+oqn1Si5G3WBCcZrn0clqyQtKCjvTFEwSNJQVRMGVod+48Rz8D4gflf2HDuYvYra
	jitJpy6w+w+0DoWcAMiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geVKT-0003Al-CB; Wed, 02 Jan 2019 01:28:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geVKO-0003AG-68
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 01:28:14 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D03C42171F;
 Wed,  2 Jan 2019 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546392491;
 bh=hjrUtNXCE4m20teCOVhOxvQ3bn9KxyuOFTRLDwbwEDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1RGs6CXj2CIrNcJ6qzohel+sWH3k61Xg7ierw69ZZz+aheurP4lorSh0tiHH64j/g
 7kuLE+LAKW/sn57ay7ve3yWBitHDI9geR2yesE2TfNYjkD1dKn+R/MLBjtoK/zD3eW
 TbheBijN1yVfanTY4QdTtgsTIX6vQZDDku4oE/5M=
Date: Tue, 1 Jan 2019 19:28:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [v6] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Message-ID: <20190102012809.GB126384@google.com>
References: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_172812_262416_A9AAA971 
X-CRM114-Status: GOOD (  22.40  )
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
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "TheSven73@googlemail.com" <TheSven73@googlemail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 04:33:38AM +0000, Richard Zhu wrote:
> The MSI Enable bit in the MSI Capability (PCIe r4.0, sec 7.7.1.2)
> controls whether a Function can request service using MSI.
> 
> i.MX6 Root Ports implement the MSI Capability and may use MSI to
> request service for events like PME, hotplug, AER, etc.  In
> addition, on i.MX6, the MSI Enable bit controls delivery of MSI
> interrupts from components below the Root Port.
> 
> Prior to commit f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection
> of CONFIG_PCIEPORTBUS"), enabling CONFIG_PCI_IMX6 automatically also
> enabled CONFIG_PCIEPORTBUS, and when portdrv claimed the Root Ports,
> it set the MSI Enable bit so it could use PME, hotplug, AER, etc.
> As a side effect, that also enabled delivery of MSI interrupts from
> downstream components.
> 
> After f3fdfc4ac3a2, the imx6q-pcie driver can operate without
> portdrv, but that means imx6q-pcie must set the MSI Enable bit
> itself if downstream components use MSI.
> 
> Fixes: f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of CONFIG_PCIEPORTBUS")
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Applied with Trent's tested-by to pci/imx6 for v4.21.

> ---
> Changes v1 -> v2:
> * Assert the MSI_EN unconditionally when MSI is supported.
> Changes v2 -> v3:
> * Remove the IS_ENABLED(CONFIG_PCI_MSI) since the driver depends on
> PCI_MSI_IRQ_DOMAIN
> * Extended with a check for pci_msi_enabled() to see if the user
> explicitly want legacy IRQs
> Changes v3 -> v4:
> * Refer to Bjorn's comments, refine the subject and commit log and change
> the PCI_MSI_CAP to PCIE_RC_IMX6_MSI_CAP.
> Changes v4 -> v5:
> * Correct one spell mistake from PCIE_RC_MSI_IMX6_CAP to
> PCIE_RC_IMX6_MSI_CAP.
> Changes v5 -> v6:
> * Update with Bjorn's commit.
> * One "commit" added in "Prior to f3fdfc4ac3a2" refer to the complain of
> checkpatch.pl.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e563ca9..73542dd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,6 +82,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> +#define PCIE_RC_IMX6_MSI_CAP			0x50
>  #define PCIE_RC_LCR				0x7c
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
> @@ -999,6 +1000,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> +	u16 val;
>  
>  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>  	if (!imx6_pcie)
> @@ -1149,6 +1151,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (pci_msi_enabled()) {
> +		val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +				PCI_MSI_FLAGS);
> +		val |= PCI_MSI_FLAGS_ENABLE;
> +		dw_pcie_writew_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +				PCI_MSI_FLAGS, val);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
