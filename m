From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2016 14:14:26 +0000
Subject: [PATCH] arm64: asm: Explicitly include linux/personality.h in
 asm/page.h
In-Reply-To: <20160128124417.GE6078@sirena.org.uk>
References: <1453983508-20410-1-git-send-email-broonie@kernel.org>
 <20160128124417.GE6078@sirena.org.uk>
Message-ID: <20160128141425.GA20099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 12:44:17PM +0000, Mark Brown wrote:
> On Thu, Jan 28, 2016 at 12:18:28PM +0000, Mark Brown wrote:
> > asm/page.h uses READ_IMPLIES_EXEC from linux/personality.h but does not
> > explicitly include it causing build failures in -next where whatever was
> > causing it to be implicitly included has changed to remove that
> > inclusion.  Add an explicit inclusion to fix this.
> 
> Argh, sorry - this causes problems further down the line with linking
> vdso.lds due to enums getting into the linker script and upsetting the
> linker (there are several compile errors today so it was masked).

You can move the include further down after the #ifndef __ASSEMBLY__

-- 
Catalin
