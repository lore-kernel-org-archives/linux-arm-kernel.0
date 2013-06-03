From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Jun 2013 13:13:16 -0700
Subject: [PATCH V4 3/4] ARM: dts: add Exynos audio subsystem clock
 controller node
In-Reply-To: <1370236744-16802-4-git-send-email-padma.v@samsung.com>
References: <1370236744-16802-1-git-send-email-padma.v@samsung.com>
 <1370236744-16802-4-git-send-email-padma.v@samsung.com>
Message-ID: <CAD=FV=WXEDA+R3BSn7TgSB5BpS2yuWGGmFDpxcQoYmQHGTAQMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi,

On Sun, Jun 2, 2013 at 10:19 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> Audio subsystem introduced in s5pv210 and exynos platforms
> which has a internal clock controller. This patch adds a node
> for the same on exynos5250.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index bccda67..388983e 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -72,6 +72,12 @@
>                 #clock-cells = <1>;
>         };
>
> +       clock_audss: audss-clock-controller at 3810000 {

Nit: other places in the same file have the leading 0, like
  i2s0: i2s at 03830000 {

So you could follow suit and do:

  clock_audss: audss-clock-controller at 03810000 {

-Doug
