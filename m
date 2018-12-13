Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E594C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:41:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E16B20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dOKyCQxz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaFSsTx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E16B20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XedAhWwza4LBRf7RXFHOsOzVdsWs6m7pGerVhcFJRAs=; b=dOKyCQxz42wB8h
	huY8Ws/voK9mZn7gzkgRAt7YWtQF88PRrYnzZhGhy8z5C3PubTfMKoGpf+I+aRHW0oJ8z1LvkAtaC
	nXtMCG8W/IFUnbfHspzp/33WKeqw/AMt2yEQNIWzriIGgFUWU15tyGQTHNo3BNtm9M/YDQX5udLjo
	5g+Oxz0voUFHdbTDpqpQHS8ZDdSkWYRFzTGds7XMKMi4J45h8VQkfKL2pxCB7EyxeEPC6wUMYFyB6
	TycHI5Z3ZfDHjrHroAAzqOH0gfLsQShsMiZtyYl9gBEaKnzX68xzd0qBQ8pe0EtmqnBcMBgDkv4gm
	hRDefjsicZwYzNcA/4sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSB8-00030E-MM; Thu, 13 Dec 2018 14:41:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSB5-0002z2-Q4
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 14:41:29 +0000
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E8CEC20849;
 Thu, 13 Dec 2018 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544712077;
 bh=2Y9dcSxEbm7++2W57FJQNCnpbdFgMI2E2n6HsLTa0SI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NaFSsTx73EVZhzLJ/ne6WrSUMZcjxwczulAfKDaeZmYYjxArXML9M+aH2Ue2QDFLG
 RMI4KMUCgeCB1TmHC79pAecJ66fTRX0Y8YsWuNlv9lViSLnWGr1OcHO23HsptPJ5Ms
 7YxdgoPScJvi4EV6RYfnU6PxMMlifnGr6pihU0fU=
Date: Thu, 13 Dec 2018 08:41:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
Message-ID: <20181213144115.GA4701@google.com>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_064127_877310_97DD6BEA 
X-CRM114-Status: GOOD (  21.85  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 08:02:11AM +0000, Richard Zhu wrote:
> MSI_EN of iMX PCIe RC would be asserted when
> PCIEPORTBUS driver is selected.
> Thus, the MSI works fine on iMX PCIe before.
> Assert it unconditionally when MSI is supported.
> Otherwise, the MSI wouldn't be triggered although
> the EP is present and the MSIs are assigned.

This subject line and changelog need some rework.  I can't understand
what's going on at all.  Lorenzo or I can help craft something, but I
don't understand enough to propose anything yet.

"MSI_EN" doesn't appear in the driver; I assume it's some
device-specific signal.

"iMX" does not look like the typical spelling.  You could use "imx6"
to refer to the driver, but in this case you're talking about the
hardware itself, not the driver.  So you should use "i.MX6" or
whatever the appropriate brand is.

If "PCIEPORTBUS driver is selected" means "CONFIG_PCIEPORTBUS=y", say
that.  The connection of portdrv (which is generic PCIe support) to
MSI_EN (which is apparently device-specific) is unclear.  It would be
helpful if you could connect those dots a little more.

"MSI works fine on iMX PCIe before."  Before what?  Is this a
regression, where MSI worked before some commit and this patch fixes
it?

Please rewrap the changelog so it uses the entire 80-column width.
Wrap to 75 so it still fits when "git log" adds the 4 char indent.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 26087b3..d3e4296 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -74,6 +74,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> +#define PCI_MSI_CAP				0x50

I wish this didn't look quite so much like a PCI core name, because
this is really an i.MX-specific offset.  It looks like the PCIE_RC_*
names are all similar i.MX-specific things.  Shouldn't this match
those?

>  #define PCIE_RC_LCR				0x7c
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
> @@ -926,6 +927,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> +	u16 val;
>  
>  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>  	if (!imx6_pcie)
> @@ -1070,6 +1072,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	ret = imx6_add_pcie_port(imx6_pcie, pdev);
>  	if (ret < 0)
>  		return ret;
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		val = dw_pcie_readw_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS);
> +		val |= PCI_MSI_FLAGS_ENABLE;
> +		dw_pcie_writew_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS, val);
> +	}
>  
>  	return 0;
>  }
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
