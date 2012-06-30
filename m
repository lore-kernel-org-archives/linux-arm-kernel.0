From: stigge@antcom.de (Roland Stigge)
Date: Sat, 30 Jun 2012 14:32:16 +0200
Subject: [PATCH v10] MTD: LPC32xx MLC NAND driver
In-Reply-To: <1340973434.3070.168.camel@sauron.fi.intel.com>
References: <1340834129-15545-1-git-send-email-stigge@antcom.de>
 <1340973434.3070.168.camel@sauron.fi.intel.com>
Message-ID: <4FEEF1D0.5060404@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem!

Thanks for the notes!

On 29/06/12 14:37, Artem Bityutskiy wrote:
> Successfully built configuration
> "arm-lpc32xx_defconfig,arm,arm-unknown-linux-gnueabi-", results:
> 
> --- before_patching.log +++ after_patching.log @@ @@ 
> +drivers/mtd/nand/lpc32xx_mlc.c: In function 'lpc32xx_nand_probe': 
> +drivers/mtd/nand/lpc32xx_mlc.c:679:10: warning: variable 'sr' set
> but not used [-Wunused-but-set-variable] 
> +drivers/mtd/nand/lpc32xx_mlc.c:561:24: error: bad constant
> expression [sparse]

This is because sparse doesn't understand this local variable:

uint8_t buf[mtd->writesize];

(but gcc does).

Are you sure we need to support sparse?

The above construction is quite convenient for this case and I'd
prefer this to allocating another buffer dynamically.

Thanks in advance,

Roland
