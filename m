From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 14 Jun 2017 11:46:11 +0200
Subject: [PATCH] tee: add forward declaration for struct device
In-Reply-To: <2bcbf7b0-7dba-7e72-72fd-4da922e442bb@linaro.org>
References: <6344683a299d05692ed64ddb963343ea9547add4.1496229347.git.jerome.forissier@linaro.org>
 <2bcbf7b0-7dba-7e72-72fd-4da922e442bb@linaro.org>
Message-ID: <20170614094610.GA12598@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 11:39:50AM +0200, Jerome Forissier wrote:
> [+Arnd]
> 
> Ping?
> 
> Thanks,
> -- 
> Jerome
> 
> On 05/31/2017 01:21 PM, Jerome Forissier wrote:
> > tee_drv.h references struct device, but does not include device.h nor
> > platform_device.h. Therefore, if tee_drv.h is included by some file
> > that does not pull device.h nor platform_device.h beforehand, we have a
> > compile warning. Fix this by adding a forward declaration.
> > 
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  include/linux/tee_drv.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 8614713..07bd226 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -29,6 +29,7 @@
> >  #define TEE_SHM_DMA_BUF		BIT(1)	/* Memory with dma-buf handle */
> >  #define TEE_SHM_EXT_DMA_BUF	BIT(2)	/* Memory with dma-buf handle */
> >  
> > +struct device;
> >  struct tee_device;
> >  struct tee_shm;
> >  struct tee_shm_pool;
> > 

Looks good to me.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

--
Thanks,
Jens
