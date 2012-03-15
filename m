From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 15 Mar 2012 13:40:35 -0400 (EDT)
Subject: [PATCH 1/4] ARM: opcodes: Don't define the thumb32 byteswapping
 macros for BE32
In-Reply-To: <1331829132-9762-2-git-send-email-dave.martin@linaro.org>
References: <1331829132-9762-1-git-send-email-dave.martin@linaro.org>
 <1331829132-9762-2-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.02.1203151337150.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Mar 2012, Dave Martin wrote:

> The existing __mem_to_opcode_thumb32() is incorrect for BE32
> platforms.  However, these don't support Thumb-2 kernels, so this
> option is not so relevant for those platforms anyway.
> 
> This operation is complicated by the lack of unaligned memory
> access support prior to ARMv6.
> 
> Rather than provide a "working" macro which will probably won't get
> used (or worse, will get misused), this patch removes the macro for
> BE32 kernels.  People manipulating Thumb opcodes prior to ARMv6
> should almost certainly be splitting these operations into
> halfwords anyway, using __opcode_thumb32_{first,second,compose}()
> and the 16-bit opcode transformations.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>


> +/*
> + * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
> + * work in all cases, due to alignment constraints.  For now, a correct
> + * version is not proivided for BE32.

s/proivided/provided/


Nicolas
