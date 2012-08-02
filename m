From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Aug 2012 14:04:11 +0100
Subject: [PATCH] ARM: makefile: work around toolchain bug in recent
 versions of binutils
In-Reply-To: <1343910206-3684-1-git-send-email-will.deacon@arm.com>
References: <1343910206-3684-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120802130411.GU6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 01:23:26PM +0100, Will Deacon wrote:
> Recent upstream versions of binutils fail to assembler compressed/head.S
> when passed the -march=all option:
> 
> http://lists.gnu.org/archive/html/bug-binutils/2011-04/msg00162.html
> 
> The recommended workaround from the tools folks is not to pass the
> option, and instead let the assembler deduce the CPU type based on the
> features used by the code.

That doesn't work for all binutils - binutils historically has had to be
told explicitly what architecture its building for and won't "deduce"
it from the code.

Maybe this needs to be a build-time test whether the assembler accepts it?
