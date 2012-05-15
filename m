From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 10:51:35 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515091838.GC6820@lunn.ch>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch>
Message-ID: <4FB22727.6090406@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 10:18, Andrew Lunn wrote:
> On Tue, May 15, 2012 at 10:54:36AM +0200, Thomas Petazzoni wrote:
>> Arnd, Olof,
>>
>> You'll find in this patch set the initial support for a new family of
>> ARMv7-compatible Marvell SoCs, that we have choosen to support in the
>> arch/arm/mach-armada/ directory.

I went for the arch/arm/mach-mv-armadaxp as it kept the marvell socs
together (ignoring kirkwood and dove for the moment).

I'm not sure how important the naming is as long as it is clear in the
Kconfig what machines are being supported by the system.

I'd say you can put the core support for multiple difference SoCs into
the same directory without too much trouble, since there is now no need
for multiple board files to go in there with it. Shared peripherals can
either go into the relevant drivers/ directory, or in to some form of
common directory such as arch/arm/common.

[snip]

> Hi Thomas
>
> Is mach-armada a good idea? What are many different armada chipsets families:
>
> Armada 100, 300, 500, 600, 1000, 15000, XP.
>
> You only seem to support 300 and XP. Where would the others go? 300 is
> actually mach-dove, etc.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
