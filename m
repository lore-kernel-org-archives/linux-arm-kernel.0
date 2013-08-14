From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Aug 2013 15:30:29 -0600
Subject: [PATCH V2] ARM: allow DEBUG_UNCOMPRESS for Tegra
In-Reply-To: <1375379471-15615-1-git-send-email-swarren@wwwdotorg.org>
References: <1375379471-15615-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <520BF6F5.5090303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2013 11:51 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> DEBUG_UNCOMPRESS was previously disallowed for Tegra due to tegra.S's
> use of global data that was not linked into the decompressor. Solve this
> by declaring this symbol in tegra.S when it is being built into the
> decompressor. For the kernel proper, leave the declaration in
> mach-tegra/common.c as explained in the comment.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2: Don't select DEBUG_UNCOMPRESS with DEBUG_TEGRA_UART unless
>     !ZBOOT_ROM. Add notes on ZBOOT_ROM to comment.
> 
> Russell, I assume this should go in through the ARM patch tracker. Or,
> do you want me to take it through the Tegra tree?

Russell, I put this patch into the ARM patch tracker a while back. I
assume it's something you plan to take, or should I put it into the
Tegra tree? Thanks.
