From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 Apr 2013 09:31:58 -0700
Subject: [PATCH 1/3] ARM: tegra: fix build error when THUMB2_KERNEL enabled
In-Reply-To: <1366066255-18192-1-git-send-email-swarren@wwwdotorg.org>
References: <1366066255-18192-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130418163158.GB7083@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 04:50:53PM -0600, Stephen Warren wrote:
> From: Joseph Lo <josephl@nvidia.com>
> 
> This patch fix the build failure when CONFIG_THUBM2_KERNEL enabled. You
> clould see the error message below:
> 
> arch/arm/mach-tegra/sleep-tegra30.S:69: Error: shift must be constant --
> `orr r12,r12,r4,lsl r3'
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Arnd, Olof, here are 3 fixes from Joseph for some Tegra build issues,
> mostly exposed by multi-platform enablement and/or related randconfig
> testing.
> 
> Can you please apply these to arm-soc? For reference, I tested applying
> them to Tegra's for-3.10/fixes branch and they apply there fine, and
> merge with the other Tegra for-3.10 branches at least, without any issue.
> 
> Note: patch 3 triggers checkpatch, but I can't work out why; the code
> seems to be formatted the same as patch 1 and 2, and is consistent with
> other usage of ARM() and THUMB() macros in arch/arm/.


Applied to fixes-non-critical.


-Olof
