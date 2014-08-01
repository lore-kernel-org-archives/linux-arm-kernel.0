From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 13:28:17 -0700
Subject: [PATCH v5 04/10] ARM: dts: Fill in bootargs for exynos5250-snow
In-Reply-To: <1406868897-26874-5-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-5-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=V4hQeGvE9+O2EY8KGvDj3SJKfOZGes4gKpHfg=xz1h4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber <afaerber@suse.de> wrote:
> exynos5250-cros-common.dtsi had an empty /chosen node.
> Fill in exemplary boot arguments.
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v5: New
>  Cleanup for /chosen node moved into -snow.dts.
>
>  arch/arm/boot/dts/exynos5250-snow.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 7680d5e03fb3..c4b0c73c736d 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -27,6 +27,7 @@
>         };
>
>         chosen {
> +               bootargs = "console=tty1";

As mentioned earlier, I don't think this is a particularly useful
change.  Just this boot argument is not enough to boot with anyway, so
listing it doesn't really help anyone.  In theory you could make some
assertion about what the "most popular" boot device and filesystem is,
but it seems unlikely to cover the majority of the cases.

I won't NAK this change myself, but I certainly won't push for it.

-Doug
