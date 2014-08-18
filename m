From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Aug 2014 21:11:03 +0200
Subject: [PATCH 4/7] ARM: meson: add basic support for MesonX SoCs
In-Reply-To: <20140818132713.GA28819@carlo-MacBookPro>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-5-git-send-email-carlo@caione.org>
 <20140817142115.GB15297@lukather>
 <20140818132713.GA28819@carlo-MacBookPro>
Message-ID: <20140818191103.GI15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 18, 2014 at 03:27:13PM +0200, Carlo Caione wrote:
> On Sun, Aug 17, 2014 at 04:21:15PM +0200, Maxime Ripard wrote:
> > Hi Carlo,
> 
> Hi Maxime,
> thank you for reviewing also these patches, I'll keep you in CC for the
> next revisions if you are interested.

Yep, sure.

> > > +static const char * const m6_common_board_compat[] = {
> > > +	"amlogic,8726_mx",
> > > +	"amlogic,8726_mxs",
> > > +	"amlogic,8726_mxl",
> > > +	"amlogic,meson6",
> > 
> > Why are all those compatibles needed? Usually, you add a single one
> > per SoC (which would be the last in your case I guess.
> 
> They are taken from the weird DTS in the original Amlogic sources but I
> guess you are right. I am actually more inclined to just leave "8726_mx"
> and "meson6" since online you can find equally both the versions for
> exactly the same SoCs.

I don't really know what's the best option here, but you should really
choose one name and stick to it. Since the mach directory is called
meson, I guess meson6 would make more sense, but it's your call.

> > > +	NULL,
> > > +};
> > > +
> > > +DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
> > > +	.init_machine	= meson_init_machine_devicetree,
> > 
> > And since you don't need the init machine, you can just use the
> > generic machine support. I'm not sure what's been decided on this,
> > should we remove such empty machines?
> 
> I can get rid of the .init_machine but what about the .dt_compat field?

Technically, it would work. The only drawbacks are that you don't get
the machine name in /proc/cpuinfo, and that you'll probably have to
add this file at some point in the future anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/f90c0d10/attachment-0001.sig>
