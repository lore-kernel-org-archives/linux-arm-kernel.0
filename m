From: Peter.Chen@freescale.com (Peter Chen)
Date: Tue, 14 Apr 2015 08:43:22 +0000
Subject: Bug: Toggling green led on Olinuxino Maxi, also toggles USB
In-Reply-To: <517669452.288592.1428943161783.JavaMail.open-xchange@oxbaltgw03.schlund.de>
References: <1622635769.189113.1428833170958.JavaMail.open-xchange@oxbaltgw01.schlund.de>
 <20150413070037.GA9119@shlinux2>
 <517669452.288592.1428943161783.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Message-ID: <BN3PR0301MB08493E69AF05491D033C462481E60@BN3PR0301MB0849.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >
> > On Sun, Apr 12, 2015 at 12:06:10PM +0200, Stefan Wahren wrote:
> > > [...]
> > >
> > > I think the problem has something to with USB OTG, because GPIO 65
> > > is on the same pin for USB_OTG_ID.
> > > My idea was to set "dr_mode" in olinuxino dts explicit to "host" and
> > > it works, but i'm not sure that is the right fix.
> > >
> > > Shouldn't chipidea driver complain about missing pinctrl or something else?
> >
> > Some controllers have dedicated ID pin which doesn't need to configure
> > pinctrl registers. If the user would like to use role switch function
> > and the ID pin can be configured by pinctrl subsystem, it needs to set
> > pinctrl through dts.
> >
> 
> So setting "dr_mode" to "host" is the one and only solution for this case?
> 
> >
 
>From my point, yes.

Peter
