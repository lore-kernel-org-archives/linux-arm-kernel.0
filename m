From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Dec 2010 15:10:36 +0100
Subject: [PATCH 15/23]  Alternative mmc structure to support pxa168, pxa910,
	mmp2 family SD
In-Reply-To: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
Message-ID: <201012221510.36878.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 December 2010 08:09:58 Philip Rakity wrote:
> The PXA168, PXA910, and MMP2 are not the same SOC.  The family
> of embedded processors have slightly different internal blocks
> for SD, I2C, etc.  Sometimes it is important to know which SOC
> is being used due to differences in the silicon.  Sometimes it
> is important to know evaluation boards should be selected based
> on the SOC on the board.

This looks like you're moving in the wrong direction.

If the chips are just slightly different, you'd certainly
want to make sure that you can detect the difference at runtime,
and be able to use the same kernel on all of the variants.

Instead, you promote each of the SOCs to a top-level family
in this patch, which makes it impossible to build a kernel
for more than one of them at a time.

	Arnd
