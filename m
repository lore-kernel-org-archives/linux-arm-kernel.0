From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Jul 2014 22:15:52 -0700
Subject: [GIT PULL] omap dts changes for v3.17 merge window, part1
In-Reply-To: <20140716125553.GC18374@atomide.com>
References: <20140716125553.GC18374@atomide.com>
Message-ID: <20140719051552.GD20064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 05:55:58AM -0700, Tony Lindgren wrote:
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/dt-part1
> 
> for you to fetch changes up to 3c9464ed75d6c15ee864da6d8f6a4cd3b0f2c934:
> 
>   ARM: DTS: omap5-uevm: Enable basic audio (McPDM <-> twl6040) (2014-07-15 00:21:25 -0700)
> 
> ----------------------------------------------------------------
> First set of .dts changes for omaps for v3.17 merge
> window:
> 
> - Enable irqchip crossbar interrupt mapping. These changes
>   are based on an immutable irqchip branch set up by Jason
>   Cooper to make it easier to merge the related .dts changes.
> 
> - Removal of omap2 related static clock data that now comes
>   from device tree.
> 
> - Enabling of PHY regulators for various omaps
> 
> - Enabling of PCIe for dra7
> 
> - Add support for am437x starterkit
> 
> - Enable audio for for omap5
> 
> - Enable display and am335x-evmsk

Merged, but:

1) There was a conflict in the qspi node of dra7.dtsi due to a fix to
   remove the interrupts property. It'd be nice to get these branches
   based on the fixes so that we don't see these conflicts (or at least
   get told about them). Besides, if we happen to have an older base in
   our branch than what had the fix, it'll bubble all the way up to Linus.

2) There was an add/add conflict in the dra7.dtsi file, due to new
   entries just being appended. Please keep these sorted on address to
   avoid that.

-Olof
