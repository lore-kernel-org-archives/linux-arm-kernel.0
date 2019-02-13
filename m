Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DB8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:13:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8037218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s9Il7QE+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QOARei3g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WpI0lke2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8037218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AJJDAUMwZDWtLia/fl8naWuCmHf0f5lLI9xtDixlcKo=; b=s9Il7QE+IijsoP
	7pbYjScktdhTQ0n24yAvmbQtIfpqSv3CKDTjifmZwU/9oUkzmcsA/ywxgs42T+NYauJrCZdj3UVU4
	lexnzDha/Ah7Qmg8G4BnUgiYcjz4MegEkSBykxZ72Uw46R1ZYeIzCoKauzEEXud9M/HbGxeWMAMPX
	L5HvXETXdGdHgW1JD8GE0MLmA0TGaAEKoBNw+BCP3A5oLHaxnNyarIoJQxMeR6G+HZ+c0pilNM0jf
	CAMmKaDjeLUH0hpgja8L/z75o2L5xwRh7zczFg5lRLaJQz8Kr2295uU64r18/7koXxjmx60u1tFb9
	7nvb9ZeLhjpo+9Q95iig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtz2S-0005oT-Nm; Wed, 13 Feb 2019 18:13:40 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz2Q-0005oJ-6d
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 18:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rO417quK3Qn8+Uw59Z6T+tNgZUbPT/W9xiWXHbGHtT4=; b=QOARei3gry2LD0Op6HdtUOln/
 v2TzAFapZvyhIxVfbpjG4mHYhXAkMBtUJzN5QxFrBY2aU0Dz78n7KCV12liWtJc7YDIcGkRtgo1Ss
 eSkjGBVKluEY/cWcR3AWV4ldMZ8iVBxFGNqt1ZxuJNfZqYarmaQiZV38Kzb3yLqSmwkKI/cifvnRH
 0W7YlwuI1Cjq5b7+uoPzp1aifcblSiXfuG02/oByMiraImZtTTkJeRyDKxmzkk7TXnPOiSJlvSD/y
 ETSmspEGPVylsZXdfUnb079yR9JAgMMDP2pCAQ2YsZA95UklDf+E5R5dnHoCPcD5iPwQSobiV2aHv
 zABa8BaYA==;
Received: from vps0.lunn.ch ([185.16.172.187])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz2N-0004HC-6N
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rO417quK3Qn8+Uw59Z6T+tNgZUbPT/W9xiWXHbGHtT4=; b=WpI0lke2YwH7r2j1Mm1uFMBc7w
 Fyh+CWSe10yTITTE10VaIqqLfWd1HcUzsSfbg1qZMEFbiGdkawlW5b8LRin1pFYj72GoUfXQQp9Rt
 y0tQegXGnghQigHtHyYqxTQP9QwuDIqdjb+snCcNZMdanXbuTQ5QGpYBybrstkamJs7o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gtz2B-0000iF-QX; Wed, 13 Feb 2019 19:13:23 +0100
Date: Wed, 13 Feb 2019 19:13:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: Re: [PATCH net-next 3/3] enetc: Add ENETC PF level external MDIO
 support
Message-ID: <20190213181323.GA708@lunn.ch>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
 <1550055743-15542-4-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550055743-15542-4-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_131335_349779_C105FEAA 
X-CRM114-Status: GOOD (  26.44  )
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
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 01:02:23PM +0200, Claudiu Manoil wrote:
> Each ENETC PF has its own MDIO interface, the corresponding
> MDIO registers are mapped in the ENETC's Port register block.
> The current patch adds a driver for these PF level MDIO buses,
> so that each PF can manage directly its own external link.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/Makefile     |   3 +-
>  drivers/net/ethernet/freescale/enetc/enetc_mdio.c | 196 ++++++++++++++++++++++
>  drivers/net/ethernet/freescale/enetc/enetc_pf.c   |  13 ++
>  drivers/net/ethernet/freescale/enetc/enetc_pf.h   |   6 +
>  4 files changed, 217 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index 6976602..7139e41 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
> -fsl-enetc-$(CONFIG_FSL_ENETC) += enetc.o enetc_cbdr.o enetc_ethtool.o
> +fsl-enetc-$(CONFIG_FSL_ENETC) += enetc.o enetc_cbdr.o enetc_ethtool.o \
> +				 enetc_mdio.o
>  fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
>  fsl-enetc-objs := enetc_pf.o $(fsl-enetc-y)
>  
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> new file mode 100644
> index 0000000..e71b4fd
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/* Copyright 2019 NXP */
> +
> +#include <linux/mdio.h>
> +#include <linux/of_mdio.h>
> +
> +#include "enetc_pf.h"
> +
> +struct enetc_mdio_regs {
> +	u32	mdio_cfg;	/* MDIO configuration and status */
> +	u32	mdio_ctl;	/* MDIO control */
> +	u32	mdio_data;	/* MDIO data */
> +	u32	mdio_addr;	/* MDIO address */
> +};
> +
> +#define bus_to_enetc_regs(bus)	(struct enetc_mdio_regs __iomem *)((bus)->priv)
> +
> +#define ENETC_MDIO_REG_OFFSET	0x1c00
> +#define ENETC_MDC_DIV		258
> +#define MDIO_CFG_CLKDIV(x)	((((x) >> 1) & 0xff) << 8)
> +#define MDIO_CFG_BSY		BIT(0)
> +#define MDIO_CFG_RD_ER		BIT(1)
> +#define MDIO_CFG_ENC		BIT(6)
> +#define MDIO_CFG_NEG		BIT(23)
> +#define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
> +#define MDIO_CTL_PORT_ADDR(x)	(((x) & 0x1f) << 5)
> +#define MDIO_CTL_READ		BIT(15)
> +#define MDIO_DATA(x)		((x) & 0xffff)
> +
> +#define TIMEOUT	1000
> +static int enetc_wait_complete(struct device *dev,
> +			       struct enetc_mdio_regs __iomem *regs)
> +{
> +	unsigned int timeout;
> +
> +	timeout = TIMEOUT;
> +	while ((enetc_rd_reg(&regs->mdio_cfg) & MDIO_CFG_BSY) && timeout) {
> +		cpu_relax();
> +		timeout--;
> +	}
> +
> +	if (!timeout) {
> +		dev_err(dev, "timeout waiting for bus to be free\n");
> +		return -ETIMEDOUT;
> +	}

Hi Claudiu

readx_poll_timeout()

> +
> +	return 0;
> +}
> +
> +static int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum,
> +			    u16 value)
> +{
> +	struct enetc_mdio_regs __iomem *regs = bus_to_enetc_regs(bus);
> +	u32 mdio_ctl, mdio_cfg;
> +	u16 dev_addr;
> +	int ret;
> +
> +	mdio_cfg = MDIO_CFG_CLKDIV(ENETC_MDC_DIV) | MDIO_CFG_NEG;

What does MDIO_CFG_NEG mean?

> +	if (regnum & MII_ADDR_C45) {
> +		/* clause 45 */

Does the comment add anything useful?

> +		dev_addr = (regnum >> 16) & 0x1f;
> +		mdio_cfg |= MDIO_CFG_ENC;

Maybe MDIO_CFG_ENC could be called MDIO_CFG_C45? Assuming that is what
it actually means?

> +int enetc_mdio_probe(struct enetc_pf *pf)
> +{
> +	struct device *dev = &pf->si->pdev->dev;
> +	struct enetc_mdio_regs __iomem *regs;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	bus = mdiobus_alloc_size(sizeof(regs));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "Freescale ENETC MDIO Bus";
> +	bus->read = enetc_mdio_read;
> +	bus->write = enetc_mdio_write;
> +	bus->parent = dev;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> +
> +	/* store the enetc mdio base address for this bus */
> +	regs = pf->si->hw.port + ENETC_MDIO_REG_OFFSET;
> +	bus->priv = regs;
> +
> +	ret = of_mdiobus_register(bus, dev->of_node);

It is a good idea to have an mdio node which contains the list of
PHYs. You can get into odd situations if you don't do that.

>  
> @@ -770,12 +771,23 @@ static int enetc_of_get_phy(struct enetc_ndev_priv *priv)
>  		priv->phy_node = of_node_get(np);
>  	}
>  
> +	if (!of_phy_is_fixed_link(np)) {
> +		err = enetc_mdio_probe(pf);
> +		if (err) {
> +			dev_err(priv->dev, "MDIO bus registration failed\n");

enetc_mdio_probe() already prints an error message. You don't really
need both.

     Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
