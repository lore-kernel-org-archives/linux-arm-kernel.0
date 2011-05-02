From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 3 May 2011 01:16:30 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110502231638.GG28001@n2100.arm.linux.org.uk>
References: <4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110502153852.GI1212@game.jcrosoft.org>
	<4DBF1342.6070406@bluewatersys.com>
	<20110502202449.GB13724@game.jcrosoft.org>
	<4DBF164C.7030900@bluewatersys.com>
	<20110502205154.GC13724@game.jcrosoft.org>
	<4DBF21B0.5060202@bluewatersys.com>
	<20110502231638.GG28001@n2100.arm.linux.org.uk>
Message-ID: <20110502231630.GD32605@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:16 Tue 03 May     , Russell King - ARM Linux wrote:
> On Tue, May 03, 2011 at 09:27:12AM +1200, Ryan Mallon wrote:
> > Russell, what is your opinion on this? Should we use individual
> > mach-types for the above boards and have them explicitly specify their
> > cpu/soc type, or should we be aiming to have a single mach-type for all
> > of them and determine the cpu/soc type in code?
> 
> I don't like answering these questions because it requires understanding
> the differences between the various individual SoCs to determine what's
> possible.
> 
> You are correct that CPU type is determined at run-time by the kernel,
> and whether its an 920T or 926T CPU is neither here or there to the
> kernel.  It's really the SoC type that's the problem, and we don't have
> a very good way of specifying that (partly as there is no standard way
> to tell what sort of SoC we have.)
> 
> So, really, it's a platform specific question.  If there is some way
> that the SoC type can be detected from the hardware, that may be an
> appropriate way to deal with that issue.  If not, then the mach-type
> approach (which I assume is what AT91 currently does) is probably as
> good as any other until we have something like DT.
Except we have Russell it's we need to read 2 registers differents

which is 0x0 if does not containt a cpu id
or or the cpu id of the current chip

So I do not see the big deal

Best Regards,
J.
