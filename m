From: jerome.forissier@linaro.org (Jerome Forissier)
Date: Wed, 14 Jun 2017 11:39:50 +0200
Subject: [PATCH] tee: add forward declaration for struct device
In-Reply-To: <6344683a299d05692ed64ddb963343ea9547add4.1496229347.git.jerome.forissier@linaro.org>
References: <6344683a299d05692ed64ddb963343ea9547add4.1496229347.git.jerome.forissier@linaro.org>
Message-ID: <2bcbf7b0-7dba-7e72-72fd-4da922e442bb@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+Arnd]

Ping?

Thanks,
-- 
Jerome

On 05/31/2017 01:21 PM, Jerome Forissier wrote:
> tee_drv.h references struct device, but does not include device.h nor
> platform_device.h. Therefore, if tee_drv.h is included by some file
> that does not pull device.h nor platform_device.h beforehand, we have a
> compile warning. Fix this by adding a forward declaration.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  include/linux/tee_drv.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 8614713..07bd226 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -29,6 +29,7 @@
>  #define TEE_SHM_DMA_BUF		BIT(1)	/* Memory with dma-buf handle */
>  #define TEE_SHM_EXT_DMA_BUF	BIT(2)	/* Memory with dma-buf handle */
>  
> +struct device;
>  struct tee_device;
>  struct tee_shm;
>  struct tee_shm_pool;
> 
