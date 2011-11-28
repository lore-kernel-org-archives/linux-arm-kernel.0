From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 28 Nov 2011 12:11:32 +0000
Subject: Want to Get Suggestion for MX28 USB Submisson
In-Reply-To: <4ED357E5.7020902@pengutronix.de>
References: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
 <4ED357E5.7020902@pengutronix.de>
Message-ID: <0795792F-631D-450F-9CD7-798CD30C414E@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> On 11/28/2011 04:06 AM, Chen Peter-B29397 wrote:
>> Hi lists:
>> 
>> Tony Lin has submitted Freescale mx28 USB Patch at August 
>> (See: http://www.spinics.net/lists/linux-usb/msg50201.html), but it hasn't been accepted.
>> I would like to re-submit mx28 usb patches, before that, I would like get some suggestion 
>> from you. I think your suggestion will also be benefit for coming mx53, mx50 and mx6q's submission.
>> 
>> All Recently Freescale SoC's USB controller are the same, they are mx23, mx25, mx28, mx31, mx35,
>> mx37, mx50, mx51, mx53, and mx6.
>> But, the transceiver is different between them
>> mx23, mx28, mx6 (Transceiver A)
>> mx25 mx31, mx35,mx37, mx50, mx51, mx53 (Transceiver B)
>> 
>> Current upstream platform information:
>> mx23 mx28 ==> mxs platfrom
>> others (including mx6) ==> mxc platform
>> 
>> Current upstream USB information:
>> mx25, mx3x, mx51: ehci-mxc.c (host), fsl_mxc_udc.c(device, main functions are at fsl_udc_core.c)
>> 
>> My plan of submitting mx28 (mx53,mx50, mx6 later if possible):
>> 1. Replace cpu_is_mxxx() with struct platform_device_id for ehci-mxc.c and fsl_mxc_udc.c
> 
> The cpu_is_mxxx() code in the clock handling code can be removed by
> introducing the missing clocks as no-op clocks on the other cores.
The reason do this is most of driver doesn't accept cpu_is_xx any more.
In order to support mx28 (mx6q later) and coming device tree, I have decided to do this patch

> 
>> 2. Using ehci-mxc.c and fsl_mxc_udc.c for mx28 upstreaming.
>> For Step 2, I have concern that whether mxs platform users will be confused of their
>> usb driver named xxx_mxc, not xxx_mxs?
>> If mxs maintainers think it will cause confusion, I would like to change names to ehci-imx.c
>> and fsl_imx_udc.c for all recent Freescale SoC's (from mx23 to mx6), is it suitable?
>> 3. Create transceiver driver for mx28, and it will also be used for mx6.  
> 
> For the usb device part, I'm supporting with Robert's suggesting, first
> mainline Heikki's otg patches, improve the ci13xxx driver.
I will discuss with Heikki, what's status for this patch, and what
can I help to do it

> 
> cheers, Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
