From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Jul 2016 14:25:40 +0100
Subject: [PATCH 1/3] mfd: Provide MACRO to declare commonly defined MFD
 cell attributes
In-Reply-To: <5788E093.7080405@nvidia.com>
References: <20160713112651.14539-1-lee.jones@linaro.org>
 <20160713112651.14539-2-lee.jones@linaro.org>
 <5788E093.7080405@nvidia.com>
Message-ID: <20160718132540.GC17074@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jul 2016, Laxman Dewangan wrote:

> 
> On Wednesday 13 July 2016 04:56 PM, Lee Jones wrote:
> > Cc: Laxman Dewangan <ldewangan@nvidia.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   include/linux/mfd/core.h | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> > index 99c0395..c6018f4 100644
> > --- a/include/linux/mfd/core.h
> > +++ b/include/linux/mfd/core.h
> > @@ -16,6 +16,35 @@
> >   #include <linux/platform_device.h>
> 
> > +#define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
> > +
> > +#define MFD_CELL_RES(_name, _res)					\
> > +	MFD_CELL_ALL(_name, _res, _pdata, 0, 0, NULL, NULL)		\
> > +
> Here _pdata should not be used. Instead it should be NULL.

Yes, it should.  Thanks for the review.

> I corrected it locally and then compiled and teste.

Wonderful, thanks.

> Once above fixed, you can take my ack and tested by
> 
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> Tested-by: Laxman Dewangan <ldewangan@nvidia.com>
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
