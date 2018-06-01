From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Jun 2018 09:12:06 -0700
Subject: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
In-Reply-To: <20180601155502.GB6920@n2100.armlinux.org.uk>
References: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
 <20180601153512.GV5705@atomide.com>
 <20180601155502.GB6920@n2100.armlinux.org.uk>
Message-ID: <20180601161206.GW5705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [180601 15:57]:
> On Fri, Jun 01, 2018 at 08:35:12AM -0700, Tony Lindgren wrote:
> > CONFIG_KERNEL_LZMA fails:
> > 
> > Try gzip decompression.
> > Try LZMA decompression.
> > lzma_decompress_file: read on /boot/zImage of 65536 bytes failed
> > kernel: 0xb6abb010 kernel_size: 0x43d0f0
> > MEMORY RANGES
> > 0000000080000000-00000000bfdfffff (0)
> > zImage header: 0x016f2818 0x00000000 0x0043d0f0
> > zImage size 0x43d0f0, file size 0x43d0f0
> > Reserved memory ranges
> 
> This looks like an old kexec binary as it's missing the output from:
> 
>         dbgprintf("zImage requires 0x%08llx bytes\n", (unsigned long long)len);
> 
> Please can you test with the current version - the official
> repository should now be up to date with my version.  Thanks.

OK great. After updating kexec-tools to latest git veresion LZMA
crashkernel now also boots for me :)

Regards,

Tony
