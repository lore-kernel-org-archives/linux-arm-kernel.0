From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 19 Oct 2016 11:53:30 +0300
Subject: [PATCH 2/3] ARM: bus: da8xx-syscfg: new driver
In-Reply-To: <CAMpxmJXwZ8pQ58OgV4w88yNuG1Fd8++1yP-Frd2QJFO9uJJueQ@mail.gmail.com>
References: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
 <4369153.vCOQzI7OET@avalon>
 <CAMpxmJXwZ8pQ58OgV4w88yNuG1Fd8++1yP-Frd2QJFO9uJJueQ@mail.gmail.com>
Message-ID: <2278105.geKhb8xoNC@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Wednesday 19 Oct 2016 10:26:57 Bartosz Golaszewski wrote:
> 2016-10-18 22:49 GMT+02:00 Laurent Pinchart:
> > On Monday 17 Oct 2016 18:30:49 Bartosz Golaszewski wrote:
> >> Create the driver for the da8xx System Configuration and implement
> >> support for writing to the three Master Priority registers.
> >> 
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> [snip]
> 
> >> +
> >> +Documentation:
> >> +OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
> >> +
> >> +Required properties:
> >> +
> >> +- compatible:                "ti,da850-syscfg"
> > 
> > Don't you need a reg property ?
> 
> Yes, Kevin already pointed that out. I'll add it in v2. Same for [1/3].
> 
> >> +Optional properties:
> >> +
> >> +The below properties are used to specify the priority of master
> >> peripherals.
> >> +They must be between 0-7 where 0 is the highest priority and 7 is the
> >> lowest.
> >> +
> >> +- ti,pri-arm-i:              ARM_I port priority.
> >> +
> >> +- ti,pri-arm-d:              ARM_D port priority.
> >> +
> >> +- ti,pri-upp:                uPP port priority.
> >> +
> >> +- ti,pri-sata:               SATA port priority.
> >> +
> >> +- ti,pri-pru0:               PRU0 port priority.
> >> +
> >> +- ti,pri-pru1:               PRU1 port priority.
> >> +
> >> +- ti,pri-edma30tc0:  EDMA3_0_TC0 port priority.
> >> +
> >> +- ti,pri-edma30tc1:  EDMA3_0_TC1 port priority.
> >> +
> >> +- ti,pri-edma31tc0:  EDMA3_1_TC0 port priority.
> >> +
> >> +- ti,pri-vpif-dma-0: VPIF DMA0 port priority.
> >> +
> >> +- ti,pri-vpif-dma-1: VPIF DMA1 port priority.
> >> +
> >> +- ti,pri-emac:               EMAC port priority.
> >> +
> >> +- ti,pri-usb0cfg:    USB0 CFG port priority.
> >> +
> >> +- ti,pri-usb0cdma:   USB0 CDMA port priority.
> >> +
> >> +- ti,pri-uhpi:               HPI port priority.
> >> +
> >> +- ti,pri-usb1:               USB1 port priority.
> >> +
> >> +- ti,pri-lcdc:               LCDC port priority.
> > 
> > I'm afraid this looks more like system configuration than hardware
> > description to me.
> 
> While you're certainly right, this approach is already implemented in
> several other memory and bus drivers and it was also suggested by
> Sekhar in one of the tilcdc rev1 threads. There's also no real
> alternative that I know of.

The fact that other drivers get it wrong is no excuse for copying them :-)

> > There was a BoF session about how to support this kind of performance
> > knobs at ELCE last week:
> > https://openiotelceurope2016.sched.org/event/7rss/bof-linux-device-perfor
> > mance-framework-michael-turquette-baylibre :-)
>
> I know, I was there. ;)

That's why I mentioned it :-)

> Unfortunately it was just a discussion about potential approaches -
> there's no code yet.

Patches are welcome ;-)

-- 
Regards,

Laurent Pinchart
