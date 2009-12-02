From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 2 Dec 2009 12:31:48 +0530
Subject: [PATCH 3/5] ARM: OMAP4: PM: Move DPLL control apis to dpll.c
In-Reply-To: <1259670448-19840-3-git-send-email-rnayak@ti.com>
References: <1259670448-19840-1-git-send-email-rnayak@ti.com>
	<1259670448-19840-2-git-send-email-rnayak@ti.com>
	<1259670448-19840-3-git-send-email-rnayak@ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBF30E94@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Nayak, Rajendra
> Sent: Tuesday, December 01, 2009 5:57 PM
> To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Cc: Nayak, Rajendra; Paul Walmsley; Cousson, Benoit
> Subject: [PATCH 3/5] ARM: OMAP4: PM: Move DPLL control apis to
> dpll.c
> 
> This patch moves all the dpll control api's to a
> common file dpll.c. This is in preperation of omap4
> support wherein most of these api's can be reused.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile    |    3 +-
>  arch/arm/mach-omap2/clock.h     |   13 +
>  arch/arm/mach-omap2/clock34xx.c |  511 ----------------------------
> ---------
>  arch/arm/mach-omap2/clock34xx.h |   11 -
>  arch/arm/mach-omap2/clock44xx.c |    8 +-
>  arch/arm/mach-omap2/clock44xx.h |    4 -
>  arch/arm/mach-omap2/dpll.c      |  539
> +++++++++++++++++++++++++++++++++++++++
>  7 files changed, 558 insertions(+), 531 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dpll.c
> 

....

On OMAP4, we might need an additional API since different DPLL outputs 
Like M2, M3 , M4 etc have individual gating control ( Bit 8) apart form DPLL gating.

Regards,
Santosh
