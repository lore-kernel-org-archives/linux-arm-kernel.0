From: dan@debian.org (Daniel Jacobowitz)
Date: Fri, 5 Feb 2010 13:00:14 -0500
Subject: Compiler for Atmel AT91SAMG20
In-Reply-To: <4B6C4C36.9030800@iders.ca>
References: <4B6C4C36.9030800@iders.ca>
Message-ID: <20100205180014.GA19538@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2010 at 10:49:58AM -0600, Andrew wrote:
> The compiler I'm using for the Kernel (Code Sourcery's GNU
> cross-toolchain arm-2008q3-66-arm-none-eabi) is set to pack structs
> by default, and the compilers that I use for userspace applications
> do not pack structs.

That's the wrong compiler.  Use the arm-none-linux-gnueabi tools to
build the Linux kernel.

The EABI tools should have the same ABI as the Linux tools though, so
I don't know what you mean by not packing structs.  Make sure both
your kernel and userspace compilers are using the EABI!  Or, if you
are not using an EABI userspace, disable CONFIG_AEABI.

-- 
Daniel Jacobowitz
CodeSourcery
