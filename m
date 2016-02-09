From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 9 Feb 2016 19:52:22 +0000
Subject: [PATCH] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <1455046156-10582-1-git-send-email-ddaney.cavm@gmail.com>
References: <1455046156-10582-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160209195222.0882d7f7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  9 Feb 2016 11:29:16 -0800
David Daney <ddaney.cavm@gmail.com> wrote:

Hi David,

> From: Andrew Pinski <apinski@cavium.com>
> 
> On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
> instructions may cause the icache to become invalid if it contains
> data for a non-current ASID.
> 
> This patch implements the workaround (which flushes the local icache
> when switching the mm) by using code patching.
> 
> Signed-off-by: Andrew Pinski <apinski@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/Kconfig                  | 11 +++++++++++
>  arch/arm64/include/asm/cpufeature.h |  3 ++-
>  arch/arm64/kernel/cpu_errata.c      |  9 +++++++++
>  arch/arm64/mm/proc.S                | 12 ++++++++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)

It would be good to update Documentation/arm64/silicon-errata.txt to
reflect the fact that there is a workaround available for this erratum.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
