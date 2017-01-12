From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Jan 2017 15:57:49 +0000
Subject: [PATCH] arm64: assembler: make adr_l work in modules under KASLR
In-Reply-To: <20170112154420.GE13843@arm.com>
References: <1484146493-18460-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170112154420.GE13843@arm.com>
Message-ID: <20170112155749.kbcfvr5qgax247vf@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 03:44:20PM +0000, Will Deacon wrote:
> On Wed, Jan 11, 2017 at 02:54:53PM +0000, Ard Biesheuvel wrote:
> > When CONFIG_RANDOMIZE_MODULE_REGION_FULL=y, the offset between loaded
> > modules and the core kernel may exceed 4 GB, putting symbols exported
> > by the core kernel out of the reach of the ordinary adrp/add instruction
> > pairs used to generate relative symbol references. So make the adr_l
> > macro emit a movz/movk sequence instead when executing in module context.
> > 
> > While at it, remove the pointless special case for the stack pointer.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/include/asm/assembler.h | 36 +++++++++++++++-----
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> Given that you need this for 4.11, I suggest Catalin takes it as a fix
> for 4.10 to avoid the crypto dependency.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

That's fine by me. Thanks for the ack.

-- 
Catalin
