From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Dec 2013 22:24:31 -0700
Subject: [PATCH] ARM: bcm2835: add USB controller to device tree
In-Reply-To: <1386131536-21066-1-git-send-email-swarren@wwwdotorg.org>
References: <1386131536-21066-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52A00E0F.8070303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 09:32 PM, Stephen Warren wrote:
> The BCM2835 SoC contains a DWC2 USB controller. Add this to the DT.
> 
> Set up the pin controller to fully enable the USB controller on the
> Raspberry Pi. The GPIO setup works because the default output value for
> GPIO 6 (LAN_RUN/n_reset) just happens to be 1, which enables the
> USB/LAN chip.
> 
> Note that you'll need a U-Boot which enables power to the USB controller;
> search for U-Boot patch "ARM: rpi_b: power on SDHCI and USB HW modules".

I've applied this to bcm2835's for-3.14/dt branch.
