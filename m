From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Sep 2013 10:02:06 +0100
Subject: Build error in torvalds kernel 3.11 for omap2plus
In-Reply-To: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com>
References: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com>
Message-ID: <20130908090206.GK25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 08, 2013 at 11:34:10AM +0530, Anil Kumar wrote:
> scripts/kconfig/conf --silentoldconfig Kconfig
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   AS      arch/arm/mm/cache-v7.o
> arch/arm/mm/cache-v7.S: Assembler messages:
> arch/arm/mm/cache-v7.S:285: Error: garbage following instruction -- `dsb ishst'
> arch/arm/mm/cache-v7.S:297: Error: garbage following instruction -- `dsb ishst'
> make[1]: *** [arch/arm/mm/cache-v7.o] Error 1
> make: *** [arch/arm/mm] Error 2

You need a later binutils for these instructions - 2.22 works just fine,
even with gcc 4.5.x.
