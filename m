From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 8 Nov 2013 18:46:25 +0000
Subject: [PATCH v2] ARM: kexec: Use the right ISA for relocate_new_kernel
In-Reply-To: <20131108133426.GE17461@mudshark.cambridge.arm.com>
References: <1383913444-9153-1-git-send-email-Dave.Martin@arm.com>
 <20131108133426.GE17461@mudshark.cambridge.arm.com>
Message-ID: <20131108184625.GE2602@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 01:34:27PM +0000, Will Deacon wrote:
> On Fri, Nov 08, 2013 at 12:24:04PM +0000, Dave Martin wrote:
> > Copying a function with memcpy() and then trying to execute the
> > result isn't trivially portable to Thumb.
> > 
> > This patch modifies the kexec soft restart code to copy its
> > assembler trampoline relocate_new_kernel() using fncpy() instead,
> > so that relocate_new_kernel can be in the same ISA as the rest of
> > the kernel without problems.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> > Changes since v1:
> > 
> >   * Move ENDPROC() after relocate_new_kernel's literals, to be
> >     consistent the location of relocate_new_kernel_end and with the way
> >     GCC sets ELF symbol sizes for functions.  This is just a tidyup,
> >     with no functional impact.
> 
> Cheers Dave:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

Thanks


Are you still in a position to test this, Taras?

Cheers
---Dave
