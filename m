From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 28 Aug 2014 10:05:15 +0000
Subject: [RESEND] clk: ppc-corenet: Add Freescale ARM-based platforms
 CLK_OF_DECLARE support
In-Reply-To: <1409182412.6510.129.camel@snotra.buserror.net>
References: <1408700096-25415-1-git-send-email-jingchang.lu@freescale.com>
 <1409093463.6510.92.camel@snotra.buserror.net>
 <164af7b3be3747a0be3fe3a6cf83d3b1@BL2PR03MB467.namprd03.prod.outlook.com>
 <1409182412.6510.129.camel@snotra.buserror.net>
Message-ID: <f7b4263f189346a391d66c85756b4907@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Wood Scott-B07421
>Sent: Thursday, August 28, 2014 7:34 AM
>To: Lu Jingchang-B35083
>Cc: mturquette at linaro.org; linuxppc-dev at lists.ozlabs.org; linux-
>kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: Re: [RESEND] clk: ppc-corenet: Add Freescale ARM-based platforms
>CLK_OF_DECLARE support
>
>On Tue, 2014-08-26 at 21:19 -0500, Lu Jingchang-B35083 wrote:
>> >-----Original Message-----
>> >From: Wood Scott-B07421
>> >Sent: Wednesday, August 27, 2014 6:51 AM
>> >To: Lu Jingchang-B35083
>> >Cc: mturquette at linaro.org; linuxppc-dev at lists.ozlabs.org; linux-
>> >kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>> >Subject: Re: [RESEND] clk: ppc-corenet: Add Freescale ARM-based
>> >platforms CLK_OF_DECLARE support
>> >
>> >On Fri, 2014-08-22 at 17:34 +0800, Jingchang Lu wrote:
>> >> +CLK_OF_DECLARE(ppc_core_pll_v1, "fsl,qoriq-core-pll-1.0",
>> >core_pll_init);
>> >> +CLK_OF_DECLARE(ppc_core_pll_v2, "fsl,qoriq-core-pll-2.0",
>> >core_pll_init);
>> >> +CLK_OF_DECLARE(ppc_core_mux_v1, "fsl,qoriq-core-mux-1.0",
>> >core_mux_init);
>> >> +CLK_OF_DECLARE(ppc_core_mux_v2, "fsl,qoriq-core-mux-2.0",
>> >core_mux_init);
>> >
>> >What does this do that the existing platform driver and match table
>> >don't?  Why is it needed for ARM when PPC didn't need it?
>> >
>> >-Scott
>> >
>> Common clk init on ARM platform is initialized earlier via
>> of_clk_init() instead of driver probe method, the of_clk_init will
>> walk a __clk_of_table to init each clk provider in the table, the
>> CLK_OF_DECLARE() macro puts a supported clk in the __clk_of_table for it
>initializing on starup, and the clk system has added some common clk such
>as "fixed-clk"
>> to this table already.
>> So here I add our specific clk init declaration to consist this
>> framework, and the driver probe function will not be needed on ARM.
>
>OK... Is there any reason why the new method won't work on PPC?
>
PPC has little dependence on the clock tree but frequency, it will work well
if adopted I think.



Best Regards,
Jingchang
