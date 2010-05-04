From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 4 May 2010 22:44:40 +0800
Subject: [PATCH] pxa/vpac270: PXAUDC init fix
In-Reply-To: <1272773425-13454-1-git-send-email-marek.vasut@gmail.com>
References: <1272773425-13454-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <v2lf17812d71005040744r7893368cxa31255a2fc6afb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 2, 2010 at 12:10 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> This patch removes write to UP2OCR[DMSTATE] (ex-UP2OCR_DPPUBE) which is invalid
> on PXA270C5 and later.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/vpac270.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index 8da22d4..9884fa9 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -359,9 +359,9 @@ static struct platform_device vpac270_gpio_vbus = {
> ?static void vpac270_udc_command(int cmd)
> ?{
> ? ? ? ?if (cmd == PXA2XX_UDC_CMD_CONNECT)
> - ? ? ? ? ? ? ? UP2OCR |= UP2OCR_HXOE | UP2OCR_DPPUE | UP2OCR_DPPUBE;
> + ? ? ? ? ? ? ? UP2OCR = UP2OCR_HXOE | UP2OCR_DPPUE;
> ? ? ? ?else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
> - ? ? ? ? ? ? ? UP2OCR &= ~(UP2OCR_HXOE | UP2OCR_DPPUE | UP2OCR_DPPUBE);
> + ? ? ? ? ? ? ? UP2OCR = UP2OCR_HXOE;
> ?}
>
> ?static struct pxa2xx_udc_mach_info vpac270_udc_info __initdata = {
> --
> 1.7.0
>
>
