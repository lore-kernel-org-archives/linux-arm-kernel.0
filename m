From: hong.xu@atmel.com (Hong Xu)
Date: Tue, 13 Dec 2011 09:58:56 +0800
Subject: [PATCH 1/2] MTD: atmel_nand: Update Kconfig to support PMECC
In-Reply-To: <4EE6A6DF.4@atmel.com>
References: <1323327219-17895-1-git-send-email-hong.xu@atmel.com>
 <1323723514.2297.8.camel@koala> <4EE6A6DF.4@atmel.com>
Message-ID: <4EE6B160.3000201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

On 12/13/2011 09:14 AM, Hong Xu wrote:
> Hi David,

Sorry, this shall be Artem :-)

>
> On 12/13/2011 04:58 AM, Artem Bityutskiy wrote:
>  > On Thu, 2011-12-08 at 14:53 +0800, Hong Xu wrote:
>  > > +config MTD_NAND_ATMEL_PMECC_HW
>  > > + bool "Programmable Hardware ECC (BCH code)"
>  > > + depends on ARCH_AT91SAM9X5 || ARCH_AT91SAM9N12
>  > > + help
>  > > + Use Programmable Hardware ECC (PMECC) controller.
>  > > +
>  > > + The PMECC Controller is a programmable binary BCH (Bose, Chaudhuri
>  > > + and Hocquenghem) encoder/decoder. This controller can be used to
>  > > + generate redundancy information for both SLC and MLC NAND Flash
>  > > + devices.
>  > > +
>  > > + NB : hardware and software ECC schemes are incompatible.
>  > > + If you switch from one to another, you'll have to erase your
>  > > + mtd partition.
>  >
>  > Does it have to be a config option, can we avoid adding config options
>  > uless we really have to?
>
> Agree. The original MTD_NAND_ATMEL_ECC_HW can be reused. In driver, if
> the SoC has PMECC, it'll be used.

PMECC is not compatible with the old HW ECC engine. It currently needs 
around 700 lines of C code to make it work. If we do not have a way to 
exclude the PMECC related code at compiling time, my quick testing shows 
that the driver code size will be doubled if some old SoCs do not 
support it. This sounds not good. What's your opinion?

Thanks.

BR,
Eric

> Thanks.
>
> BR,
> Eric
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>
