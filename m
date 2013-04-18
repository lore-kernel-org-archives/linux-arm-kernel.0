From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 Apr 2013 09:36:11 -0700
Subject: [PATCH] ARM: tegra: solve adr range issue with THUMB2_KERNEL
 enabled
In-Reply-To: <1366132149-17294-1-git-send-email-swarren@wwwdotorg.org>
References: <1366132149-17294-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130418163611.GF7083@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 11:09:09AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> When building the kernel with CONFIG_THUMB2_KERNEL enabled, older
> assemblers may emit the following error:
> 
> reset-handler.S:78: Error: invalid immediate for address calculation (value = 0x00000004)
> 
> Using an explicit adr.w instruction will solve this. Newer assemblers do
> this automatically. Use the W() macro to do this under Thumb mode only.
> 
> Inspired-by: Joseph Lo <josephl@nvidia.com>
> Suggested-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Olof, Arnd,
> 
> Can you please apply this directly to arm-soc. Thanks.
> 
> This patch replaces patch 3/3 "ARM: tegra: make sure the pointer on 4
> byte align when THUMB2_KERNEL enabled" which I forwarded yesterday. It
> can be applied to wherever Tegra's for-3.10/fixes branch was applied,
> and doesn't cause any conflicts/merge-issues with any other Tegra patches
> this cycle.


Applied.


-Olof
