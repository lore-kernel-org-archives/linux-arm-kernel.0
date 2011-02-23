From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 23 Feb 2011 17:31:38 +0530
Subject: [PATCH] DaVinci: fix compilation warnings in <mach/clkdev.h>
In-Reply-To: <201102092133.23765.sshtylyov@ru.mvista.com>
References: <201102092133.23765.sshtylyov@ru.mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BD4987F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Feb 10, 2011 at 00:03:23, Sergei Shtylyov wrote:
> Commit 6d803ba736abb5e122dede70a4720e4843dd6df4 (ARM: 6483/1: arm & sh:
> factorised duplicated clkdev.c) caused the following warnings:
> 
> In file included from /home/headless/src/kernel.org/linux-davinci/arch/arm/
> include/asm/clkdev.h:17,
>                  from include/linux/clkdev.h:15,
>                  from arch/arm/mach-davinci/clock.h:71,
>                  from arch/arm/mach-davinci/common.c:22:
> arch/arm/mach-davinci/include/mach/clkdev.h:4: warning: `struct clk' declared
> inside parameter list
> arch/arm/mach-davinci/include/mach/clkdev.h:4: warning: its scope is only this
> definition or declaration, which is probably not what you want
> arch/arm/mach-davinci/include/mach/clkdev.h:9: warning: `struct clk' declared
> inside parameter list
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>  
> +struct clk;
> +
>  static inline int __clk_get(struct clk *clk)
>  {
>  	return 1;

This looks good to me. It should be queued for 2.6.38-rc
Kevin is going to handle the 2.6.38 and 2.6.39 kernels
so will queue this for him.

Thanks,
Sekhar
