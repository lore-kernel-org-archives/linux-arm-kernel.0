From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 9 Oct 2013 16:00:55 +0100
Subject: [RFC PATCH 1/4] ARM: Allow assembler.h to be used with inline asm
In-Reply-To: <20131009144211.GJ25034@n2100.arm.linux.org.uk>
References: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
 <1381328993-12724-2-git-send-email-Dave.Martin@arm.com>
 <20131009144211.GJ25034@n2100.arm.linux.org.uk>
Message-ID: <20131009150054.GB2306@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 03:42:11PM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 09, 2013 at 03:29:50PM +0100, Dave Martin wrote:
> > There are a few things in assembler.h that would be useful with
> > inline asm, but currently assembler.h refuses to be included into C
> > files.
> > 
> > In particular, the optional feature macros (PLD() and friends) can
> > be used sensibly with inline asm, with a string argument.
> > 
> > This patch enables the relevant parts of aassembler.h to be
> > included in C files and used in inline asm.
> > 
> > Since assembler.h by definition can't be included in any C file up
> > to now, this should not introduce any namespace clashes.
> 
> I think it would be better to move the two macros (PLD and CALGN) out of
> this file, rather than covering almost the entire file with this #ifdef.

Certainly we could do that.  When I started this hack, I though that a
larger proportion of the file would be relevant...

Any thoughts on a sensible name?  asm/asm-common.h, maybe?

Cheers
---Dave
