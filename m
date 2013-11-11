From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 11 Nov 2013 18:16:46 +0000
Subject: [PATCH 8/9] ARM: add test for as supporting '.inst'
In-Reply-To: <1383935832-20865-9-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
 <1383935832-20865-9-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20131111181646.GD3166@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 06:37:11PM +0000, Ben Dooks wrote:
> Add a test for the assembler supporting .inst and then defining
> ARM_HAVE_INST for any position where this is needed.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 0069697..d556a52 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -36,6 +36,8 @@ MMUEXT		:= -nommu
>  KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
>  endif
>  
> +KBUILD_CFLAGS	+= $(call as-instr,.inst 0x0,-DARM_HAVE_INST)
> +

It looks like all the .inst directive variants were added to gas at the
same time, so we know if .inst is there, .inst.n and .inst.w are there
too.

The above does seem to DTRT with gas-2.19 as well as modern versions
(though making GCC invoke a non-default assembler is painful...)

Acked-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
