From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Aug 2012 15:20:01 +0000
Subject: [PATCH 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
References: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
Message-ID: <201208011520.02353.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 August 2012, Praveen Paneri wrote:
> This patch set introduces a phy driver for samsung SoCs. It uses the existing
> transceiver infrastructure to provide phy control functions. Use of this driver
> can be extended for usb host phy as well. Over the period of time all the phy
> related code for most of the samsung SoCs can be integrated here.
> Removing the existing phy code from mach-s3c64xx but not from other machine 
> code.This driver is tested with smdk6410 and Exynos4210(with DT).

This looks very nice overall, great work!

We will still have to take care of the pmu isolation callback in the
long run, when we get to the point of removing all auxdata. Do you
have a plan on how to do that? If yes, it would be good to mention
that in the changelog.

My guess is that the PMU code should be moved into a higher-level
abstraction. I don't know if you would use one of those we already
have or whether you'd introduce a new subsystem for those. Apparently
other platforms have similar issues, so I'd suggest you leave the
callback for now, but we should at some point discuss what to to
about it.

	Arnd
