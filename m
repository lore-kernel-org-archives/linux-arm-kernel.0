From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 12:48 +0100
Subject: [RFC PATCH] arm: imx: Workaround i.MX6 PMU interrupts muxed to
 one SPI
In-Reply-To: <1416483757-24165-1-git-send-email-daniel.thompson@linaro.org>
References: <1416483757-24165-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <3404793.vJmOz13jz0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 11:42:37 Daniel Thompson wrote:
> Notes:
>     This patch adopts the approach used on the u8500 (db8500_pmu_handler)
>     but the logic has been generalized for any number of CPUs, mostly
>     because the i.MX6 has a both dual and quad core variants.
>     
>     However it might be better to include the generalized logic in the main
>     armpmu code. I think the logic could be deployed automatically on SMP
>     systems with only a single not-percpu IRQ, replacing the
>     plat->handle_irq dance we currently do to hook up this code.
>     
>     Thoughts? (or is there already shared logic to do this that I
>     overlooked)
> 

I would definitely prefer to have this handled in the armpmu implementation,
given that there are at least two platforms that need the exact same
hack.

	Arnd
