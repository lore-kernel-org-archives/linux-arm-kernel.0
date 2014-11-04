From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 04 Nov 2014 08:51:50 +0100
Subject: [PATCH v3 08/14] mfd: max77686/802: Remove support for board files
In-Reply-To: <20141103170128.GD12011@x1>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-9-git-send-email-k.kozlowski@samsung.com>
 <20141103170128.GD12011@x1>
Message-ID: <1415087510.2389.4.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-11-03 at 17:01 +0000, Lee Jones wrote:
> On Thu, 30 Oct 2014, Krzysztof Kozlowski wrote:
> 
> > The driver is used only on Exynos based boards with DTS support.
> > Convert the driver to DTS-only version. This simplifies a little the
> > code:
> > 1. No dead (unused) entries in platform_data structure.
> > 2. More code removed.
> > 3. Regulator driver does not depend on allocated memory
> >    from MFD driver.
> > 4. It makes also easier extending the regulator driver.
> > 
> > Add to the max77686 MFD driver dependency on CONFIG_OF because without
> > DTS the regulator drivers won't bind.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > ---
> >  drivers/mfd/Kconfig                  |  1 +
> >  drivers/mfd/max77686.c               | 23 -----------------------
> >  include/linux/mfd/max77686-private.h |  1 -
> >  include/linux/mfd/max77686.h         | 28 ----------------------------
> >  4 files changed, 1 insertion(+), 52 deletions(-)
> 
> Applied, thanks.


Noooo, don't apply it. It depends on previous patches removing the board
file support from regulators.

If the patch looks OK, please only ack it. I would like to push
everything through regulator tree.

Best regards,
Krzysztof
