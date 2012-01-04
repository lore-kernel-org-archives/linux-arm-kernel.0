From: manjunath.hadli@ti.com (Hadli, Manjunath)
Date: Wed, 4 Jan 2012 07:37:43 +0000
Subject: [PATCH v7 5/8] davinci: dm644x: change vpfe capture structure
 variables for consistency
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B724A949@DFLE34.ent.ti.com>
References: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
 <1324475021-32509-6-git-send-email-manjunath.hadli@ti.com>
 <3E54258959B69E4282D79E01AB1F32B724A949@DFLE34.ent.ti.com>
Message-ID: <E99FAA59F8D8D34D8A118DD37F7C8F75019E17@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Murali,

On Wed, Dec 21, 2011 at 20:25:23, Karicheri, Muralidharan wrote:
> original Message-----
> >> From: davinci-linux-open-source-bounces+m-
> >> karicheri2=ti.com at linux.davincidsp.com 
> >> [mailto:davinci-linux-open-source-
> >> bounces+m-karicheri2=ti.com at linux.davincidsp.com] On Behalf Of Hadli,
> >> Manjunath
> >> Sent: Wednesday, December 21, 2011 8:44 AM
> >> To: dlos; LAK
> >> Subject: [PATCH v7 5/8] davinci: dm644x: change vpfe capture 
> >> structure variables for consistency
> >> 
> >> Add SoC and board prefixes to variable names so that it is consistent 
> >> with the rest of the file.
> >> 
> >> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> >> Acked-by: Sekhar Nori <nsekhar@ti.com>
> >> ---
> >>  arch/arm/mach-davinci/board-dm644x-evm.c |   24 ++++++++++++------------
> >>  arch/arm/mach-davinci/dm644x.c           |   12 ++++++------
> >>  2 files changed, 18 insertions(+), 18 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c 
> >> b/arch/arm/mach- davinci/board-dm644x-evm.c index 6d76d7c..7d940f5 
> >> 100644
> >> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> >> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> >> @@ -190,7 +190,7 @@ static struct platform_device davinci_fb_device = {
> >>  	.num_resources = 0,
> >>  };
> >> 
> >> -static struct tvp514x_platform_data tvp5146_pdata = {
> >> +static struct tvp514x_platform_data dm644xevm_tvp5146_pdata = {
> >>  	.clk_polarity = 0,
> >>  	.hs_polarity = 1,
> >>  	.vs_polarity = 1
> >> @@ -198,7 +198,7 @@ static struct tvp514x_platform_data tvp5146_pdata 
> >> = {
> >> 
> >>  #define TVP514X_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
> >>  /* Inputs available at the TVP5146 */ -static struct v4l2_input 
> >> tvp5146_inputs[] = {
> >> +static struct v4l2_input dm644xevm_tvp5146_inputs[] = {
> >>  	{
> >>  		.index = 0,
> >>  		.name = "Composite",
> >> @@ -218,7 +218,7 @@ static struct v4l2_input tvp5146_inputs[] = {
> >>   * ouput that goes to vpfe. There is a one to one correspondence
> >>   * with tvp5146_inputs
> >>   */
> >> -static struct vpfe_route tvp5146_routes[] = {
> >> +static struct vpfe_route dm644xevm_tvp5146_routes[] = {
> >>  	{
> >>  		.input = INPUT_CVBS_VI2B,
> >>  		.output = OUTPUT_10BIT_422_EMBEDDED_SYNC, @@ -229,13 +229,13 @@ 
> >> static struct vpfe_route tvp5146_routes[] = {
> >>  	},
> >>  };
> >> 
> >> -static struct vpfe_subdev_info vpfe_sub_devs[] = {
> >> +static struct vpfe_subdev_info dm644xevm_vpfe_sub_devs[] = {
> >>  	{
> >>  		.name = "tvp5146",
> >>  		.grp_id = 0,
> >> -		.num_inputs = ARRAY_SIZE(tvp5146_inputs),
> >> -		.inputs = tvp5146_inputs,
> >> -		.routes = tvp5146_routes,
> >> +		.num_inputs = ARRAY_SIZE(dm644xevm_tvp5146_inputs),
> >> +		.inputs = dm644xevm_tvp5146_inputs,
> >> +		.routes = dm644xevm_tvp5146_routes,
> >>  		.can_route = 1,
> >>  		.ccdc_if_params = {
> >>  			.if_type = VPFE_BT656,
> >> @@ -244,15 +244,15 @@ static struct vpfe_subdev_info vpfe_sub_devs[] = {
> >>  		},
> >>  		.board_info = {
> >>  			I2C_BOARD_INFO("tvp5146", 0x5d),
> >> -			.platform_data = &tvp5146_pdata,
> >> +			.platform_data = &dm644xevm_tvp5146_pdata,
> >>  		},
> >>  	},
> >>  };
> >> 
> >> -static struct vpfe_config vpfe_cfg = {
> >> -	.num_subdevs = ARRAY_SIZE(vpfe_sub_devs),
> >> +static struct vpfe_config dm644xevm_capture_cfg = {
> >> +	.num_subdevs = ARRAY_SIZE(dm644xevm_vpfe_sub_devs),
> >>  	.i2c_adapter_id = 1,
> >> -	.sub_devs = vpfe_sub_devs,
> >> +	.sub_devs = dm644xevm_vpfe_sub_devs,
> >>  	.card_name = "DM6446 EVM",
> >>  	.ccdc = "DM6446 CCDC",
> >>  };
> >> @@ -626,7 +626,7 @@ static void __init
> >>  davinci_evm_map_io(void)
> >>  {
> >>  	/* setup input configuration for VPFE input devices */
> >> -	dm644x_set_vpfe_config(&vpfe_cfg);
> >> +	dm644x_set_vpfe_config(&dm644xevm_capture_cfg);
> >>  	dm644x_init();
> >>  }
> >> 
> >> diff --git a/arch/arm/mach-davinci/dm644x.c 
> >> b/arch/arm/mach-davinci/dm644x.c index 97aecf2..acd9ee2 100644
> >> --- a/arch/arm/mach-davinci/dm644x.c
> >> +++ b/arch/arm/mach-davinci/dm644x.c
> >> @@ -614,7 +614,7 @@ static struct platform_device dm644x_vpss_device = {
> >>  	.resource		= dm644x_vpss_resources,
> >>  };
> >> 
> >> -static struct resource vpfe_resources[] = {
> >> +static struct resource dm644x_vpfe_resources[] = {
> >>  	{
> >>  		.start          = IRQ_VDINT0,
> >>  		.end            = IRQ_VDINT0,
> >> @@ -648,11 +648,11 @@ static struct platform_device dm644x_ccdc_dev = {
> >>  	},
> >>  };
> >> 
> >> -static struct platform_device vpfe_capture_dev = {
> >> +static struct platform_device dm644x_vpfe_dev = {
> >>  	.name		= CAPTURE_DRV_NAME,
> >>  	.id		= -1,
> >> -	.num_resources	= ARRAY_SIZE(vpfe_resources),
> >> -	.resource	= vpfe_resources,
> >> +	.num_resources	= ARRAY_SIZE(dm644x_vpfe_resources),
> >> +	.resource	= dm644x_vpfe_resources,
> >>  	.dev = {
> >>  		.dma_mask		= &vpfe_capture_dma_mask,
> >>  		.coherent_dma_mask	= DMA_BIT_MASK(32),
> >> @@ -661,7 +661,7 @@ static struct platform_device vpfe_capture_dev = 
> >> {
> >> 
> >>  void dm644x_set_vpfe_config(struct vpfe_config *cfg)  {
> >> -	vpfe_capture_dev.dev.platform_data = cfg;
> >> +	dm644x_vpfe_dev.dev.platform_data = cfg;
> >>  }
> >> 
> >>  
> >> /*-------------------------------------------------------------------
> >> ---*/ @@ -809,7 +809,7 @@ static int __init dm644x_init_devices(void)
> >> 
> >>  	platform_device_register(&dm644x_vpss_device);
> >>  	platform_device_register(&dm644x_ccdc_dev);
> >> -	platform_device_register(&vpfe_capture_dev);
> >> +	platform_device_register(&dm644x_vpfe_dev);
> >> 
> 
> Just a suggestion. Why don't we change these with platform_add_devices() API call and register all of the video devices in once call instead of separate calls to platform_device_register?
Thak you for the comment. In later patches we have a need to register three subsets of devices - vpfe, vpss and vpbe. So to make things simple, I have used this generic way. I suggest we keep the current format.

Thx,
-Manju

> 
> >>  	return 0;
> >>  }
> >> --
> >> 1.6.2.4
> >> 
> >> _______________________________________________
> >> Davinci-linux-open-source mailing list 
> >> Davinci-linux-open-source at linux.davincidsp.com
> >> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
