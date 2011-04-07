From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 07 Apr 2011 11:20:45 +0200
Subject: [PATCH 0/2] ARM: Unify setup for Marvell SheevaPlugs and Seagate
	DockStars
In-Reply-To: <4D9CEE24.1080501@erfurth.eu>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<4D9CEE24.1080501@erfurth.eu>
Message-ID: <4D9D81ED.7090809@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.04.2011 00:50, schrieb Nico Erfurth:
> Alexander Holler wrote:
>
>> The first patch merges the setup for Seagate DockStars into the setup
>> for Marvell SheevaPlugs and the second one removes the machine type for
>> DockStars at all.
>
> That looks fine so far.
>
>> Removing the machine type for DockStar shouldn't be a big problem. Support
>> for them is already broken in mainline U-Boot since 2 versions, so changing the
>> stuff there is already needed and it shouldn't be a problem to use the same
>> machine type as used for SheevaPlugs there.
>
> This sounds like very bad reasoning to me. The Dockstar has a machine-id
> assigned, if the bootloader is broken, people should either use a
> working version, or fix the current one.
>
> Also, using the memory-size to differ between these two machines sounds
> like something thats doomed to fail in the future.

I wonder how many people believe that either there will be another 
DockStar with the same HW and GPIOs for the LEDs but more memory (and 
still without sata) or that there will be another SheevaPlug with just 
128MB RAM or that someone could have a reason to change the memory 
layout using a mem= parameter.

For me all that is pretty unlikely.

Anyway, if someone wants, he could just use my patch 1/2 and replace 
patch 2/2 with a patch which changes the one line which checks the 
memory layout to be one bank with 128MB to machine_is_dockstar().

Regards,

Alexander
