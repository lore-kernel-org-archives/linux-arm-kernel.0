From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 22:36:56 +0000
Subject: [PATCH 0/2] OMAP: TWL: sparse fixes
In-Reply-To: <1294081110-23695-1-git-send-email-nm@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
Message-ID: <20110103223656.GA8414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 12:58:28PM -0600, Nishanth Menon wrote:
> Source:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> branch: omap-for-linus
> 
> Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
> resulted in the following sparse warnings:
> http://pastebin.mozilla.org/907954

FYI, you may like to try:

make C=2 arch/arm/mach-omap2/

instead of the two-step process:
| Do a kernel make with "make C=1" to run sparse on all the C files that get
| recompiled, or use "make C=2" to run sparse on the files whether they need to
| be recompiled or not.  The latter is a fast way to check the whole tree if you
| have already built it.
