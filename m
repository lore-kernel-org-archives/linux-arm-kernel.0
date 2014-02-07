From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Feb 2014 09:33:13 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1391730137-14814-22-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
Message-ID: <20140207093313.1a979a8f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri,  7 Feb 2014 00:42:17 +0100, Andrew Lunn wrote:
> Now that all the device tree support is in mach-mvebu, remove it from
> mach-kirkwood.
> 
> Regenerate kirkwood_defconfig, removing all DT support, and a couple
> of other redundent options have been removed in the process.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/kirkwood_defconfig |   6 -

So after this series we have a mvebu_defconfig that only builds the
ARMv7 platforms of mach-mvebu. I believe this may look strange to
people looking at the code, seeing that Kirkwood DT support is in
mach-mvebu, but that mvebu_defconfig doesn't work to build a Kirkwood
kernel.

I don't really have a solution, except maybe having mvebu_v7_defconfig
and mvebu_v5_defconfig to build only the Marvell v7 and Marvell v5
platforms.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
