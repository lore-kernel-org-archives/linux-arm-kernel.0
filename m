From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 20:30:49 +0200
Subject: [PATCH RESEND v5 1/5] usb: host: ehci-st: Add EHCI support for ST
 STB devices
In-Reply-To: <20140905181636.GA1715@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1409937829-23708-1-git-send-email-peter.griffin@linaro.org>
 <202755915.brE74x99uQ@wuerfel>
 <20140905181636.GA1715@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <3890179.kgPZYmEVZm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 19:16:36 Peter Griffin wrote:
> On Fri, 05 Sep 2014, Arnd Bergmann wrote:
> 
> > On Friday 05 September 2014 18:23:45 Peter Griffin wrote:
> > > +struct st_platform_priv {
> > > +       struct clk *clks[USB_MAX_CLKS];
> > > +       struct clk *clk48;
> > > +       struct reset_control *rst;
> > > +       struct reset_control *pwr;
> > > +       struct phy *phy;
> > > +};
> > 
> > Any reason why this is in a shared header file? It looks like
> > duplicating the structure under two different names would
> > actually be shorter and keep the drivers more readable as they'd
> > be self-contained, even when they have the exact same structure.
> 
> The only reason was it was a identical structure so I put it in a shared
> header file. I can unabstract it if you want?

Yes, I think that would be an improvement. Everything looks great to me
otherwise, at least after a brief look.

	Arnd
