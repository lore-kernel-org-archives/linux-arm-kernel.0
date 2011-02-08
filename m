From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 16:32:29 +0000
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <201102081617.59092.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<19a3630aad67b496a4e36354abc63c4a@mail.gmail.com>
	<AANLkTim90DF1pE0As_vNO-c4dn7S=2jVq+hkRo8CYsx4@mail.gmail.com>
	<201102081617.59092.arnd@arndb.de>
Message-ID: <20110208163229.GC6188@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 04:17:58PM +0100, Arnd Bergmann wrote:
> On Tuesday 08 February 2011, Dave Martin wrote:
> > CFLAGS_cpu_specific_object.o        += -march=armv7-a
> > 
> > Whether it's safe to do it depends on whether code from that file
> > could ever get run on other processors.  I'm not so sure of the answer
> > to that..., but perhaps someone else has a better idea.
> 
> We already do this a lot from arch/arm/mm/Makefile, and those
> files are typically just one function per file, so they can easily
> be proven to be safe that way.

No, we do that with assembly files.  It doesn't work soo well with
C files as we really don't want GCC itself to generate v7 instructions
unless we explicitly ask for them.

The other issue here is that somtimes generating code with different
-march options leads to the linker refusing to link them together...

Unfortunately, ARM toolchains have been developed with the assumption
that you're only building a program for one specific CPU, not
targetting multiple CPUs.
