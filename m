From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jul 2010 12:46:02 +0200
Subject: Questions about FPU and NEON on Cortex-A9 with armv7 instructions!
In-Reply-To: <AANLkTinoZ0GT5FFUFPmU5gQK1zVcZKYtSWpHDQ1Y4OXO@mail.gmail.com>
References: <AANLkTinA_ZNdNwx2R-6C9LBQ=4i8uMVpmVFCRaKkS=Xs@mail.gmail.com>
	<4C4FF8FF.304@xenomai.org>
	<AANLkTinoZ0GT5FFUFPmU5gQK1zVcZKYtSWpHDQ1Y4OXO@mail.gmail.com>
Message-ID: <201007281246.03033.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 July 2010, David Yang wrote:
> If the other kernel code doesn't save and restore the FPU context,then
> it's risky.
> 
> Can I use FPU just in one C file ?

Usually if you need something like this, you're doing something wrong.
Code that does a lot of computation should go generally live in user
space, not a kernel module, though there are a few exceptions.

Take a look at how drivers/md/raid6sse2.c uses kernel_fpu_begin() to
do this on x86.

	Arnd
