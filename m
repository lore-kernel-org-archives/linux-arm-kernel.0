From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 10 Jul 2012 06:41:24 +0000
Subject: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
In-Reply-To: <CAMQu2gz0UU_RCFSvxo1s_XwDAmTtL4NadsFTg8qL7PtGwPqKtQ@mail.gmail.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B6C.7050003@ti.com>
 <CAMQu2gz0UU_RCFSvxo1s_XwDAmTtL4NadsFTg8qL7PtGwPqKtQ@mail.gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA695E6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 16:12:15, Shilimkar, Santosh wrote:
> On Mon, Jul 9, 2012 at 2:20 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >
> >
> > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
> >> From: R Sricharan <r.sricharan@ti.com>
> >>
> >> OMAP socs has a legacy and a highlander version of the
> >> 32k sync counter IP. The register offsets vary between the
> >> highlander and the legacy scheme. So use the 'SCHEME'
> >> bits(30-31) of the revision register to distinguish between
> >
> >
> > Just for my understanding, can we get further information on SCHEME
> > bit-fields? What kind of information we have it here.
> >
> > I may need this info to pass on to design team here.
> >
> Sure. You can refer to the OMAP4 TRM for the bit builds.
> SCHEME bit field tell you difference between a highlander
> and legacy IP as the patch says.
> 

Santosh,

Can you point to the section of OMAP4 TRM? 

I referred to both Public TRM and internal TRM, but both only did mention
"TI internal Data".

And as per code, we are not checking any value in 31-30 bit-fields, code 
just assumes that, non-zero value would be highlander IP. 

Thanks,
Vaibhav
