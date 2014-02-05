From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 05 Feb 2014 11:48:16 +0100
Subject: [PATCH 08/18] mfd: max14577: Rename state container to maxim_core
In-Reply-To: <20140203094258.GI13529@lee--X1>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-9-git-send-email-k.kozlowski@samsung.com>
 <20140203094258.GI13529@lee--X1>
Message-ID: <1391597296.3726.13.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Cc: Chanwoo, Mark and Dmitry for ACK-s on their subsystems.

Krzysztof Kozlowski

On Mon, 2014-02-03 at 09:42 +0000, Lee Jones wrote:
> > This patch continues the preparation for adding support for max77836
> > device to existing max14577 driver.
> > 
> > The patch renames the struct "max14577" state container to "maxim_core".
> > This is only a rename-like patch, new code is not added.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/extcon/extcon-max14577.c     |   22 +++++------
> >  drivers/mfd/max14577.c               |   68 +++++++++++++++++-----------------
> >  drivers/power/max14577_charger.c     |   16 ++++----
> >  drivers/regulator/max14577.c         |    6 +--
> >  include/linux/mfd/max14577-private.h |    5 ++-
> >  5 files changed, 60 insertions(+), 57 deletions(-)
> 
> Need some more maintainer Acks here.
> 
> > -struct max14577 {
> > +/*
> > + * State container for max14577-like drivers.
> > + */
> 
> I don't think this comment is required.
> 
> Besides that, the code looks fine:
>   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> > +struct maxim_core {
> >  	struct device *dev;
> >  	struct i2c_client *i2c; /* Slave addr = 0x4A */
> >  
> 
