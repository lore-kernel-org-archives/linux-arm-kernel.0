From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Jun 2014 13:46:38 +0100
Subject: [PATCH 1/2] spi/pxa2xx-pci: Add common clock framework support
 in PCI glue layer
In-Reply-To: <1401738379-4107-2-git-send-email-chiau.ee.chew@intel.com>
References: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
 <1401738379-4107-2-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140602124638.GD31751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 03:46:18AM +0800, Chew Chiau Ee wrote:

> ---
>  drivers/spi/spi-pxa2xx-pci.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)

> +	clk = clk_register_fixed_rate(&dev->dev, "spi_pxa2xx_clk", NULL,
> +					CLK_IS_ROOT, c->max_clk_rate);
> +	 if (IS_ERR(clk))
> +		return PTR_ERR(clk);

This is pretty much fine code wise but I'd expect to see some Kconfig
updates adding dependencies on the clock API - clk_register_fixed_rate()
is only provided if the fixed rate driver is present.  I'm also not
seeing any changes to unregister the fixed rate clock as the device is
removed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/bfcc481a/attachment.sig>
