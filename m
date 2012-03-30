From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 30 Mar 2012 09:19:13 -0400 (EDT)
Subject: [PATCH 0/4] memcpy optimized with strd/ldrd
In-Reply-To: <030501cd0e6a$03642770$0a2c7650$%kim@samsung.com>
References: <03e101cd0e07$eec39f10$cc4add30$@com>
 <030501cd0e6a$03642770$0a2c7650$%kim@samsung.com>
Message-ID: <alpine.LFD.2.02.1203300914510.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Mar 2012, Boojin Kim wrote:

> Nicolas Pitre wrote:
> >
> >
> > Here's my version.  Lightly tested.
> > I have no A15 hardware to run any performance comparison though.
> >
> I'm reviewing and testing your patch. But, My other work disturbs to reviewing it.
> I will give you feedback soon within this week.
> Wait a little more.
> And, Thanks for your patches. :)

FYI, it occurred to me that some corner cases might not be quite right 
with regards to alignment for the STRD instruction.  It seems that the 
hardware on which I tested it (Marvell Dove CPU) apparently copes with 
misaligned SDRD's when they're still 32-bit aligned.  So I need to run 
this code through a real validation harness on different hardware.


Nicolas
