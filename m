From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Aug 2012 14:12:47 -0400
Subject: [PATCH] mtd: orion_nand: remove <mach/hardware.h> include
In-Reply-To: <1346110528-30858-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <20120816183708.GT22226@titan.lakedaemon.net>
 <1346110528-30858-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1346110528-30858-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120828181247.GH19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 01:35:28AM +0200, Thomas Petazzoni wrote:
> Commit c085d965fb63ac3b4cc7379d45588c0b39e2bdb0 made the ARCH_MVEBU
> platform select PLAT_ORION, which means that now all Orion drivers can
> be enabled on ARCH_MVEBU. This works fine for most drivers, except for
> orion_nand, because it includes <mach/hardware.h>, but mach-mvebu does
> not have a mach/hardware.h header (it is considered as a deprecated
> practice).
> 
> It turns out that the <mach/hardware.h> include in orion_nand is not
> necessary: the driver builds perfectly fine without it, so we simply
> get rid of it.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd at lists.infradead.org
> Cc: Artem Bityutskiy <dedekind1@gmail.com>

Applied to:

git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7-v2

thx,

Jason.
