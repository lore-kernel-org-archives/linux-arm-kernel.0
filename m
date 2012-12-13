From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 12 Dec 2012 18:16:35 -0800
Subject: [PATCH v4 0/7] enable support for AMBA drivers under x86
In-Reply-To: <50C93718.2090706@zytor.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <50C93718.2090706@zytor.com>
Message-ID: <50C93A83.8040106@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 06:02 PM, H. Peter Anvin wrote:
> Hmm... with this patchset on top of v3.7 I still get a bunch of warnings
> and errors.
>
> More details when the build completes (if it does.)  I might still push
> out the branch to let Fengguang's test robot take it for a spin.
>

Build failure:

o.i386-allconfig/make.log:make[4]: *** [drivers/gpio/gpio-pl061.o] Error 1
o.i386-allconfig/make.log:make[3]: *** [drivers/gpio] Error 2

Warnings:

/home/hpa/kernel/tip.x86-amba/drivers/dma/amba-pl08x.c:848:3: warning: 
format ?%x? expects argument of type ?unsigned int?, but argument 4 has 
type ?dma_addr_t? [-Wformat]
/home/hpa/kernel/tip.x86-amba/drivers/dma/amba-pl08x.c:848:3: warning: 
format ?%x? expects argument of type ?unsigned int?, but argument 7 has 
type ?dma_addr_t? [-Wformat]
/home/hpa/kernel/tip.x86-amba/arch/x86/pci/sta2x11-fixup.c:186:2: 
warning: initialization from incompatible pointer type [enabled by default]
/home/hpa/kernel/tip.x86-amba/arch/x86/pci/sta2x11-fixup.c:186:2: 
warning: (near initialization for ?sta2x11_dma_ops.free?) [enabled by 
default]
/home/hpa/kernel/tip.x86-amba/drivers/extcon/extcon-max77693.c:355:10: 
warning: ?adclow? may be used uninitialized in this function 
[-Wmaybe-uninitialized]
/home/hpa/kernel/tip.x86-amba/drivers/extcon/extcon-max77693.c:355:10: 
warning: ?adc1k? may be used uninitialized in this function 
[-Wmaybe-uninitialized]
/home/hpa/kernel/tip.x86-amba/drivers/extcon/extcon-max77693.c:355:10: 
warning: ?adc? may be used uninitialized in this function 
[-Wmaybe-uninitialized]

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
