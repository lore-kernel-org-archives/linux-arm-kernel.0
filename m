From: joe@perches.com (Joe Perches)
Date: Thu, 21 Sep 2017 13:17:52 -0700
Subject: [PATCH V5 1/4] soc: brcmstb: Add Product ID and Family ID
 helper functions
In-Reply-To: <CAGh=XAAzjvSpHK_oaj2OwTswdtCpfKUhg-nL+M_4jM92yMTs=A@mail.gmail.com>
References: <1503683495-11766-1-git-send-email-alcooperx@gmail.com>
 <1503683495-11766-2-git-send-email-alcooperx@gmail.com>
 <3aefb1ca-827d-6ebf-03c6-1f0d41e5da5c@gmail.com>
 <0deddef3-fc3e-67be-12e8-9fbd84f24314@ti.com>
 <CAGh=XAAzjvSpHK_oaj2OwTswdtCpfKUhg-nL+M_4jM92yMTs=A@mail.gmail.com>
Message-ID: <1506025072.12311.29.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-21 at 15:16 -0400, Al Cooper wrote:
> Kishon,
> 
> I ran checkpatch on all my patches before submitting them and didn't
> get any warnings. It looks like you may be running checkpatch with the
> "--subjective" option. Is this a requirement and if so are there any
> other checkpatch options I should be using?
> 
> Thanks
> Al
> 
> On Thu, Sep 21, 2017 at 4:54 AM, 'Kishon Vijay Abraham I' via
> BCM-KERNEL-FEEDBACK-LIST,PDL
> <bcm-kernel-feedback-list.pdl@broadcom.com> wrote:
> > Hi,
> > 
> > On Saturday 02 September 2017 07:45 AM, Florian Fainelli wrote:
> > > On 08/25/2017 10:51 AM, Al Cooper wrote:
[]
> > I get the following checkpatch warning
> > CHECK: Macro argument reuse 'reg' - possible side-effects?
> > #110: FILE: include/linux/soc/brcmstb/brcmstb.h:4:
> > +#define BRCM_ID(reg)   ((u32)reg >> 28 ? (u32)reg >> 16 : (u32)reg >> 8)
[]
> > > > diff --git a/include/linux/soc/brcmstb/brcmstb.h b/include/linux/soc/brcmstb/brcmstb.h
> > > > index 337ce41..23e4dc9 100644
> > > > --- a/include/linux/soc/brcmstb/brcmstb.h
> > > > +++ b/include/linux/soc/brcmstb/brcmstb.h
> > > > @@ -1,10 +1,20 @@
> > > >  #ifndef __BRCMSTB_SOC_H
> > > >  #define __BRCMSTB_SOC_H
> > > > 
> > > > +#define BRCM_ID(reg)        ((u32)reg >> 28 ? (u32)reg >> 16 : (u32)reg >> 8)
> > > > +#define BRCM_REV(reg)       ((u32)reg & 0xff)

These should be (reg) to avoid a possible issue with
cast precedence or
maybe a use a statement expression
macro with a temporary to avoid the
reuse message.
