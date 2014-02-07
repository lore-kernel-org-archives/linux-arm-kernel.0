From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 07 Feb 2014 11:46:14 +0100
Subject: [PATCH v2 14/15] charger: max14577: Configure battery-dependent
 settings from DTS
In-Reply-To: <20140207104238.GH14727@lee--X1>
References: <1391767487-10017-1-git-send-email-k.kozlowski@samsung.com>
 <1391767487-10017-15-git-send-email-k.kozlowski@samsung.com>
 <20140207104238.GH14727@lee--X1>
Message-ID: <1391769974.12119.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-07 at 10:42 +0000, Lee Jones wrote:
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
> 
> I already acked the MFD parts of this. Or has the patch changed?

Hi,

This patch is new in v2 so you haven't acked it yet. I need your ACK
here and in 13/15 (regulator/mfd: max14577: Export symbols for
calculating charger current).

Best regards,
Krzysztof


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
