From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Oct 2017 10:00:11 +0100
Subject: [PATCH] arm64: elf.h: Correct comment about READ_IMPLIES_EXEC
 propagation
In-Reply-To: <20171006020001.GD2971@decadent.org.uk>
References: <20171006020001.GD2971@decadent.org.uk>
Message-ID: <20171009090010.GA5127@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 06, 2017 at 03:00:01AM +0100, Ben Hutchings wrote:
> Process personality always propagates across a fork(), but can change
> at an execve().
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  arch/arm64/include/asm/elf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

You're right, the comment is sloppy. I'll pick this up for 4.15.

Will

> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 33be513ef24c..fac1c4de7898 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -188,8 +188,8 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
>  
>  #define compat_start_thread		compat_start_thread
>  /*
> - * Unlike the native SET_PERSONALITY macro, the compat version inherits
> - * READ_IMPLIES_EXEC across a fork() since this is the behaviour on
> + * Unlike the native SET_PERSONALITY macro, the compat version maintains
> + * READ_IMPLIES_EXEC across an execve() since this is the behaviour on
>   * arch/arm/.
>   */
>  #define COMPAT_SET_PERSONALITY(ex)					\



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
