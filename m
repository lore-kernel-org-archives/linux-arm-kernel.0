From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 May 2015 14:42:01 -0700
Subject: EDMA oftree entry for AM335x
In-Reply-To: <20150504213300.GV15254@pengutronix.de>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com>
 <20150504211150.GU15254@pengutronix.de>
 <20150504212457.GB4810@atomide.com>
 <20150504213300.GV15254@pengutronix.de>
Message-ID: <20150504214201.GC4810@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Schwebel <r.schwebel@pengutronix.de> [150504 14:34]:
> On Mon, May 04, 2015 at 02:24:57PM -0700, Tony Lindgren wrote:
> > > I tried this, with the patch below, but it doesn't work:
> > 
> > With the above the tptc instances are being probed as separate
> > device entries that do not register with tpcc without the
> > related driver changes. I don't think we even parse the
> > compatible = "ti,tptc3" property currently.
> 
> How useful is it to let the driver warn about wrong devicetrees then,
> when fixing the devicetrees results in a kernel not supporting it...?

It's there so we can NAK new drivers if somebody tries to sneak
in more stuff like that. Of course it should be fixed for the
existing ones, that's the EDMA and McBSP AFAIK.

> Shouldn't these sort of patches being upstreamed only together with the
> full set of changes?

Ideally these sort of patches never got merged. The right way to fix
this is to first fix the driver, only then do the dts changes.
 
> However, thanks for the infos, I'll stay with the warnings for now.

Yes I figured :)

Regards,

Tony
