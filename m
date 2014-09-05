From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 5 Sep 2014 19:16:36 +0100
Subject: [PATCH RESEND v5 1/5] usb: host: ehci-st: Add EHCI support for
 ST STB devices
In-Reply-To: <202755915.brE74x99uQ@wuerfel>
References: <1409937829-23708-1-git-send-email-peter.griffin@linaro.org>
 <1409937829-23708-2-git-send-email-peter.griffin@linaro.org>
 <202755915.brE74x99uQ@wuerfel>
Message-ID: <20140905181636.GA1715@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, 05 Sep 2014, Arnd Bergmann wrote:

> On Friday 05 September 2014 18:23:45 Peter Griffin wrote:
> > +struct st_platform_priv {
> > +       struct clk *clks[USB_MAX_CLKS];
> > +       struct clk *clk48;
> > +       struct reset_control *rst;
> > +       struct reset_control *pwr;
> > +       struct phy *phy;
> > +};
> 
> Any reason why this is in a shared header file? It looks like
> duplicating the structure under two different names would
> actually be shorter and keep the drivers more readable as they'd
> be self-contained, even when they have the exact same structure.

The only reason was it was a identical structure so I put it in a shared
header file. I can unabstract it if you want?

> 
> Do both drivers use all fields?

Yes they are. I thought the 48Mhz clock would only be used by ohci, but annoyingly it also
clocks the reset logic of the ehci block as well.

regards,

Peter.
