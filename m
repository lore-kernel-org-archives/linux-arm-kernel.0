From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jun 2012 12:17:46 +0100
Subject: [PATCH 06/17] i2c: omap: improve 1p153 errata handling
In-Reply-To: <1339669250-9183-7-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-7-git-send-email-balbi@ti.com>
Message-ID: <20120614111746.GB31187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:20:39PM +0300, Felipe Balbi wrote:
> -static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
> +static int errata_omap3_1p153(struct omap_i2c_dev *dev)
>  {
> -	unsigned long timeout = 10000;
> +	unsigned long	timeout = 10000;
> +	u16		stat;

Eww, no, not more of this "lets add tabs to align auto variable
declarations".  This is detrimental when you add another variable whose
type is longer than the current indentation - you have to reformat the
entire block.

It's really not worth it.  Stick to just using one space, like the rest
of the kernel code.  Like the code which Linus writes.  And thereby help
to avoid future "pointless churn" whinges.
