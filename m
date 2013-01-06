From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 6 Jan 2013 14:18:05 +0100
Subject: machine_is_dt() ?
Message-ID: <20130106131805.GQ17242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks

I'm moving the cpuidle code for Kirkwood into drivers/cpuidle. I'm
following the way cpuidle-calxeda.c instantiates the driver, it uses
module_init(calxeda_cpuidle_init) and calxeda_cpuidle_init() uses
of_machine_is_compatible("calxeda,highbank") so only loading the
driver in a ARCH_MULTIPLATFORM kernel when needed.

I can follow this model for when kirkwood is booted using device
tree. However, i would also like to use the driver for those boards
which are not yet converted to DT. In that situation, we have a kernel
dedicate to kirkwood and the cpuidle driver is always relevant.

Thus i need to code something like:

(of_machine_is_compatible("marvell, kirkwood") ||
 !machine_is_dt())

However, there is no macro machine_is_dt().

Is there a way to tell if a machine has been booted using a machine
number as opposed to DT?

Thanks
       Andrew



     
