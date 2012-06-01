From: nm@ti.com (Menon, Nishanth)
Date: Fri, 1 Jun 2012 04:29:44 -0500
Subject: [PATCH 1/2 v4] ARM: OMAP2+: omap_hwmod: Add api to enable/disable
 module level wakeup events
In-Reply-To: <1335338237-4095-1-git-send-email-govindraj.raja@ti.com>
References: <1335276552-24340-1-git-send-email-govindraj.raja@ti.com>
 <1335338237-4095-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <CAOMWX4eQfOXBv9zP303RU-E09g=ZoZtNu8974Q=nn2J67cuW6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 2:17 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
[...]
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> @@ -289,6 +289,13 @@ static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
> ? ? ? ? ? ? ? ?"not suppose to be used on omap4\n");
> ? ? ? ?return 0;
> ?}
> +static inline void omap2_prm_enable_prcm_module_wakeup(s16 prcm_mod,
> + ? ? ? ? ? ? ? u8 prm_reg_id, u8 prm_reg_shift, bool set_wake)
> +{
> + ? ? ? WARN(1, "prm: omap2xxx/omap3xxx specific function and "
> + ? ? ? ? ? ? ? "not suppose to be used on omap4\n");
> + ? ? ? return 0;
^^^^^ minor comment - we should not return a value in a function returning void

[...]
Regards,
Nishanth Menon
