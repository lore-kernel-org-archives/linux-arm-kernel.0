From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 12:11:34 +0100
Subject: [PATCH 03/10] devicetree: bindings: add Device Tree bindings
 for Armada 39x pin-muxing controller
In-Reply-To: <20150206170521.GX25985@lunn.ch>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1423238276-9206-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150206170521.GX25985@lunn.ch>
Message-ID: <20150220121134.25cb865c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 6 Feb 2015 18:05:21 +0100, Andrew Lunn wrote:

> I wondering if there should be an explanation for the less common
> names here. I'm guessing dev is a device bus of some sort? What is
> xsmi? Some sort of extended System Management Interface? And m?

"dev" is the Device Bus indeed, used for example for NOR or NAND.

"m" stands for memory. The m(decc) signal is asserted when a memory ECC
error occurred, while the m(vtt) signal is the DRAM VTT Power Control
signal. No idea what this is.

"xsmi" is indeed some other SMI bus, not clear yet how it compares to
the regular SMI bus.

Both "dev" and "m" are already used by many of the existing pinctrl DT
bindings for Marvell platforms, so I'm not sure documenting them
specifically in the Armada 39x pinctrl DT binding document makes a lot
of sense. Where should we document them, then? In the generic
'marvell,mvebu-pinctrl.txt' DT binding file ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
