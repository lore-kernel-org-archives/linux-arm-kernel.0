From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 20:58:30 +0100
Subject: Error in head-common.S file while ARM Linux booting
In-Reply-To: <BANLkTikQHho9o+3dzbB-0Tq-ai2R5AAc5w@mail.gmail.com>
References: <BANLkTi=rVF1r-3WpF+iBWMSgy46VnoVx=A@mail.gmail.com>
	<alpine.LFD.2.00.1104211614140.24613@xanadu.home>
	<BANLkTikQHho9o+3dzbB-0Tq-ai2R5AAc5w@mail.gmail.com>
Message-ID: <20110511195830.GL5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 12:54:11PM +0530, Madhavi Manchala wrote:
> <stdin>:46:0: warning: "__IGNORE_migrate_pages" redefined
> /home/openwrt-s3c2510/trunk/build_dir/linux-s3c2510/linux-2.6.36/arch/arm/include/asm/unistd.h:476:0: note: this is the location of the previous definition
>   CHK     include/generated/compile.h
>   AS      arch/arm/kernel/debug.o
> In file included from include/linux/cache.h:4:0,
>                  from include/linux/time.h:7,
>                  from include/linux/stat.h:60,
>                  from include/linux/module.h:10,
>                  from arch/arm/mach-s3c2510/include/mach/debug-macro.S:16,
>                  from arch/arm/kernel/debug.S:130:
> include/linux/kernel.h:42:0: warning: "ALIGN" redefined
> include/linux/linkage.h:61:0: note: this is the location of the previous definition
> include/linux/stddef.h: Assembler messages:
> include/linux/stddef.h:15: Error: bad instruction `enum {'
> include/linux/stddef.h:16: Error: junk at end of line, first unrecognized character is `,'
> include/linux/stddef.h:18: Error: junk at end of line, first unrecognized character is `}'

Looks to me like you're trying to include header files which contain C
constructs into an assembly file.  There's nothing much more than "don't
do that" to be said about this.

Eg, you certainly shouldn't be including linux/module.h into
debug-macro.S.
