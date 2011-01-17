From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 16 Jan 2011 17:36:57 -0800
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd and
	phychan structures
In-Reply-To: <20110116201805.GB4864@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
	<E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
	<AANLkTi=GsMaDQDSuR=Z4AT4Vk4GThx6O_0Le=pjsu9gj@mail.gmail.com>
	<20110115092324.GX15996@n2100.arm.linux.org.uk>
	<AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
	<20110116123615.GC27542@n2100.arm.linux.org.uk>
	<AANLkTi=s-CQVEj4wOZo8cCbzWnj5G0p_COtKoQt7Xzy8@mail.gmail.com>
	<20110116195948.GA4864@n2100.arm.linux.org.uk>
	<4D334F15.3080705@intel.com>
	<20110116201805.GB4864@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikC7gewBjB_5ebi11J_Brpoc6p=3bWLb=8WdUk_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 16, 2011 at 12:18 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Subject: [PATCH] ARM: PL08x: cleanup comments
>
> Cleanup the formatting of comments, remove some which don't make sense
> anymore.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?drivers/dma/amba-pl08x.c ? | ?144 ++++++++++++++++----------------------------
> ?include/linux/amba/pl08x.h | ? 45 +++++++-------
> ?2 files changed, 72 insertions(+), 117 deletions(-)
>
[..]
> diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
> index 933b4ed..3111385 100644
> --- a/include/linux/amba/pl08x.h
> +++ b/include/linux/amba/pl08x.h
[..]

Thanks, applied after changing the following hunk...

> @@ -118,8 +116,7 @@ struct pl08x_txd {
> ? ? ? ?dma_addr_t dst_addr;
> ? ? ? ?size_t len;
> ? ? ? ?dma_addr_t llis_bus;
> - ? ? ? void *llis_va;
> - ? ? ? bool active;
> + ? ? ? struct pl08x_lli *llis_va;
> ? ? ? ?/* Default cctl value for LLIs */
> ? ? ? ?u32 cctl;
> ? ? ? ?/*

...to:

@@ -119,7 +117,6 @@ struct pl08x_txd {
        size_t len;
        dma_addr_t llis_bus;
        struct pl08x_lli *llis_va;
-       bool active;
        /* Default cctl value for LLIs */
        u32 cctl;
        /*

--
Dan
