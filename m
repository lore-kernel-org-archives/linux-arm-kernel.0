From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 26 Mar 2015 16:28:27 +0100
Subject: at91 clocks
In-Reply-To: <5513D701.2080201@microbit.se>
References: <55117568.6090202@microbit.se> <20150325013201.3f01fc22@bbrezillon>
 <55127AA6.5050902@microbit.se> <20150325173751.0d6479df@bbrezillon>
 <5513D701.2080201@microbit.se>
Message-ID: <20150326162827.041c051a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

On Thu, 26 Mar 2015 10:53:05 +0100
Jonas Andersson <jonas@microbit.se> wrote:

> Hi Boris and others,
> 
> >>>> Hi all,
> >>>>
> >>>> I am working on a system with at91sam9260 soc. Trying to move from
> >>>> kernel 3.17.4 to 3.19.2. I have problem with pck1 clock.
> >>>>
> >>>> In my old code i use clk_get() to get pck1 and pllb, set pllb as parent
> >>>> for pck1, set rate for pck1, enable pck1.
> >>> How do you do that (clk_set_parent + clk_set_rate) ?
> >>> Could you paste your code somewhere ?
> >> Yes, see http://pastie.org/10052161

Could you paste the new version of your code (the one with clk_set_rate
on pllb) ?

> > Your pllb seems to be configured to output a 0Hz rate, and I'm not
> > forwarding rate change to prog clk parents yet.
> > That's definitely something I should work on, but in the meantime you
> > could try to manually set pllb rate.
> 
> I tried to set pllb rate to 96MHz but it still shows 0Hz. |clk_set_rate 
> returns 0|.

Have you tested pllb pointer value ? As you can see here [1], the CCF
is not complaining when you pass a NULL pointer.

> 
> >
> >> I tried kernel 4.0-rc5 but it hangs in boot after ethernet init. 
> > Is this related to the changes I suggested ?
> >
> No, it doesnt work before changes. I will try to get it running later, 
> direct from linus tree without modifications..

This might not be related to your clock problem then. Have your tried
to boot 4.0-rc4 ?

Best Regards,

Boris

[1]http://lxr.free-electrons.com/source/drivers/clk/clk.c#L1535

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
