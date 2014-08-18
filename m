From: carlo@caione.org (Carlo Caione)
Date: Mon, 18 Aug 2014 15:27:13 +0200
Subject: [PATCH 4/7] ARM: meson: add basic support for MesonX SoCs
In-Reply-To: <20140817142115.GB15297@lukather>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-5-git-send-email-carlo@caione.org>
 <20140817142115.GB15297@lukather>
Message-ID: <20140818132713.GA28819@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 04:21:15PM +0200, Maxime Ripard wrote:
> Hi Carlo,

Hi Maxime,
thank you for reviewing also these patches, I'll keep you in CC for the
next revisions if you are interested.

> > +static __init void meson_init_machine_devicetree(void)
> > +{
> > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +}
> 
> This is the default, you can just remove it

Agree

> > +static const char * const m6_common_board_compat[] = {
> > +	"amlogic,8726_mx",
> > +	"amlogic,8726_mxs",
> > +	"amlogic,8726_mxl",
> > +	"amlogic,meson6",
> 
> Why are all those compatibles needed? Usually, you add a single one
> per SoC (which would be the last in your case I guess.

They are taken from the weird DTS in the original Amlogic sources but I
guess you are right. I am actually more inclined to just leave "8726_mx"
and "meson6" since online you can find equally both the versions for
exactly the same SoCs.

> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
> > +	.init_machine	= meson_init_machine_devicetree,
> 
> And since you don't need the init machine, you can just use the
> generic machine support. I'm not sure what's been decided on this,
> should we remove such empty machines?

I can get rid of the .init_machine but what about the .dt_compat field?

Thanks,

-- 
Carlo Caione
