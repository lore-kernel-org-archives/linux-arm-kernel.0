From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Nov 2016 19:16:21 +0000
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <20161123154829.GA2489@afzalpc>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc>
Message-ID: <20161123191621.GD14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 09:18:29PM +0530, Afzal Mohammed wrote:
> multi_v7_defconfig & MMU disabled, stderr was more verbose and was
> unhappy with Kconfig dependencies,

Well, !MMU and multiplatform _are_ exclusive in reality.  One of the
things we work around in multiplatform is the different physical
address space layouts of the platforms, particularly with where RAM
is located.  That's not possible in !MMU configurations.  A kernel
built to support every platform in multiplatform will not boot on
most of them.

So efforts to make !MMU work with multiplatform are IMHO rather
misguided.

!MMU makes sense with classifications of systems (like the Cortex-M*
based systems) but not everything.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
