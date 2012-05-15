From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 15:55:07 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4FB26E4B.4020609@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 09:54, Thomas Petazzoni wrote:
> Arnd, Olof,
>
> You'll find in this patch set the initial support for a new family of
> ARMv7-compatible Marvell SoCs, that we have choosen to support in the
> arch/arm/mach-armada/ directory.
>
> At the moment, both the Armada 370 and the Armada XP SoCs are
> supported in this directory, and we are able to build a single kernel
> image that boots on both SoCs. Both SoCs use the PJ4B processor, a
> Marvell-developed ARM core that implements the ARMv7 instruction
> set. We are currently using Marvell evaluation boards for both of
> those SoCs, and the support for those boards is added in this patch
> set.
>
> This preliminary support only includes the necessary code for timer
> and IRQ support, the serial controller is a standard 16550-compatible
> one. The diffstat looks like:

FYI, built and tested on our system here and it gets to
printing the sched_clock line and getting no further.

I will have a debug.

The only comment so far other than the review issues is that
we needed to enable CONFIG_HIGMEM to get >780MiB of memory
as this system comes with 2048MiB as standard.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
