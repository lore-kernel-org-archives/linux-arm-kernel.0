From: joe@perches.com (Joe Perches)
Date: Tue, 16 Aug 2016 10:08:33 -0700
Subject: [PATCH v2] ARM: Add missing newline terminators to kernel messages
In-Reply-To: <1471354832-18456-1-git-send-email-geert+renesas@glider.be>
References: <1471354832-18456-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1471367313.4075.167.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-08-16 at 15:40 +0200, Geert Uytterhoeven wrote:
> Before commit 874f9c7da9a4acbc ("printk: create pr_<level> functions"),
> pr_*() calls without a trailing newline characters would be printed with
> a newline character appended, both on the console and in the output of
> the dmesg command.

Hey Geert.

This doesn't apply to -next as the pr_notice/pr_cont below is
properly changed to a single pr_notice.

> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
[]
> @@ -1196,7 +1196,7 @@ void __init sanity_check_meminfo(void)
> ?				pr_notice("Truncating RAM at %pa-%pa",
> ?					??&block_start, &block_end);
> ?				block_end = vmalloc_limit;
> -				pr_cont(" to -%pa", &block_end);
> +				pr_cont(" to -%pa\n", &block_end);
> ?				memblock_remove(vmalloc_limit, overlap_size);
> ?				should_use_highmem = true;
> ?			}
