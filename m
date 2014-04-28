From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Apr 2014 15:12:17 -0400
Subject: [PATCH] ARM: mvebu: refine which files are build in mach-mvebu
In-Reply-To: <1398709239-6126-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <20140427231044.GX28159@titan.lakedaemon.net>
 <1398709239-6126-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140428191217.GB28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 08:20:39PM +0200, Thomas Petazzoni wrote:
> Following the integration into mach-mvebu of the Kirkwood ARMv5
> support, we need to be more careful about which files get built. For
> example, the pmsu.c file now calls wfi(), which only exists on ARMv7
> platforms.
> 
> Therefore, this commit changes mach-mvebu/Makefile to build the Armada
> 370/XP/375/38x specific files only when CONFIG_MACH_MVEBU_V7 is
> enabled.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> This commit applies on top of mvebu/soc, and has been built tested
> with mvebu_v7_defconfig, mvebu_v5_defconfig, multi_v7_defconfig and
> multi_v5_defconfig (on top of mvebu/for-next).

Awesome!  thanks.  I've applied it just after

  14bde0f0fb54 ARM: mvebu: Add the PMSU related part of the cpu idle functions

which introduced the call to wfi() in pmsu.c.

both patches are in mvebu/soc-cpuidle.

thx,

Jason.
