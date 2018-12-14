Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E7C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:47:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D0C20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oYyAANxd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="ezQHveDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D0C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r1rXNxQLwI4XOSDZVMsOZ4fHSOzDKmoU5Qg7g3ek7ko=; b=oYyAANxdENFVKS
	b06p82jXSz9yXnxl7hcEWgepHvkdgD3E3HlTLWyqCZSnW/t2mlDaMzYewRD8cspLs83H+/RjlYDzE
	QEz2TJD8s1XlhSXimEQ7EJINssHHohHFuIHxWfvxPEj1NM/zEqpvJWEZkuglezduKn/26tTyxfP9J
	YekCQNspcALlXvAbs4Xyh0yYErPxtL1u7OktVm900701SgnytfFCjNpw8mgDgyt6k5/pJxFVZxoGa
	0RGjw3iS111egjr+9RAJeT+O9qpjkl/6GThD44kYE9UN4aaUhQuhYAsJQynuTp2viC9PRdOAe4R30
	tsaZky9j0itVr8L1AwAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXbdQ-0007lg-1i; Fri, 14 Dec 2018 00:47:20 +0000
Received: from mail.nic.cz ([217.31.204.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXbdL-0007kg-LN
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 00:47:17 +0000
Received: from localhost (unknown [172.20.6.233])
 by mail.nic.cz (Postfix) with ESMTPS id 0066562E08;
 Fri, 14 Dec 2018 01:47:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1544748423; bh=yb8lOHDan8M1Cc1yuiZy165cJcrcrl+OlXBrhkDw6NM=;
 h=Date:From:To;
 b=ezQHveDO/2JaruPu2IZmOOBViEQIEqRQifKaL2mEH1FSaUJVgfv16LhZ5dZn3U1hY
 Cif8AhpGHZVbXJn0OXhRuEh2R1UsDNYJ1mQ4fB56/FdmcUBiRdS0k6CAIZKBw3dnrW
 TP+EmhfRUeHnZtco9UKtPVlVvD15JYZybg0jjGp8=
Date: Fri, 14 Dec 2018 01:47:01 +0100
From: Marek Behun <marek.behun@nic.cz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181214014701.373b220b@nic.cz>
In-Reply-To: <20181212102142.16053-4-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_164716_018896_8849092C 
X-CRM114-Status: GOOD (  17.18  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

Hi Miquel,
are there already patches for the A37xx comphy driver?

On Wed, 12 Dec 2018 11:21:33 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The IP needs its PHY to be properly configured to work. While the PHY
> is usually already configured by the bootloader, we will need this
> feature when adding S2RAM support. Take care of registering and
> configuring the PHY from the driver itself.
> 
> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 62
> +++++++++++++++++++++++++++ 1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c
> b/drivers/pci/controller/pci-aardvark.c index
> 1d31d74ddab7..da695572a2ed 100644 ---
> a/drivers/pci/controller/pci-aardvark.c +++
> b/drivers/pci/controller/pci-aardvark.c @@ -17,6 +17,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
>  #include <linux/of_address.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
> @@ -204,6 +205,7 @@ struct advk_pcie {
>  	int root_bus_nr;
>  	struct pci_bridge_emul bridge;
>  	struct gpio_desc *reset_gpio;
> +	struct phy *phy;
>  };
>  
>  static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64
> reg) @@ -1025,6 +1027,62 @@ static int
> advk_pcie_setup_reset_gpio(struct advk_pcie *pcie) return 0;
>  }
>  
> +static void advk_pcie_disable_phy(struct advk_pcie *pcie)
> +{
> +	phy_power_off(pcie->phy);
> +	phy_exit(pcie->phy);
> +}
> +
> +static int advk_pcie_enable_phy(struct advk_pcie *pcie)
> +{
> +	int ret;
> +
> +	if (!pcie->phy)
> +		return 0;
> +
> +	ret = phy_init(pcie->phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
> +	if (ret) {
> +		phy_exit(pcie->phy);
> +		return ret;
> +	}
> +
> +	ret = phy_power_on(pcie->phy);
> +	if (ret) {
> +		phy_exit(pcie->phy);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int advk_pcie_setup_phy(struct advk_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	int ret = 0;
> +
> +	pcie->phy = devm_of_phy_get(dev, node, NULL);
> +	if (IS_ERR(pcie->phy) && (PTR_ERR(pcie->phy) ==
> -EPROBE_DEFER))
> +		return PTR_ERR(pcie->phy);
> +
> +	/* Old bindings miss the PHY handle */
> +	if (IS_ERR(pcie->phy)) {
> +		dev_warn(dev, "PHY unavailable (%ld)\n",
> PTR_ERR(pcie->phy));
> +		pcie->phy = NULL;
> +		return 0;
> +	}
> +
> +	ret = advk_pcie_enable_phy(pcie);
> +	if (ret)
> +		dev_err(dev, "Failed to initialize PHY (%d)\n", ret);
> +
> +	return ret;
> +}
> +
>  static int advk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1060,6 +1118,10 @@ static int advk_pcie_probe(struct
> platform_device *pdev) return ret;
>  	}
>  
> +	ret = advk_pcie_setup_phy(pcie);
> +	if (ret)
> +		return ret;
> +
>  	ret = advk_pcie_setup_reset_gpio(pcie);
>  	if (ret)
>  		return ret;


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
