From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 10 Feb 2014 16:06:01 +0100
Subject: [PATCH v2 14/15] charger: max14577: Configure battery-dependent
 settings from DTS
In-Reply-To: <20140210121405.GH22773@lee--X1>
References: <1391767487-10017-1-git-send-email-k.kozlowski@samsung.com>
 <1391767487-10017-15-git-send-email-k.kozlowski@samsung.com>
 <20140210121405.GH22773@lee--X1>
Message-ID: <1392044761.24553.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-02-10 at 12:14 +0000, Lee Jones wrote:
> > Remove hard-coded values for:
> >  - Fast Charge current,
> >  - End Of Charge current,
> >  - Fast Charge timer,
> >  - Overvoltage Protection Threshold,
> >  - Battery Constant Voltage,
> > and use DTS to configure them. This allows using the max14577 charger
> > driver with different batteries.
> > 
> > Now the charger driver requires valid configuration data from DTS. In
> > case of wrong configuration data it fails during probe. Patch adds
> > of_compatible to the charger mfd cell in MFD driver core.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Jenny Tc <jenny.tc@intel.com>
> > ---
> >  drivers/mfd/max14577.c               |    5 +-
> >  drivers/power/max14577_charger.c     |  234 +++++++++++++++++++++++++++++-----
> >  include/linux/mfd/max14577-private.h |   10 ++
> >  include/linux/mfd/max14577.h         |    8 ++
> >  4 files changed, 227 insertions(+), 30 deletions(-)
> 
> <snip>
> 
> > diff --git a/include/linux/mfd/max14577-private.h b/include/linux/mfd/max14577-private.h
> > index a8cd7de3526a..50cf70bec4d4 100644
> > --- a/include/linux/mfd/max14577-private.h
> > +++ b/include/linux/mfd/max14577-private.h
> > @@ -269,6 +269,16 @@ enum maxim_muic_charger_type {
> >  #define MAX77836_CHARGER_CURRENT_LIMIT_HIGH_STEP	 25000U
> >  #define MAX77836_CHARGER_CURRENT_LIMIT_MAX		475000U
> >  
> > +/* MAX14577 charger End-Of-Charge current limits (as in MAXIM_CHGCTRL5 register), uA */
> 
> Too many chars. Didn't checkpatch.pl complain about this?

I'll fix this.
> 
> > +#define MAX14577_CHARGER_EOC_CURRENT_LIMIT_MIN		50000U
> > +#define MAX14577_CHARGER_EOC_CURRENT_LIMIT_STEP		10000U
> > +#define MAX14577_CHARGER_EOC_CURRENT_LIMIT_MAX		200000U
> > +
> > +/* MAX14577/MAX77836 Battery Constant Voltage (as in MAXIM_CHGCTRL3
> > register), uV */
> 
> Same here

OK
