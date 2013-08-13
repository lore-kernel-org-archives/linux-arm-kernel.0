From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 Aug 2013 11:42:48 -0700
Subject: [PATCH v1 09/14] clk: msm: Add support for MSM8960's global
 clock controller (GCC)
In-Reply-To: <20130813142411.4443.85003@quantum>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-10-git-send-email-sboyd@codeaurora.org>
 <20130808170015.GE27325@e106331-lin.cambridge.arm.com>
 <20130813050334.GE14845@codeaurora.org>
 <20130813142411.4443.85003@quantum>
Message-ID: <20130813184248.GG14845@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13, Mike Turquette wrote:
> Quoting Stephen Boyd (2013-08-12 22:03:34)
> > The clock controller is hardware and the number of clock outputs
> > is fixed. Isn't all hardware fixed until you start talking about
> > FPGAs? The next minor revision of the clock controller may add
> > more clocks or remove clocks from that base design, but otherwise
> > the two are 90% the same and generally software compatible. It
> > isn't until we start a new generation of chips that we make major
> > changes to the design. Is that loose enough to qualify?
> > 
> > These bindings attempt to follow the regulator bindings. With
> > regulators there is a node for each regulator and we describe
> > physical characteristics of those regulators within the nodes but
> > we don't describe the software interface (bits, masks, shifts,
> > etc). I imagine we could extend these clock nodes to describe
> > physical characteristics such as min/max frequency or if the
> > bootloader has left the clocks on. Right now we're using the
> > nodes to describe what types of clocks there are and how the
> > clock tree is layed out.
> > 
> > Or perhaps you're talking about clock sharing? We share the clock
> > controller with multiple masters (processors running other OSes)
> > and the partitioning of the clocks is mostly predefined. We just
> > won't use some clocks because they're reserved for other
> > processors. They're still part of the same clock controller
> > hardware block but we don't want to control them on Linux because
> > we'll trample over other processors and most likely hang the
> > system. I wonder how this would work for hexagon and krait both
> > running linux on the same SoC. If all DT says is that there is a
> > gcc here at this address how are we supposed to know that we
> > shouldn't use some clock? 
> 
> Do Krait and Hexagon have the same register map? On the ARM SoCs I am
> familiar with the masters have differing views of register addresses for
> the same peripherals and hardware blocks. So you couldn't use the same
> DTS in a straightforward way if this is true for your system.
> 

They both have the same view of the register map.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
