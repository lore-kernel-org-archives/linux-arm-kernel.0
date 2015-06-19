From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 19 Jun 2015 14:19:43 +1000
Subject: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
In-Reply-To: <1434386579-6045-2-git-send-email-dave.long@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
Message-ID: <1434687583.23771.5.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>  feature and has identical definitions in four different arch ptrace.h
> include files. It seems unlikely that definition would ever need to be
> changed regardless of architecture so lets move it into
> include/linux/ptrace.h.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 5 -----

Built and booted on powerpc, but is there an easy way to actually test the code
paths in question?

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
