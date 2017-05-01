From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 1 May 2017 11:33:53 +0530
Subject: [PATCH 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <d18cb12d-1fd1-39d2-501a-18c000b9982e@st.com>
References: <1489414561-28912-1-git-send-email-cedric.madianga@gmail.com>
 <1489414561-28912-3-git-send-email-cedric.madianga@gmail.com>
 <20170406064046.GF4094@localhost>
 <d18cb12d-1fd1-39d2-501a-18c000b9982e@st.com>
Message-ID: <20170501060353.GO6263@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 09:17:37AM +0000, Pierre Yves MORDRET wrote:
> >> +
> >> +	ret = of_property_read_u32(node, "dma-channels",
> >> +				   &dmamux->dmamux_channels);
> >
> > can we have property_xxx calls alone, that way driver is not strictly
> > dependent on of
> 
> Can you please explain what you are asking for ? Not sure to understand 
> correctly.

Use device_property_read_u32() which is a generic property API.


> >> +static int __init stm32_dmamux_init(void)
> >> +{
> >> +	return platform_driver_register(&stm32_dmamux_driver);
> >> +}
> >> +arch_initcall(stm32_dmamux_init);
> >
> > why not module init, wouldnt defer probe solve the dependencies
> >
> 
> The reason behind many devices (device_initcall level) rely on DMAs. If 
> init is deferred DMAMUX driver will be probed twice if dependents rely 
> on it. This sounds not a good call. This explains arch_initcall level.

Why not deferred probe was introduced to help with dependencies...

-- 
~Vinod
