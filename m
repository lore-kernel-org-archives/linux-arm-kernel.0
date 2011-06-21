From: banajit.goswami@gmail.com (Banajit Goswami)
Date: Tue, 21 Jun 2011 16:48:38 +0530
Subject: [RFC][PATCH 3/5] ARM: SAMSUNG: Adding IO mapping for OTG PHY.
In-Reply-To: <1308639827-2121-4-git-send-email-p.paneri@samsung.com>
References: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
	<1308639827-2121-4-git-send-email-p.paneri@samsung.com>
Message-ID: <BANLkTintiDOi1mtc0M_qKbxYm+YmDU_Ttw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Praveen,

On Tue, Jun 21, 2011 at 12:33 PM, <p.paneri@samsung.com> wrote:
>
> From: Praveen Paneri <p.paneri@samsung.com>
>
> Adding virtual addresses for OTG PHY.
>
> Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
> ---
> ?arch/arm/mach-s5p64x0/cpu.c | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
> index a5c0095..8dc6f20 100644
> --- a/arch/arm/mach-s5p64x0/cpu.c
> +++ b/arch/arm/mach-s5p64x0/cpu.c
> @@ -57,6 +57,11 @@ static struct map_desc s5p64x0_iodesc[] __initdata = {
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(S5P64X0_PA_VIC1),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_16K,
> ? ? ? ? ? ? ? ?.type ? ? ? ? ? = MT_DEVICE,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S3C_VA_USB_HSPHY,
> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S5P64X0_PA_USB_HSPHY),
> + ? ? ? ? ? ? ? .length ? ? ? ? = SZ_1M,

Do we really need 1M for this??

> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> ? ? ? ?},
> ?};
>
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
