From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Jun 2014 21:21:41 +0900
Subject: [PATCH v2 00/08] ARM: shmobile: Rework include path V2
In-Reply-To: <20140617074658.30008.53021.sendpatchset@w520>
References: <20140617074658.30008.53021.sendpatchset@w520>
Message-ID: <20140617122138.GA20368@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 04:46:58PM +0900, Magnus Damm wrote:
> ARM: shmobile: Rework include path V2
> 
> [PATCH v2 01/08] ARM: shmobile: Move intc.h, cleanup sh_intc.h usage
> [PATCH v2 02/08] ARM: shmobile: Move dma-register.h
> [PATCH v2 03/08] ARM: shmobile: Move clock.h
> [PATCH v2 04/08] ARM: shmobile: Move most of irqs.h, keep some for pinctl
> [PATCH v2 05/08] ARM: shmobile: Move common.h
> [PATCH v2 06/08] ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
> [PATCH v2 07/08] ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
> [PATCH v2 08/08] ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case
> 
> Olof, here my latest take on the header move that you requested earlier.
> 
> This particular series hopefully follows your proposed way and moves the
> most common shared header files for mach-shmobile from <mach/foobar.h>
> to "foobar.h" without any workaround. Left are still per-SoC header files
> that will be moved once I know you are comformatble with this format.
> 
> Please note that these are only lightly compile tested with a handful
> of defconfigs, but any potential issue should be trivial to fix.
> 
> Also, there are certain bits of arch/arm/mach-shmobile/include/mach/
> get included from places like arch/arm/boot/compressed/ (booting
> legacy kernel directly from reset vector) and also from SoC specific
> legacy code under drivers/pinctrl. My proposal is to keep those users
> as-is until we phase out legacy board support (2-3 kernels?), let me
> know if you would like to get rid of "include/mach" sooner!
> 
> Simon, can you please this pick up and include in your rebase to v3.16-rc1?
> 
> Changes since V1:
> - rebased to v3.16-rc1
> 
> Thanks to Geert and Arnd for review support!

Thanks Magnus, I have queued this up.
