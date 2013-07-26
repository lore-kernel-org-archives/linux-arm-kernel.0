From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Jul 2013 10:24:53 -0700
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726151223.045835540@gmail.com>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
Message-ID: <CAOesGMjRAxjh-jEA=qqMVeuS5bXeSL9sa7CLd8jkZ6AL8kUuRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 26, 2013 at 7:56 AM, Domenico Andreoli
<domenico.andreoli@linux.com> wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
>
> arch/arm/mach-bcm contains a plurality of Broadcom SoCs, each configured
> separately. As a matter of flexibility and maintenance, it needs to be
> always included in the build.
>
> Cc: Christian Daudt <csd@broadcom.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
>  arch/arm/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: b/arch/arm/Makefile
> ===================================================================
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -145,7 +145,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x0020
>  # Machine directory name.  This list is sorted alphanumerically
>  # by CONFIG_* macro name.
>  machine-$(CONFIG_ARCH_AT91)            += at91
> -machine-$(CONFIG_ARCH_BCM)             += bcm
> +machine-y                              += bcm
>  machine-$(CONFIG_ARCH_BCM2835)         += bcm2835
>  machine-$(CONFIG_ARCH_CLPS711X)                += clps711x
>  machine-$(CONFIG_ARCH_CNS3XXX)         += cns3xxx

It's hard to tell what you're trying to do here, since the current
in-tree code works just fine and you're alluding to it having
problems. :)

Are you looking to add new selection of per-SoC config options? If so,
I propose keeping ARCH_BCM as a common, but silent, option that is
just selected by the other SoCs.  See how OMAP does it where
OMAP2/3/4/5 all select ARCH_OMAP2PLUS for comparison.


-Olof
