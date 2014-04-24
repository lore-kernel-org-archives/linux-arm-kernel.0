From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Apr 2014 14:59:04 +0200
Subject: [PATCH 5/5] ARM: sunxi: Remove sun4i and sun7i machine definitions
In-Reply-To: <1401022774.yKcHJAmPtb@wuerfel>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398265476-29373-6-git-send-email-maxime.ripard@free-electrons.com>
 <1401022774.yKcHJAmPtb@wuerfel>
Message-ID: <20140424125904.GY24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 06:02:51PM +0200, Arnd Bergmann wrote:
> On Wednesday 23 April 2014 17:04:36 Maxime Ripard wrote:
> >  
> > -static void __init sunxi_dt_init(void)
> > -{
> > -       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > -}
> > -
> > -static const char * const sunxi_board_dt_compat[] = {
> > -       "allwinner,sun4i-a10",
> > -       "allwinner,sun5i-a10s",
> > -       "allwinner,sun5i-a13",
> > -       NULL,
> > -};
> > -
> > -DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
> > -       .init_machine   = sunxi_dt_init,
> > -       .dt_compat      = sunxi_board_dt_compat,
> > -MACHINE_END
> > -
> >  static const char * const sun6i_board_dt_compat[] = {
> >         "allwinner,sun6i-a31",
> >         NULL,
> 
> I'd like to hear more opinions on this. We could either rely
> on the generic code, or we could keep the entry with just
> the .dt_compat line and the name, so /proc/cpuinfo contains
> a meaningful platform name.

Ah! I haven't thought of /proc/cpuinfo. I agree that having something
meaningful in there would be much better.

I'll respin the patch if Olof agrees.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/2ab2595a/attachment.sig>
