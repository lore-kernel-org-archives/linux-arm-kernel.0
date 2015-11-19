From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Thu, 19 Nov 2015 11:44:34 +0530
Subject: [PATCH] include: asm-generic: page.h: Remove useless
 get_user_page and free_user_page
In-Reply-To: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
References: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Message-ID: <564D68CA.6010708@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 November 2015 01:10 AM, Chen Gang wrote:
> From ba7c00c4cb976109b6a35812ce9649aaeda81e2d Mon Sep 17 00:00:00 2001
> From: Chen Gang <gang.chen.5i5j@gmail.com>
> Date: Thu, 19 Nov 2015 03:24:42 +0800
> Subject: [PATCH] include: asm-generic: page.h: Remove useless get_user_page and free_user_page
> 
> They are not symmetric with each other, neither are used in real world
> (can not be found by grep command in source code root directory), so
> remove them.
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/arc/include/asm/page.h       | 3 ---
>  arch/arm/include/asm/page-nommu.h | 3 ---
>  arch/frv/include/asm/page.h       | 3 ---
>  arch/m68k/include/asm/page_mm.h   | 3 ---
>  arch/m68k/include/asm/page_no.h   | 3 ---
>  arch/openrisc/include/asm/page.h  | 3 ---
>  include/asm-generic/page.h        | 3 ---
>  7 files changed, 21 deletions(-)

So this is one huge patch touching several arches with potential to cause
conflicts when merged. Can u divy them up and then the maintainers can simply
merge them individually given there is no common dependency !
