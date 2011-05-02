From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 2 May 2011 22:51:54 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <4DBF164C.7030900@bluewatersys.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110502153852.GI1212@game.jcrosoft.org>
	<4DBF1342.6070406@bluewatersys.com>
	<20110502202449.GB13724@game.jcrosoft.org>
	<4DBF164C.7030900@bluewatersys.com>
Message-ID: <20110502205154.GC13724@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08:38 Tue 03 May     , Ryan Mallon wrote:
> On 05/03/2011 08:24 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>> So I don't see how you can "detect" the CPU without first knowing
> >>>> which CPU and therefore where the DBGU register is anyway.
> >>>> And probing different addresses for a value is not an acceptable solution.
> >>> we have 2 different register 0xfffff200 and 0xffffee00
> >>> which are the DBGU or the PIOA
> >>>
> >>> and on the PIOA at the offset 0x40 if you try to read the cpu will always
> >>> return 0x0, and have no effect on the soc
> >>>
> >>> so I do not think there is a big issue to read 2 register to detect the soc
> >>> automatically
> >>
> >> This does rely on Atmel not making another soc which has the DBGU at an
> >> address which does cause a conflict (low possibility, but would be very
> >> annoying). It's also really ugly to read random registers until we get
> >> the one we want.
> >>
> >> However, I still do not see what is wrong with the current approach of
> >> the boards explicitly specifying the soc type. The correct soc/cpu type
> >> can already be determined without changing the code. So why are we
> >> changing the code?
> > Because some hardware design architecture such as CPU module do allow to have
> > the SAME board with different SOC. So have one machine ID per combinaison because
> > we just change the soc is a non-sense.
> 
> You haven't named such a piece of hardware yet. We have boards like our
> own Snapper 9260/9G20 where the same mach-type is used for two boards,
> one with a SAM9260 and the other with a SAM9G20. Because these are
> variants of the same soc we know that the DBGU is at the same address on
> both and so we can read the cpuid registers to determine which board it is.
take a look on the Ronetix
http://www.ronetix.at/

and this is just one the example
> 
> Can you give me an example of a mach-type which is used for two or more
> boards that cannot be differentiated this way?
today we can not do so, so people multiplicate the machine ID which is wrong
and please do not only see the Snapper there is much more hardware provider

This is more and more common as when you design the cpu module you will use a
4 or 6 layers pcb and for the main board just 2 layers

This allow you the reduce the cost and be more flexible

Best Regards,
J.
