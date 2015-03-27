From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Mar 2015 13:20:03 +0100
Subject: at91 clocks
In-Reply-To: <55152F3E.60004@microbit.se>
References: <55117568.6090202@microbit.se> <20150325013201.3f01fc22@bbrezillon>
 <55127AA6.5050902@microbit.se> <20150325173751.0d6479df@bbrezillon>
 <5513D701.2080201@microbit.se> <20150326162827.041c051a@bbrezillon>
 <55152F3E.60004@microbit.se>
Message-ID: <20150327132003.6caf3689@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

On Fri, 27 Mar 2015 11:21:50 +0100
Jonas Andersson <jonas@microbit.se> wrote:

> Hi Boris,
> 
> On 2015-03-26 16:28, Boris Brezillon wrote:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> I am working on a system with at91sam9260 soc. Trying to move from
> >>>>>> kernel 3.17.4 to 3.19.2. I have problem with pck1 clock.
> >>>>>>
> >>>>>> In my old code i use clk_get() to get pck1 and pllb, set pllb as parent
> >>>>>> for pck1, set rate for pck1, enable pck1.
> >>>>> How do you do that (clk_set_parent + clk_set_rate) ?
> >>>>> Could you paste your code somewhere ?
> >>>> Yes, see http://pastie.org/10052161
> > Could you paste the new version of your code (the one with clk_set_rate
> > on pllb) ?
> Added this at http://pastie.org/10057041

Seems good.

> >>> Your pllb seems to be configured to output a 0Hz rate, and I'm not
> >>> forwarding rate change to prog clk parents yet.
> >>> That's definitely something I should work on, but in the meantime you
> >>> could try to manually set pllb rate.
> >> I tried to set pllb rate to 96MHz but it still shows 0Hz. |clk_set_rate
> >> returns 0|.
> > Have you tested pllb pointer value ? As you can see here [1], the CCF
> > is not complaining when you pass a NULL pointer.
> 
> I tested with IS_ERR, changed this to IS_ERR_OR_NULL, but the pointer is ok.

Can you print clk_get_rate(parent_clk) result ?

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
