From: markus@trippelsdorf.de (Markus Trippelsdorf)
Date: Wed, 19 Oct 2016 17:37:46 +0200
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <20161017183806.GG5601@arm.com>
References: <20161017183806.GG5601@arm.com>
Message-ID: <20161019153746.GA4411@x4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016.10.17 at 19:38 +0100, Will Deacon wrote:
> Hi all,
> 
> I'm seeing an arm64 build failure with -rc1 and GCC trunk, although I
> believe that the new compiler behaviour at the heart of the problem
> has the potential to affect other architectures and other pieces of
> kernel code relying on dead-code elimination to remove deliberately
> undefined functions.
> 
> The failure looks like:
> 
>   | drivers/built-in.o: In function `armada_3700_add_composite_clk':
>   |
>   | linux/drivers/clk/mvebu/armada-37xx-periph.c:351:
>   | undefined reference to `____ilog2_NaN'
>   |
>   | linux/drivers/clk/mvebu/armada-37xx-periph.c:351:(.text+0xc72e0):
>   | relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
>   | `____ilog2_NaN'
>   |
>   | make: *** [vmlinux] Error 1
> 

This is a gcc bug, see:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=72785

-- 
Markus
