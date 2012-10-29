From: zonque@gmail.com (Daniel Mack)
Date: Mon, 29 Oct 2012 12:15:23 +0100
Subject: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <508E3A0F.3040309@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com>
 <20121024232717.GD11928@atomide.com> <50887A6B.3050108@gmail.com>
 <508E3A0F.3040309@ti.com>
Message-ID: <508E654B.5010404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 29.10.2012 09:10, Afzal Mohammed wrote:
> On Thursday 25 October 2012 05:01 AM, Daniel Mack wrote:
> 
>> Thanks for the review. I'll wait for feedback from Afzal next week and
>> then repost. Wanted to see first if that goes in the right direction at
>> all before bordering the DT people with binding details :)
> 
> I was thinking of a generic approach, where there won't be
> any check for peripheral device type.
> 
> But going that path would delay achieving DT, may be let's
> proceed with your approach to start with so that we can
> have a minimal level of DT support for GPMC and probably
> we can make it generic later. While adding new properties,
> it would be better to keep in mind that we need not change
> these later once gpmc DT is made generic.
> 
> Regarding the bindings, there are some generic nand
> properties like ecc already available, may be that be made
> use here.

Ah, of_get_nand_ecc_mode() - nice.

> Also perhaps memory size (and offset if
> needed) to be mapped for peripherals can go with reg
> property of child.

Which detail are you referring to here? The only "size" property that is
effective is the one of the generic GPMC block, and there it's in the
"reg"-property.

I'll take the other feedback that I got and quickly do a v2.


Thanks,
Daniel
