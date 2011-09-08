From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 8 Sep 2011 21:19:12 +0200
Subject: [PATCH 12/25] OMAP: Add support to allocate the memory for secure
	RAM
In-Reply-To: <1315144466-9395-13-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-13-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <CAORVsuV8+zMzwT+PeWTo6TgWeEYfcSQdjY_kv4FcURohVoT=hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Allocate the memory to save secure ram context which needs
> to be done when MPU is hitting off mode.
>
> The ROM code expects a physical address to this memory
> and hence use memblock APIs to reserve this memory as part
> of .reserve() callback.
>
> Maximum possible size is allocated and can cater to OMAP3XXX / OMAP4XXX
> secure RAM size requirements.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> ?arch/arm/mach-omap2/include/mach/omap-secure.h | ? ?4 +++
> ?arch/arm/mach-omap2/omap-secure.c ? ? ? ? ? ? ?| ? 29 ++++++++++++++++++++++++
> ?arch/arm/plat-omap/common.c ? ? ? ? ? ? ? ? ? ?| ? ?3 ++
> ?3 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/include/mach/omap-secure.h
> index 26e7bcc..e2f95a0 100644
> --- a/arch/arm/mach-omap2/include/mach/omap-secure.h
> +++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
> @@ -26,6 +26,8 @@
> ?#define FLAG_FIQ_ENABLE ? ? ? ? ? ? ? ? ? ? ? ?0x1
> ?#define NO_FLAG ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?0x0
>
> +/* Maximum Secure memory storage size */
> +#define OMAP_SECURE_RAM_STORAGE ? ? ? ?(88 * SZ_1K)
Is this valid for all supported devices? How to differentiate
variations in the size for new chips variants in the future?

Regards,
Jean
