From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 17:20:50 +0200
Subject: [PATCH] arm: mvebu: support for the PlatHome OpenBlocks AX3 board
In-Reply-To: <20121024150614.GD11837@lunn.ch>
References: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121024150614.GD11837@lunn.ch>
Message-ID: <20121024172050.412ff1bf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Wed, 24 Oct 2012 17:06:14 +0200, Andrew Lunn wrote:

> There are two variants of this box, ax3/2 and ax3/4. The ax3/4 can
> have more RAM and has a mini pci express slot. Do you expect both
> boards to be supported with one dts file?

I have the ax3/4 version apparently.

So, we can have the following possible schemes:

 + openblocks-ax3.dtsi
   + openblocks-ax3-2.dts
   + openblocks-ax3-4.dts

But I am not sure if using a .dtsi to factorize things common between
multiple boards is OK. Or we can do:

 + openblocks-ax3-2.dts
   + openblocks-ax3-4.dts

With openblocks-ax3-4.dts being the simple addition of PCIe slot + more
RAM. That said, I don't have the ax3/2 board anyway, so should we plan
for something that nobody can test at the moment, or wait for someone
to get a ax3/2 board, and therefore be able to do the testing? I think
I prefer to submit dts files that are know to work and have been tested
on hardware that we have.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
