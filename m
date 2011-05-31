From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 May 2011 22:21:42 +0100
Subject: [RFC PATCH v4] Consolidate SRAM support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D234457@dbde02.ent.ti.com>
References: <20110512174546.GB8633@n2100.arm.linux.org.uk>
	<1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D234457@dbde02.ent.ti.com>
Message-ID: <20110531212142.GA6700@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 10:39:48PM +0530, Nori, Sekhar wrote:
> I also found some check patch errors. Feel free to merge
> the attached patch.

And this introduces another style issue...

> diff --git a/arch/arm/plat-mxc/include/mach/iram.h b/arch/arm/plat-mxc/include/mach/iram.h
> index 8279c47..aae5e35 100644
> --- a/arch/arm/plat-mxc/include/mach/iram.h
> +++ b/arch/arm/plat-mxc/include/mach/iram.h
> @@ -31,7 +31,7 @@ static inline void *iram_alloc(size_t size, phys_addr_t *phys)
>  
>  	*phys = gen_pool_virt_to_phys(iram_pool, addr);
>  
> -	return (void*)addr;
> +	return (void *) addr;

The style here is:
	return (void *)addr;
