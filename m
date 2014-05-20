From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 May 2014 16:20:54 +0100
Subject: [PATCH] mfd: abx500-core: Fix compiler warning larger stack frame
In-Reply-To: <536E1543.3090107@aurabindo.in>
References: <536E1543.3090107@aurabindo.in>
Message-ID: <20140520152054.GB24991@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From 95f6ac368dbe352af0dfa2097b7d58b416447be5 Mon Sep 17 00:00:00 2001
> From: Aurabindo J <mail@aurabindo.in>
> Date: Sat, 10 May 2014 15:16:58 +0530
> Subject: [PATCH] mfd: abx500-core: Fix compiler warning larger stack frame
> 
> On systems with CONFIG_FRAME_WARN=1024, compiler warns the allocation of
> an object of struct device on stack. Make the allocation dynamically to
> fix the warning.
> 
> drivers/mfd/abx500-core.c: In function ?abx500_dump_all_banks?:
> drivers/mfd/abx500-core.c:167:1: warning: the frame size of 1032 bytes
> is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Signed-off-by: Aurabindo J <mail@aurabindo.in>
> ---
>  drivers/mfd/abx500-core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Looks good to me.  I'll apply it until Linus complains.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
