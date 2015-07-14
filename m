From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jul 2015 23:49:31 -0700
Subject: [PATCH v2] ARM: dts: configure regulators for Gumstix Pepper
In-Reply-To: <1436481477-18002-1-git-send-email-adam.yh.lee@gmail.com>
References: <1436481477-18002-1-git-send-email-adam.yh.lee@gmail.com>
Message-ID: <20150714064931.GC17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam YH Lee <adam.yh.lee@gmail.com> [150709 15:40]:
> Boot process is halting in midway because some of the necessary voltage
> regulators are deemed unused and subsequently powered off, leading to
> a completely unresponsive system.
> 
> Most of the device nodes had correct voltage regulator attachments.
> Yet these nodes had to set stricter enforcement on them through
> 'regulator-boot-on' and 'regulator-always-on' to function correctly.
> 
> The consumers of the regulators this commit affect are the followings:
> 
> 	DCDC1: vdd_1v8 system supply, USB-PHY, and ADC
> 	DCDC2: Core domain
> 	DCDC3: MPU core domain
> 	 LDO1: RTC
> 	 LDO2: 3v3 IO domain
> 	 LDO3: USB-PHY; not a boot-time requirement
> 	 LDO4: LCD [16:23]
> 
> All but LDO3 need to be always-on for the system to be functional.
> 
> Additionally regulator-name properties have been added for the kernel to
> display the name from the schematic. This will improve diagnostics.

Thanks for updating the description, applying this into
omap-for-v4.2/fixes.

Tony
