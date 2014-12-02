From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 14:04:50 +0100
Subject: Build LSK 3.14 kernel with android-toolchain
In-Reply-To: <20141202123458.GF2411@dragon>
References: <CAAQ0ZWRQ05GiCOqV2Q6g2B6n+XN-qs9o6MKOFXiK2wKrW0nvog@mail.gmail.com>
 <20141202182952.01eda0ca@xhacker> <20141202123458.GF2411@dragon>
Message-ID: <55136650.MReT3lPU7N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 December 2014 20:34:59 Shawn Guo wrote:
> On Tue, Dec 02, 2014 at 06:29:52PM +0800, Jisheng Zhang wrote:
> > On Tue, 2 Dec 2014 02:24:03 -0800
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > > Yes, that's definitely possible. Any idea how the android folks build their
> > > kernel?
> > 
> > copied from https://android.googlesource.com/toolchain/build/+/HEAD/README
> > 
> > The Android toolchain supports the following targets:
> >    a. arm-linux-androideabi
> >    b. arm-eabi  (for Android kernel)
> >    c. arm-newlib-eabi (for runnng gcc regression tests)
> >    d. i[3456]86-*-linux-gnu, x86_64-*-linux-gnu       (for x86 targets)
> > 
> > So they build android kernel using the arm-eabi- toolchain.
> 
> Thanks Jisheng for all the information.
> 
> Yes, I just built my kernel with arm-eabi in android-toolchain-eabi-4.9-2014.09
> and it works fine.  So we basically conclude that we should build kernel
> with arm-eabi rather than arm-linux-androideabi.
> 
> One thing to note - with CONFIG_ARM_UNWIND turned on, even arm-eabi
> generate the following warning.  This is one difference between android
> arm-eabi and arm-linux-gnueabi we can see immediately.
> 
>   LD      vmlinux
> arm-eabi-ld: warning: unwinding may not work because EXIDX input section 31 of fs/built-in.o is not in EXIDX output section
> arm-eabi-ld: warning: unwinding may not work because EXIDX input section 12 of crypto/built-in.o is not in EXIDX output section
> arm-eabi-ld: warning: unwinding may not work because EXIDX input section 27 of block/built-in.o is not in EXIDX output section
> arm-eabi-ld: warning: unwinding may not work because EXIDX input section 27 of drivers/built-in.o is not in EXIDX output section
> arm-eabi-ld: warning: unwinding may not work because EXIDX input section 33 of net/built-in.o is not in EXIDX output section

I looked into this before, I think this is a gold specific warning
about an actual kernel bug, but I haven't been able to track it down.

It certainly happens with my regular toolchain and gold as well.

	Arnd
