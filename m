From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Fri, 29 Jun 2012 09:56:39 -0300
Subject: [PATCH v10] MTD: LPC32xx MLC NAND driver
In-Reply-To: <1340973434.3070.168.camel@sauron.fi.intel.com>
References: <1340834129-15545-1-git-send-email-stigge@antcom.de>
 <1340973434.3070.168.camel@sauron.fi.intel.com>
Message-ID: <CAAAP30HZ1Z5U44wLwSEfcaJSLmVp8AbXPTCagS31hnoCy_tf-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 9:37 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Wed, 2012-06-27 at 23:55 +0200, Roland Stigge wrote:
>> This patch adds a driver for the MLC NAND controller of the LPC32xx SoC.
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
>> ---
>
> Aiaiai complains like this about your patch, please, take a look:
>
> --------------------------------------------------------------------------------
>
> Successfully built configuration "arm-lpc32xx_defconfig,arm,arm-unknown-linux-gnueabi-", results:
>
> --- before_patching.log
> +++ after_patching.log
> @@ @@
> +drivers/mtd/nand/lpc32xx_mlc.c: In function 'lpc32xx_nand_probe':
> +drivers/mtd/nand/lpc32xx_mlc.c:679:10: warning: variable 'sr' set but not used [-Wunused-but-set-variable]
> +drivers/mtd/nand/lpc32xx_mlc.c:561:24: error: bad constant expression [sparse]

This build fine here, with gcc 4.5.3

Which gcc version is he using?

> --------------------------------------------------------------------------------
>
> checkpatch.pl has some complaints:
>
> --------------------------------------------------------------------------------
>
> checkpatch.pl results for patch "[PATCH] MTD: LPC32xx MLC NAND driver"
>
> ERROR:INITIALISED_STATIC: do not initialise statics to 0 or NULL
> #339: FILE: drivers/mtd/nand/lpc32xx_mlc.c:224:
> +static int use_dma = 0;
>
> total: 1 errors, 0 warnings, 1004 lines checked
>
> --------------------------------------------------------------------------------
>
> --
> Best Regards,
> Artem Bityutskiy
