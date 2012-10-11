From: mporter@ti.com (Matt Porter)
Date: Thu, 11 Oct 2012 17:49:30 -0400
Subject: [RFC PATCH v2 00/16] DMA Engine support for AM33xx
In-Reply-To: <CACxGe6vL2ieaYN_YhZn9=e7=prwdfwZtgPr4Ei3VMNnViib6XA@mail.gmail.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
 <CACxGe6vL2ieaYN_YhZn9=e7=prwdfwZtgPr4Ei3VMNnViib6XA@mail.gmail.com>
Message-ID: <20121011214930.GF13724@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 10:31:58PM +0100, Grant Likely wrote:
> Hey Matt,
> 
> Do you know now similar are the EDMA engines on the am33xx and am389x? I've
> been working on am389x upstreaming and I'll try these patches out if it is
> the same engine.

Hi Grant,

It's the same one. am389x/ti816x and am387x/ti814x are part of the same
architectural family as am33xx. They've just never had a lot of upstream
support from TI. I heard rumors that you might be working with am389x
and I'm glad you're confirming that for me! ;)

The only differences between am33xx's implementation and the others is
going to be the number PaRAM slots, number of TCs, the channel mapping,
and then the crossbar mapping. As you can see from the TODO list, I
don't yet support the crossbar, but it'll be in the next version of this
series. The other items are already covered in the DT binding so it
should be straightforward to hook this up for am389x assuming your hwmod
and clock data is good for that part.

-Matt
