From: davem@davemloft.net (David Miller)
Date: Wed, 01 Jun 2016 16:18:05 -0700 (PDT)
Subject: [PATCH v2 5/7] net:mdio-mux: Add MDIO mux driver for iProc SoCs
In-Reply-To: <1464701801-17243-6-git-send-email-pramod.kumar@broadcom.com>
References: <1464701801-17243-1-git-send-email-pramod.kumar@broadcom.com>
 <1464701801-17243-6-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160601.161805.1142999841225463527.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pramod Kumar <pramod.kumar@broadcom.com>
Date: Tue, 31 May 2016 19:06:39 +0530

> +static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
> +{
> +	u32 val;
> +	unsigned int timeout = 1000; /* loop for 1s */

Please order your local variable declarations from longest to shortest line.

> +static int start_miim_ops(void __iomem *base,
> +			  u16 phyid, u32 reg, u16 val, u32 op)
> +{
> +	int ret;
> +	u32 param;

Likewise.

> +static int iproc_mdiomux_read(struct mii_bus *bus, int phyid, int reg)
> +{
> +	int ret;
> +	struct iproc_mdiomux_desc *md = bus->priv;

Likewise.
