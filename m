From: Hong.Xu@atmel.com (Xu, Hong)
Date: Tue, 14 Feb 2012 09:10:29 +0800
Subject: [PATCH] MTD: atmel_nand: Update driver to support Programmable HW
 ECC controller
In-Reply-To: <1329134891.22240.116.camel@sauron.fi.intel.com>
References: <1329117469-23637-1-git-send-email-hong.xu@atmel.com>
 <1329134891.22240.116.camel@sauron.fi.intel.com>
Message-ID: <4C79549CB6F772498162A641D92D5328045B5ADE@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Artem,

> -----Original Message-----
> From: Artem Bityutskiy [mailto:dedekind1 at gmail.com]
> Sent: Monday, February 13, 2012 8:08 PM
> To: Xu, Hong
> Cc: linux-mtd at lists.infradead.org; dwmw2 at infradead.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] MTD: atmel_nand: Update driver to support
Programmable
> HW ECC controller
> 
> On Mon, 2012-02-13 at 15:17 +0800, Hong Xu wrote:
> > The Programmable Hardware ECC (PMECC) controller is a programmable
binary
> > BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This
controller
> > can be used to support both SLC and MLC NAND Flash devices. It
supports to
> > generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector
of data.
> >
> > To use this driver, the user needs to pass in the correction
capability and
> > the sector size.
> >
> > This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with
JFFS2,
> > YAFFS2, UBIFS and mtd-utils.
> >
> > Signed-off-by: Hong Xu <hong.xu@atmel.com>
> 
> Please, do not forget to fix the following warnings as well:
> 
> Sparse:
> +drivers/mtd/nand/atmel_nand.c:1446:52: warning: Using plain integer
as NULL
> pointer [sparse]
> 
> gcc:
> +drivers/mtd/nand/atmel_nand.c: In function 'atmel_nand_probe':
> +drivers/mtd/nand/atmel_nand.c:1451:1: warning: label 'err' defined
but not
> used [-Wunused-label]
> 

OK, I'll also check with `sparse' as well. Thanks.

BR,
Eric

> --
> Best Regards,
> Artem Bityutskiy
