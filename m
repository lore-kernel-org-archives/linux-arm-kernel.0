Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:27:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F422087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IXDyzcZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F422087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HNSMQpnK/ilpPV8jyirhEDoOX1fgDqMxJ1poRqXXou8=; b=IXDyzcZnlw2ZUE
	3pL7+tDVP7FMFQ6gDD55tf1aiPeHz0x+dGKIF0PadtBP/pjjwtz9YT3zj8BqWI7eZV7PMBFE1/HjZ
	vekl0q8rL4lKpVNCPyFeuY2yClj3gMolB2XPEv91fO/yBrhE/ul0gl7gjMzKGEmZ+klVlNZtzkMqm
	zg1ZGniYBnINNHXKRh8xwcuXxbzthaOkCpusTrjc2tasX/1O9K8lE5hF98q8S+d4WBtZOKy8NaKr/
	YLIiXALNmmzi8c+qlSBzo3suKGruCj9sZPPB7wmRocyV/MAGFdlifs7c60YAKeHfIidRCBLtulnZr
	s++S4YCr+yCiMXlTODdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlRs-0006kW-JL; Mon, 03 Dec 2018 10:27:32 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlRp-0006k5-It
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:27:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB4ED80D;
 Mon,  3 Dec 2018 02:27:16 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7CD23F59C;
 Mon,  3 Dec 2018 02:27:13 -0800 (PST)
Date: Mon, 3 Dec 2018 10:27:08 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, sudeep.holla@arm.com
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Message-ID: <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123141831.8214-6-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_022729_628798_97C981A7 
X-CRM114-Status: GOOD (  24.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+Rafael, Sudeep]

On Fri, Nov 23, 2018 at 03:18:24PM +0100, Miquel Raynal wrote:
> Add suspend and resume callbacks. The priority of these are
> "_noirq()", to workaround early access to the registers done by the
> PCI core through the ->read()/->write() callbacks at resume time.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 108b3f15c410..7ecf1ac4036b 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
>  	return ret;
>  }
>  
> +static int __maybe_unused advk_pcie_suspend(struct device *dev)
> +{
> +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> +
> +	advk_pcie_disable_phy(pcie);
> +
> +	clk_disable_unprepare(pcie->clk);

I have noticed it is common practice, still, I would like to check whether
it is allowed to call functions that may sleep in a NOIRQ suspend/resume
callback ?

Thanks,
Lorenzo

> +
> +	return 0;
> +}
> +
> +static int __maybe_unused advk_pcie_resume(struct device *dev)
> +{
> +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Empirical delay needed after enabling the clock and before
> +	 * accessing any register.
> +	 */
> +	msleep(10);
> +
> +	ret = advk_pcie_enable_phy(pcie);
> +	if (ret)
> +		return ret;
> +
> +	advk_pcie_hard_reset(pcie);
> +
> +	advk_pcie_setup_hw(pcie);
> +
> +	advk_sw_pci_bridge_init(pcie);
> +
> +	return 0;
> +}
> +
> +/*
> + * The PCI core will try to reconfigure the bus quite early in the resume path.
> + * We must use the _noirq() alternatives to ensure the controller is ready when
> + * the core uses the ->read()/->write() callbacks.
> + */
> +static const struct dev_pm_ops advk_pcie_dev_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(advk_pcie_suspend,
> +				      advk_pcie_resume)
> +};
> +
>  static int advk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1188,6 +1237,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	dev_set_drvdata(dev, pcie);
> +
>  	return 0;
>  }
>  
> @@ -1200,6 +1251,7 @@ static struct platform_driver advk_pcie_driver = {
>  	.driver = {
>  		.name = "advk-pcie",
>  		.of_match_table = advk_pcie_of_match_table,
> +		.pm = &advk_pcie_dev_pm_ops,
>  		/* Driver unloading/unbinding currently not supported */
>  		.suppress_bind_attrs = true,
>  	},
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
