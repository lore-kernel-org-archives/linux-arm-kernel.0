From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 Apr 2013 09:32:13 -0700
Subject: [PATCH 2/3] ARM: tegra: fix relocation truncated error when
 THUMB2_KERNEL enabled
In-Reply-To: <1366066255-18192-2-git-send-email-swarren@wwwdotorg.org>
References: <1366066255-18192-1-git-send-email-swarren@wwwdotorg.org>
 <1366066255-18192-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130418163213.GC7083@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 04:50:54PM -0600, Stephen Warren wrote:
> From: Joseph Lo <josephl@nvidia.com>
> 
> The conditional branch instruction in Thumb2 only available to short range.
> The linker will fail when the conditional branch over the range. Then
> resulting in link error when generating kernel image. e.g.:
> 
> arch/arm/mach-tegra/reset-handler.S:47:(.text+0xf8e):
> relocation truncated to fit: R_ARM_THM_JUMP19 against symbol
> `cpu_resume' defined in .data section in arch/arm/kernel/built-in.o
> 
> This patch using a Thumb2 instruction IT (if-then) to have a longer branch
> range.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>


Applied to fixes-non-critical.


-Olof
