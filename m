From: marex@denx.de (Marek Vasut)
Date: Tue, 2 Apr 2013 02:02:43 +0200
Subject: [PATCH 2/5] spi/mxs: Fix chip select control bits in DMA mode
In-Reply-To: <CA+7tXij_V1iAdPuPoTQ6CK6U5Y-iJprCPsTj=_LHAV1-=CL7gA@mail.gmail.com>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
 <201304020130.51951.marex@denx.de>
 <CA+7tXij_V1iAdPuPoTQ6CK6U5Y-iJprCPsTj=_LHAV1-=CL7gA@mail.gmail.com>
Message-ID: <201304020202.43501.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> On Mon, Apr 1, 2013 at 4:30 PM, Marek Vasut <marex@denx.de> wrote:
> >> >> -static uint32_t mxs_spi_cs_to_reg(unsigned cs)
> >> >> +static u32 mxs_spi_cs_to_reg(unsigned cs)
> >> >> 
> >> >>  {
> >> >> 
> >> >> -     uint32_t select = 0;
> >> >> +     u32 select = 0;
> >> 
> >> I'll make it a separate patch.
> > 
> > This is completely irrelevant change, please just submit the relevant
> > patches.
> 
> Kernel code should use u16, u32, etc. instead of the uint16_t,
> uint32_t types.  The rest of the driver uses them.  Why should this
> one function use a different type than the rest?  It's ugly and
> inconsistent.

Is this documented somewhere please? I see only a mention about this in chapter 
5 of Documentation/CodingStyle , section (d) . Either way, separate such 
cosmetic change into another series so they're not in the way of relevant stuff.

> And really, it's just as relevant as insisting that multiline patches
> use some exact format, which checkpatch.pl doesn't complain about.

The checkpatch is not almighty tool, Documentation/CodingStyle describes how 
code should be written/annotated/documented.

Best regards,
Marek Vasut
