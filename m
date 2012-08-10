From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 09 Aug 2012 23:46:05 -0700
Subject: [PATCH] ARM: Fix XIP build due to PHYS_OFFSET definition moving
In-Reply-To: <1343956994-27513-1-git-send-email-sboyd@codeaurora.org>
References: <1343956994-27513-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5024AE2D.5050506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/2/2012 6:23 PM, Stephen Boyd wrote:
> During the p2v changes, the PHYS_OFFSET #define moved into a
> !__ASSEMBLY__ section. This causes a XIP build to fail with
>
>  arch/arm/kernel/head.o: In function 'stext':
>  arch/arm/kernel/head.S:146: undefined reference to 'PHYS_OFFSET'
>
> Momentarily leave the #ifndef __ASSEMBLY__ section so we can
> define PHYS_OFFSET for all compilation units.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> I don't know if it's worth stable, seems that nobody has compiled XIP for
> a year (back to 2.6.39 days?).

Is this approach acceptable? Shall I put this in the patch tracker?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
