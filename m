From: nm@ti.com (Menon, Nishanth)
Date: Thu, 1 Mar 2012 18:36:01 -0600
Subject: [PATCH] ARM: OMAP2+: powerdomain: unwrap and simplify logging
 strings
In-Reply-To: <alpine.DEB.2.00.1202292122560.12752@utopia.booyaka.com>
References: <alpine.DEB.2.00.1202292122560.12752@utopia.booyaka.com>
Message-ID: <CAOMWX4cAABO8jUCi8g_vbv6SnU3vPcqOULV6ui2jV7E2Nt8g0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 22:23, Paul Walmsley <paul@pwsan.com> wrote:
> b/arch/arm/mach-omap2/powerdomain.c
> index 8a18d1b..89000d3 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -339,8 +339,8 @@ int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct
> clockdomain *clkdm)
> ? ? ? ?if (!pwrdm || !clkdm)
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> - ? ? ? pr_debug("powerdomain: associating clockdomain %s with powerdomain
> "
> - ? ? ? ? ? ? ? ?"%s\n", clkdm->name, pwrdm->name);
> + ? ? ? pr_debug("powerdomain: %s: associating clockdomain %s\n",
> + ? ? ? ? ? ? ? ?clkdm->name, pwrdm->name);

while at this, could i suggest having instead:
pr_debug("%s: %s: associating clockdomain %s\n", __func__,
                clkdm->name, pwrdm->name);
since the function name helps associate the message back in, wont it
be a bit of a dual edged information as well?

or even simplify it further with

#define pr_fmt(fmt)  "%s:%s: " fmt, "powerdomain", __func__
?
Regards,
Nishanth Menon
