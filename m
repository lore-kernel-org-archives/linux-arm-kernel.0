From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Sep 2011 18:48:52 +0200
Subject: [PATCH 0/4] arm/tegra: Convert gpio & pinmux to platform devices
In-Reply-To: <1316725567-17881-1-git-send-email-swarren@nvidia.com>
References: <1316725567-17881-1-git-send-email-swarren@nvidia.com>
Message-ID: <201109231848.52318.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 September 2011, Stephen Warren wrote:
> 
> This series converts the Tegra GPIO and pinmux drivers to be regular
> platform devices.

Looks good overall.

> The series is extracted from an earlier series I posted that augmented
> these drivers to initialize HW state from the device-tree. I'm holding
> off on that aspect of the changes, since it's not entirely clear to me
> whether the new pinmux API should drive the initial pinmux state setup
> via "system hog" definitions, or whether pinmux drivers should indeed
> do their own thing.

I think at least you should try to do an ioremap of the pinmux register
area in the pinmux probe function and make sure that it's called early
enough, if at all possible.

Right now, there is an empty probe() function, which is a bit silly,
and the pg_readl()/pg_writel() functions use hardcoded register
addresses.

	Arnd
