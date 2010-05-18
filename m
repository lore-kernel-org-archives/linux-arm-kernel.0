From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 18 May 2010 13:24:43 +0800
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1005172341200.12758@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
Message-ID: <201005181324.45701.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> I think that, for the moment, it is best if the bootloader on already 
> existing subarchitectures where DT is introduced still preserve the 
> already existing ability to boot using ATAGs.  This allows for the 
> testing and validation of the DT concept against the legacy ATAG method 
> more easily.

Just to clarify - by "still preserve the existing ability to use ATAGs" you 
mean only for non-DT boot, right? This proposal still does not require 
ATAG_DEVTREE?

> Why one DT machine ID per subarchitecture?  Simply because a significant
> part of the DT handling code will have to be subarchitecture specific
> anyway.  The timer hardware, the GPIO configuration and muxing, SOC
> specific platform data handling, power management config, and many other
> things are simply too different from one SOC family to another and
> trying to have a single global DT support code to rule them all is
> insane.

The code for DT boot will be still subarch-specific, but I don't think we need 
IDs for that. There is enough information in the device tree to select the 
subarch-specific code to use for early init, without needing to parameterise 
every element of the machine. The machine-level "compatible" property allows 
us to do this.

Therefore, I don't think we need the machine ID at all: once the DT is 
available, we can use that for any machine-specific stuff. Even though we're 
not *configuring* it from the device tree, we can *select* it from there 
instead.

Cheers,


Jeremy
