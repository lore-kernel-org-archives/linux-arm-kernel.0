From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Mar 2016 16:14:28 +0100
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <CALT56yNRYP3SmmHP_j974PwW+CpnhrTGghLJ1J9WfcEx4DJgSw@mail.gmail.com>
References: <201603101013.04618.arnd@arndb.de>
 <201603101738.55060.arnd@arndb.de>
 <CALT56yNRYP3SmmHP_j974PwW+CpnhrTGghLJ1J9WfcEx4DJgSw@mail.gmail.com>
Message-ID: <1990577.mfhmFbVfA9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2016 00:49:20 Dmitry Eremin-Solenikov wrote:
> > How long do you think you need for your systems?
> > Do you still ship new products, or are these all legacy devices that
> > will have a failing battery or flash at some point in the future?
> 
> I'm using several old PDAs with StrongARM CPU. They have CF cards
> and battery life isn't that important for me. I really see no point in dropping
> support for them just because GCC folks told us so.

The question for now is whether it's ok for you if gcc-7 stops shipping
with support for -march-armv4. If you can either keep using your platforms
with -march=armv4t and --fix-v4bx, or stop upgrading the toolchain after
gcc-6, I think everything is fine from the platform point of view.

> And BTW: I'm using EABI with that v4bx trick both in kernel and userspace.

Do you have a patch for the kernel for this? I believe we never pass
--fix-v4bx today, but we should probably start doing that on all
linkers that understand it, so we don't get surprised by bugs when
the compiler starts requiring it.

	Arnd
