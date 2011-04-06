From: ne@erfurth.eu (Nico Erfurth)
Date: Thu, 07 Apr 2011 00:50:12 +0200
Subject: [PATCH 0/2] ARM: Unify setup for Marvell SheevaPlugs and Seagate
	DockStars
In-Reply-To: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
Message-ID: <4D9CEE24.1080501@erfurth.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Holler wrote:

> The first patch merges the setup for Seagate DockStars into the setup
> for Marvell SheevaPlugs and the second one removes the machine type for
> DockStars at all.

That looks fine so far.

> Removing the machine type for DockStar shouldn't be a big problem. Support
> for them is already broken in mainline U-Boot since 2 versions, so changing the
> stuff there is already needed and it shouldn't be a problem to use the same
> machine type as used for SheevaPlugs there.

This sounds like very bad reasoning to me. The Dockstar has a machine-id
assigned, if the bootloader is broken, people should either use a
working version, or fix the current one.

Also, using the memory-size to differ between these two machines sounds
like something thats doomed to fail in the future.

Nico
