From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Mar 2016 14:51:31 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318131432.GB8005@lunn.ch>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
Message-ID: <20160318145131.76ffa0e1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 18 Mar 2016 14:14:32 +0100, Andrew Lunn wrote:

> Isn't this also applicable to mvebu v5?
> 
> And your change to multi_v7_defconfig could also be applied to
> multi_v5_defconfig.

mvebu_v5 already enables a crypto driver, but it's the old one. So
there's a decision to be taken here whether we move all the platforms
to use the new driver or not.

The new driver has been tested on the Armada family, and I believe also
on Kirkwood. However I'm pretty sure it hasn't been tested on Dove and
Orion.

Dove is ARMv7 and enabled in mvebu_v7_defconfig, but since neither the
old nor the new driver were enabled in mvebu_v7_defconfig, we are not
going to disrupt any existing user here by adding the new driver in the
defconfig.

Changing mvebu_v5_defconfig, multi_v5_defconfig, orion5x_defconfig and
dove_defconfig however implies moving those defconfigs away from the
old driver, and select the new one instead. A more serious change, IMO.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
