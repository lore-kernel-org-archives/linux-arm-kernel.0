From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 14:03:02 +0100
Subject: Build LSK 3.14 kernel with android-toolchain
In-Reply-To: <20141202182952.01eda0ca@xhacker>
References: <CAAQ0ZWRQ05GiCOqV2Q6g2B6n+XN-qs9o6MKOFXiK2wKrW0nvog@mail.gmail.com>
 <2048273.C5mPR68Ukg@wuerfel> <20141202182952.01eda0ca@xhacker>
Message-ID: <2152219.OTGyvezhSH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 December 2014 18:29:52 Jisheng Zhang wrote:
> On Tue, 2 Dec 2014 02:24:03 -0800
> > On Tuesday 02 December 2014 17:39:21 Jisheng Zhang wrote:
> > > 
> > > From my experience in last several years
> > > 
> > > 1. the arm-linux-androideabi- toolchain sets some options by default, PIC
> > > for example, even -mno-android can't disable all the side effects per my
> > > test.
> > 
> > Yes, that's definitely possible. Any idea how the android folks build their
> > kernel?
> 
> copied from https://android.googlesource.com/toolchain/build/+/HEAD/README
> 
> The Android toolchain supports the following targets:
>    a. arm-linux-androideabi
>    b. arm-eabi  (for Android kernel)
>    c. arm-newlib-eabi	(for runnng gcc regression tests)
>    d. i[3456]86-*-linux-gnu, x86_64-*-linux-gnu	(for x86 targets)
> 
> So they build android kernel using the arm-eabi- toolchain.

Interesting, I think that's not supported at all, as the ABI is slightly
incompatible between arm-eabi and arm-linux-gnueabi, in particular the
short-enums that are used only in arm-eabi.

I have a patch somewhere that errors out if someone attempts to build
the kernel with an arm-eabi toolchain, I should probably submit that
upstream. The Android folks will likely just revert it, but it would
catch everyone that tries to build a normal kernel in the Android way.

	Arnd
