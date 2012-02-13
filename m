From: Hong.Xu@atmel.com (Xu, Hong)
Date: Mon, 13 Feb 2012 10:15:34 +0800
Subject: [PATCH V3] MTD: atmel_nand: Update driver to support Programmable
 HW ECC controller
In-Reply-To: <1328959692.22240.103.camel@sauron.fi.intel.com>
References: <1328491977-30448-1-git-send-email-hong.xu@atmel.com>
 <1328959692.22240.103.camel@sauron.fi.intel.com>
Message-ID: <4C79549CB6F772498162A641D92D5328045B52C6@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,
> -----Original Message-----
> From: Artem Bityutskiy [mailto:dedekind1 at gmail.com]
> Sent: Saturday, February 11, 2012 7:28 PM
> To: Xu, Hong; linux-arm-kernel
> Cc: linux-mtd at lists.infradead.org; ivan.djelic at parrot.com;
> dwmw2 at infradead.org
> Subject: Re: [PATCH V3] MTD: atmel_nand: Update driver to support
Programmable
> HW ECC controller
> 
> On Mon, 2012-02-06 at 09:32 +0800, Hong Xu wrote:
> > +static int16_t *pmecc_get_index_of(struct atmel_nand_host *host)
> > +{
> > +       int16_t *p = (int16_t *)host->rom_base;
> 
> I did not really get into details, but you annotate rom_base with
> __iomem, and then you have to cast it to int16_t in several - this
does
> not look very nice.
> 
OK, this line shall be removed actually, thanks.
The logic here is, we want to use one lookup table which sits in ROM.
ROM region is mapped into kernel space by ioremap and the VA is saved in
rom_base. The function pmecc_get_index_of and pmecc_get_alpha_to are
used to return the correct ROM offset according to SoC and PMECC
configurations.
The lookup table is of type int16.

> Could you please CC the arm list? There are much more people who can
> give this code a review.
> 

OK, I'll resend the patch and CC the arm list.

Thanks and Br,
Eric
> --
> Best Regards,
> Artem Bityutskiy
