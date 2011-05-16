From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 May 2011 09:46:48 +0100
Subject: [PATCH 2/2] ARM: fix the note about dcache lazy flushing for SMP
	systems
In-Reply-To: <1305225183-15521-2-git-send-email-saeed@marvell.com>
References: <1305225183-15521-1-git-send-email-saeed@marvell.com>
	<1305225183-15521-2-git-send-email-saeed@marvell.com>
Message-ID: <BANLkTin2UkdYzemdBgaDuVsCM5acRhu1mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2011 19:33, Saeed Bishara <saeed@marvell.com> wrote:
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index f1b7998..e632363 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -275,7 +275,8 @@ void __sync_icache_dcache(pte_t pteval)
> ?* ?kernel cache lines for later. ?Otherwise, we assume we have
> ?* ?aliasing mappings.
> ?*
> - * Note that we disable the lazy flush for SMP.
> + * Note that we disable the lazy flush for SMP configurations where
> + * the cache maintenance operations are not automatically broadcasted

(I think "broadcast" rather than "broadcasted" would be better, though
I'm not a native English speaker. And a full stop at the end)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
