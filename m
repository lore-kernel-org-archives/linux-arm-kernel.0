From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 14:16:18 -0800
Subject: [PATCH 0/2] ARM: dts: OMAP3: Add GPMC controller and NAND
 memory to Overo
In-Reply-To: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130201221618.GB22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130128 09:57]:
> Hello,
> 
> This is more an RFC serie, as an issue is still unclear to me.
> Building on the work of Daniel Mack for the GPMC controller (staged
> in Tony's tree [1]), it was easy to add the GPMC controller to OMAP3.
> 
> The issue comes from the Overo on-board NAND, as the amount of flash
> depends on the revision. Currently, partitions are handled in the board
> file using MTDPART_SIZ_FULL, but looking at the ofpart parser, the size
> given to the parser must be fixed.
> 
> So how should we handle such case? Having several dtsi depending
> on the Overo's revision would be a mess to my sense, considering
> the non-conditional include inside the expansion boards' dts.
> Or would it make sense to extend the DT binding for partitions?

Yes makes sense to extend the binding to use the full flash memory
if the size can be probed.

Regards,

Tony
