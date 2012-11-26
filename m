From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Nov 2012 10:25:35 +0100
Subject: [PATCH] arm: mvebu: support for the PlatHome OpenBlocks AX3 board
In-Reply-To: <CAODfWeFY3ZN1U0dDLyLUc=0BpUMQH7LDfcAFbi--Y73qhfRXaQ@mail.gmail.com>
References: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121024150614.GD11837@lunn.ch> <20121024172050.412ff1bf@skate>
 <CAODfWeFY3ZN1U0dDLyLUc=0BpUMQH7LDfcAFbi--Y73qhfRXaQ@mail.gmail.com>
Message-ID: <20121126102535.6a5da505@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Hector Oron,

On Mon, 26 Nov 2012 10:18:47 +0100, Hector Oron wrote:

> I got an ax3/2 device, I would not mind to test any changes? Are you
> aware of which changes should I apply to dtsi file to work on ax3-2
> device?

If I'm correct, the differences between AX-2 and AX3-4 is:

 * AX3-2 has two Ethernet interfaces, while AX3-4 has four Ethernet
   interfaces

 * AX3-4 is in standard mounted with a 2 GB additional DRAM in a
   SO-DIMM slot, while the AX3-2 is not. However, it is not clear if
   the SO-DIMM slot is present or not on the AX3-2 (could you confirm
   this?).

 * AX3-2 does not have a mini PCIe slot, while AX3-4 has one.

So I guess you could create a separate armada-xp-openblocks-ax3-2.dts
file to support this new board. Maybe at some point it will make sense
to have a common armada-xp-openblocks-ax3.dtsi that both board .dts
includes.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
