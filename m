From: kees.jongenburger@gmail.com (Kees Jongenburger)
Date: Wed, 26 May 2010 21:46:56 +0200
Subject: using openocd + gdb to debug linux kernel on arm926ejs
In-Reply-To: <4BFD72AD.4010005@gmail.com>
References: <4BFD72AD.4010005@gmail.com>
Message-ID: <AANLkTim02hkr41mCHGgE7GieOP0OGJz-rkSrHyWhBf4c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello  Ferar,

On Wed, May 26, 2010 at 9:12 PM, f. achkar <fachkar.datawind@gmail.com> wrote:
> I'm newbie and have a s3c2450 based board (arm926ejs), I have a working compressed kernel image
> zImage, this image boots properly via u-boot-1.1.6, however I simply
> failed to debug remotely the vmlinux (root directory of linux source tree) via openocd-0.4.0 with a j-link segger.
> is there a good reference on how to properly debug the linux kernel via openocd/gdb for an arm target on a linux hot machine?

Did you read
http://elinux.org/DebuggingTheLinuxKernelUsingGdb ?

>
> details:
> 1. let u-boot start the board;
> 2. I get the u-boot command prompt:
>
> 3. halt the target via openocd/telnet;

If you plan on replacing the kernel using gdb you need really to stop
at a known location
The moment you halt the target needs to be after memory initialization
and prior  to the kernel being loaded

> 4. cd to root directory of linux source code and issue:
> gdb vmlinux
> GNU gdb (GDB) 6.8.50.20090417
> Copyright (C) 2009 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law. ?Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "--host=i686-pc-linux-gnu
> --target=arm-none-linux-gnueabi".
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>...
> (gdb)
>
> 5.
> (gdb) target remote localhost:3333
> Remote debugging using localhost:3333
> 0xc3e01874 in ?? ()
> 0xc3e01874: ? ?ldr ? ?r3, [r0, #16]
> (gdb)
Is this kernel code?

> 8. if I do continue (gdb) c, then I don't see any output on the serial
> console (as normally do during zImage booting process!)
>
> where I'm messing up?

First try just booting and connecting to the target afterwards. All
you really need is a vmlinuz so don't load the kernel over JTAG

Hope this helps

Greetings
