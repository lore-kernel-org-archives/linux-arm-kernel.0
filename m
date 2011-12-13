From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 13 Dec 2011 10:48:01 -0200
Subject: [PATCH 08/19] dma: MX3_IPU fix depends
In-Reply-To: <1323757911-25217-8-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
 <1323757911-25217-8-git-send-email-eric@eukrea.com>
Message-ID: <CAOMZO5AOpFtkJDmTSjPmvPVr0ra4d7jUcihGgncYE2VtfKCeSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 4:31 AM, Eric B?nard <eric@eukrea.com> wrote:
> ARCH_MX3 was removed in e760b5260d39113794da17c64cbd6e6311155b66
> thus preventing to select MX3_IPU, thus preventing IPU and display
> to work on i.MX3x SOC.
>
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
> ?drivers/dma/Kconfig | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ab8f469..0b59fea 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -124,7 +124,7 @@ config MV_XOR
>
> ?config MX3_IPU
> ? ? ? ?bool "MX3x Image Processing Unit support"
> - ? ? ? depends on ARCH_MX3
> + ? ? ? depends on SOC_IMX31 ||?SOC_IMX35
> ? ? ? ?select DMA_ENGINE
> ? ? ? ?default y
> ? ? ? ?help

On this same file there is another reference to ARCH_MX3 in the
"config IMX_SDMA"
dependency.

Care to send a patch fixing both locations?

Regards,

Fabio Estevam
