From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 9 Jan 2013 05:31:45 +0000
Subject: [RFC v2 03/18] memory: emif: Move EMIF related header file to
 include/linux/
In-Reply-To: <50EC2779.8030507@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-4-git-send-email-vaibhav.bedia@ti.com>
 <50EC2779.8030507@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD020@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 19:34:41, Shilimkar, Santosh wrote:
[...]
> >
> >   drivers/memory/emif.c   |    2 +-
> >   drivers/memory/emif.h   |  589 -----------------------------------------------
> >   include/linux/ti_emif.h |  589 +++++++++++++++++++++++++++++++++++++++++++++++
> You are just moving the file. So "git mv file1 flie2; and the git 
> format-patch -C"
> on committed patch should just generate few lines of patch.
> 

Ok. Didn't know about this.

> > +/* DDR_PHY_CTRL_1 - EMIF4D5 */
> > +#define DLL_HALF_DELAY_SHIFT_4D5			21
> > +#define DLL_HALF_DELAY_MASK_4D5				(1 << 21)
> > +#define READ_LATENCY_SHIFT_4D5				0
> > +#define READ_LATENCY_MASK_4D5				(0x1f << 0)
> > +
> > +/* DDR_PHY_CTRL_1_SHDW */
> > +#define DDR_PHY_CTRL_1_SHDW_SHIFT			5
> > +#define DDR_PHY_CTRL_1_SHDW_MASK			(0x7ffffff << 5)
> > +#define READ_LATENCY_SHDW_SHIFT				0
> > +#define READ_LATENCY_SHDW_MASK				(0x1f << 0)
> > +
> > +#ifndef __ASSEMBLY__
> > +/*
> > + * Structure containing shadow of important registers in EMIF
> > + * The calculation function fills in this structure to be later used for
> > + * initialisation and DVFS
> > + */
> > +struct emif_regs {
> Are you using above struct. If not we can leave it in same place and
> just move the register defines.
> 

No, the struct is not used. I'll leave it here in the next version.

Regards,
Vaibhav
