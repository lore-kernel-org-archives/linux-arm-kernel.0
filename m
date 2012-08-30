From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 29 Aug 2012 17:15:02 -0700
Subject: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
In-Reply-To: <1346230576-20004-3-git-send-email-rnayak@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
 <1346230576-20004-3-git-send-email-rnayak@ti.com>
Message-ID: <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 1:56 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index d7f55e4..a3831a2 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3156,6 +3156,7 @@ static struct omap_clk omap44xx_clks[] = {
>         CLK(NULL,       "dss_tv_clk",                   &dss_tv_clk,    CK_443X),
>         CLK(NULL,       "dss_48mhz_clk",                &dss_48mhz_clk, CK_443X),
>         CLK(NULL,       "dss_dss_clk",                  &dss_dss_clk,   CK_443X),
> +       CLK(NULL,       "dss_fck",                      &dss_fck,       CK_443X),
>         CLK("omapdss_dss",      "ick",                          &dss_fck,       CK_443X),

Is it right to re-use dss_fck for the "ick" here?  I think it is due
to omap4 modulemode stuff but I don't have DM in front of me and
wanted a double-check...

Regards,
Mike
