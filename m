From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Feb 2014 14:24:35 +0000
Subject: [PATCH v2 13/15] regulator/mfd: max14577: Export symbols for
 calculating charger current
In-Reply-To: <20140210115928.GF22773@lee--X1>
References: <1391767487-10017-1-git-send-email-k.kozlowski@samsung.com>
 <1391767487-10017-14-git-send-email-k.kozlowski@samsung.com>
 <20140210115928.GF22773@lee--X1>
Message-ID: <20140210142435.GC23141@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This patch prepares for changing the max14577 charger driver to allow
> > configuring battery-dependent settings from DTS.
> > 
> > The patch moves from regulator driver to MFD core driver and exports:
> >  - function for calculating register value for charger's current;
> >  - table of limits for chargers (MAX14577, MAX77836).
> > 
> > Previously they were used only by the max14577 regulator driver. In next
> > patch the charger driver will use them as well. Exporting them will
> > reduce unnecessary code duplication.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/mfd/max14577.c               |   95 ++++++++++++++++++++++++++++++++++
> >  drivers/regulator/max14577.c         |   80 +++-------------------------
> >  include/linux/mfd/max14577-private.h |   22 ++++----
> >  include/linux/mfd/max14577.h         |   23 ++++++++
> >  4 files changed, 135 insertions(+), 85 deletions(-)
> 
> Applied, with Mark's Ack.

Whoops, jumping the gun there. We're still waiting on Acks aren't we.

Instead:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
