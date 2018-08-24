From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 24 Aug 2018 10:37:12 +0200
Subject: [PATCH v1 3/7] mfd: add atmel-lcdc driver
In-Reply-To: <1afc6d63-094b-3bff-87e9-d2354602ba76@microchip.com>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org>
 <20180815052435.GA6412@dell> <20180815204041.GA29041@ravnborg.org>
 <1afc6d63-094b-3bff-87e9-d2354602ba76@microchip.com>
Message-ID: <20180824103712.1d889f17@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Aug 2018 10:28:54 +0200
Nicolas Ferre <nicolas.ferre@microchip.com> wrote:

> On 15/08/2018 at 22:40, Sam Ravnborg wrote:
> > Hi Lee.
> >   
> >>> +
> >>> +static const struct mfd_cell lcdc_cells[] = {
> >>> +	{
> >>> +		.name = "atmel-lcdc-pwm",
> >>> +		.of_compatible = "atmel,lcdc-pwm",
> >>> +	},
> >>> +	{
> >>> +		.name = "atmel-lcdc-dc",
> >>> +		.of_compatible = "atmel,lcdc-display-controller",
> >>> +	},
> >>> +};  
> >>
> >> Will you be adding any more devices, or is this the entirety of the
> >> device?  If the latter, I suggest that this doesn't warrant being an
> >> MFD.  
> > Thats it. And others agree with you that this is not a good approach.
> > So in v2 there will be no MFD.
> > 
> > Thanks for confirming that the non-mfd way is the better approach.  
> 
> MFD approach would have had the benefit of keeping this driver series 
> architecture close to the HLCD one. This would have been easier to 
> understand and use one SoC or another one from the AT91 product line....
> 
> Anyway, I'd wait for Boris' feedback for making a decision.

If possible I'd like to keep the MFD approach, but let's see if we can
have a single node in the DT instead of one for the MFD and 2 child
nodes (for the display controller and the PWM).
