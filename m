From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 31 Oct 2014 17:16:58 +0000
Subject: [PATCH 3/3] arm64: Add Juno SoC device tree.
In-Reply-To: <20141031162918.GG32139@lunn.ch>
References: <1414771460-7340-1-git-send-email-Liviu.Dudau@arm.com>
 <1414771460-7340-4-git-send-email-Liviu.Dudau@arm.com>
 <20141031162918.GG32139@lunn.ch>
Message-ID: <20141031171658.GK1069@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 04:29:18PM +0000, Andrew Lunn wrote:
> On Fri, Oct 31, 2014 at 04:04:20PM +0000, Liviu Dudau wrote:
> > This adds support for USB, 100MB Ethernet port, timers, I2C,
> > and watchdog timer. Missing for now are the SMMU nodes, HDLCD
> > and PCIe.
> 
> Hi Liviu

Hi Andrew,

> 
> I know nothing about Juno, but i do help maintain the Marvell SoC
> device tree files.
> 
> It seems pretty normal to split device tree descriptions into a
> generic .dtsi SoC part and a number of .dts board files, one per
> board, and including the SoC .dtsi file.

Agree.

> 
> Is it likely another board will be designed using the same SoC?

There is at least one revision of the SoC happening, but hopefully
it should be compatible with the current DT. ARM usually creates
CoreTiles for the CPUs and uses the VExpress motherboard as the
"expansion board" sort of setup.

Juno is new in this area in that is an 'all-in-one' board. I don't
think we will ever see another board with the Juno chip because
ARM doesn't sell chips, but there might be future ARM boards that
will share features with Juno, so refactoring will be necessary.
Unfortunately, I don't have any insights into the future so I
cannot properly prepare for such case, hence the one file submission.

Best regards,
Liviu

> 
>    Andrew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
