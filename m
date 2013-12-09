From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 09 Dec 2013 14:14:45 +0100
Subject: [PATCH 1/3] ARM: EXYNOS: pmu: Constify data tables
In-Reply-To: <1384971686-7208-1-git-send-email-djkurtz@chromium.org>
References: <1384971686-7208-1-git-send-email-djkurtz@chromium.org>
Message-ID: <1922780.plAOmhqzpW@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thursday 21 of November 2013 02:21:24 Daniel Kurtz wrote:
> These tables are all immutable, make them const to save 4416 bytes of RAM.
> 
> size arch/arm/mach-exynos/pmu.o
>    text	   data	    bss
>     848	   4420	      4		// before
>    5264	      4	      4		// after

I'm not sure where the mentioned saving of RAM is. Moving data between
sections is not supposed to make it use less memory, I believe.

Anyway, it's a good practice to mark constant data as const, to disallow
changing them at runtime by mistake, so the patch is fine. Except some
issues I commented on inline.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
