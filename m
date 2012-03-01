From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 1 Mar 2012 14:39:36 +0530
Subject: Randconfig module build error with OMAP4_ERRATA_I688
In-Reply-To: <20120229173719.GN18901@atomide.com>
References: <20120229173719.GN18901@atomide.com>
Message-ID: <CAMQu2gxg_57AVW+MT_Sgi+gr2OUge-YPdSUxoG+z-zQth=4-UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 11:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Santosh,
>
> Looks like OMAP4_ERRATA_I688 still has one more issue:
> Modules won't build at least with the attached randconfig
> generated file.
>
> Can you please take a look at how to deal with it?
>
> Maybe omap_bus_sync should be an inline function with some
> wrapper for the sleep44xx.S to call?
>
> I already posted a fix for the GPMC related error with the
> same .config file.
>
This one builds for me against 'Linux 3.3-rc5,
Ofocurse I got below error with the attached .config which
I bypassed to see the Errata build failure.

arch/arm/mach-omap2/built-in.o: In function `n8x0_mmc_callback':
linux-2.6/arch/arm/mach-omap2/board-n8x0.c:374: undefined reference to
`omap_mmc_notify_cover_event'
make: *** [.tmp_vmlinux1] Error 1

I build this with below toolchain...
$arm-none-linux-gnueabi-gcc --version
arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2011.03-41) 4.5.2
Copyright (C) 2010 Free Software Foundation, Inc.

Am I missing anything ?

Regards
Santosh
