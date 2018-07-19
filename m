From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jul 2018 11:19:31 +0100
Subject: [PATCH 0/6] Further spectre variant 1 mitigations
In-Reply-To: <20180710141322.GL17271@n2100.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
Message-ID: <20180719101931.GI17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't have any public feedback on this series... so, I guess no one
is really interested in this?

On Tue, Jul 10, 2018 at 03:13:22PM +0100, Russell King - ARM Linux wrote:
> Hi,
> 
> This series applies the mitigations for Spectre variant 1 to 32-bit
> ARM user accessors.  This series slightly larger by the need to
> offset the additional overhead introduced by these checks in various
> paths, particularly the signal handling path.
> 
>  arch/arm/include/asm/assembler.h   |  4 +++
>  arch/arm/include/asm/thread_info.h |  2 +-
>  arch/arm/include/asm/uaccess.h     | 26 ++++++++++++-----
>  arch/arm/kernel/signal.c           | 58 +++++++++++++++++++-------------------
>  arch/arm/kernel/sys_oabi-compat.c  |  8 ++++--
>  arch/arm/lib/copy_from_user.S      |  7 +++++
>  arch/arm/vfp/vfpmodule.c           | 16 +++++------
>  7 files changed, 72 insertions(+), 49 deletions(-)
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
> According to speedtest.net: 13Mbps down 490kbps up

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
