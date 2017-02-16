From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 14:46:00 +0100
Subject: [PATCH 00/11] ARM: Initial Actions Semi S500 and S900 enablement
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <3039198.1W6tLqk8Fp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 15, 2017 5:55:17 PM CET Andreas F?rber wrote:
> Hello,
> 
> Based on earlier work of mine for the LeMaker Guitar, this series adds initial
> support for the Actions Semiconductor S500 (ARMv7) and S900 (ARMv8) SoCs.
> 
> Despite Actions Semi being a Linaro member since 2015, sadly I have not seen
> a single upstream kernel patch submission since. Nor has the XApple community
> taken any such initiative.
> 
> The GitHub LeMaker/linux-actions and xapp-le/kernel trees have 3.10 based S500
> drivers in arch/arm/mach-owl/, whereas the 96boards-bubblegum/linux tree has
> new-style but still 3.10 based S900 drivers. I also spotted GPLv2+ vs. GPLv2
> license differences.
> 
> This series therefore provides a proof of concept for a combined S500 and S900
> mainline implementation. Only earlycon serial output is available for now.
> 
> Focusing on Bubblegum-96, no S500 clocksource implementation is provided yet,
> thus output on Guitar is less than on Bubblegum-96, but still it demonstrates
> that a single driver can be shared for both, using compatible strings for
> future differentiation.

Thanks for getting this started! It's unfortunately too late for 4.11 now,
but there should be no problem getting this merged into arm-soc early on
after the coming merge window.

I'd suggest keeping it as a set of patches for the moment, and we'll apply
them to the respective arm-soc branches as needed, with the exception of
the tty patch that should go through Greg's tree.

When you have addressed the review comments, please send the updated series
to arm at kernel.org.

	Arnd
