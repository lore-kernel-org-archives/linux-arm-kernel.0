From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 7 Oct 2011 14:01:50 +0800
Subject: [PATCH 09/26] ARM: pxa: export symbols from pxa3xx-ulpi
In-Reply-To: <1317499438-14058-10-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-10-git-send-email-arnd@arndb.de>
Message-ID: <CAMPhdO_utpnKhnV_3MXrAmzpgk6sO1EZ_+Bixa6e+9NOgvDgjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The pxa3xx_u2d_start_hc/pxa3xx_u2d_stop_hc symbols are used by the
> ohci-pxa27x driver, which can be a module.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied. Cc'ed Igor Grinberg <grinberg@compulab.co.il>.

> ---
> ?arch/arm/mach-pxa/pxa3xx-ulpi.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> index ce7168b..e28dfb8 100644
> --- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
> +++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> @@ -265,6 +265,7 @@ int pxa3xx_u2d_start_hc(struct usb_bus *host)
>
> ? ? ? ?return err;
> ?}
> +EXPORT_SYMBOL_GPL(pxa3xx_u2d_start_hc);
>
> ?void pxa3xx_u2d_stop_hc(struct usb_bus *host)
> ?{
> @@ -277,6 +278,7 @@ void pxa3xx_u2d_stop_hc(struct usb_bus *host)
>
> ? ? ? ?clk_disable(u2d->clk);
> ?}
> +EXPORT_SYMBOL_GPL(pxa3xx_u2d_stop_hc);
>
> ?static int pxa3xx_u2d_probe(struct platform_device *pdev)
> ?{
> --
> 1.7.5.4
>
>
