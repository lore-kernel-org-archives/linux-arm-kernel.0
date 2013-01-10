From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 10 Jan 2013 09:38:29 +0800
Subject: [PATCH v4 0/7] Add fully tested id switch and vbus connect
 detect support for Chipidea
In-Reply-To: <50ED57EA.6080309@free-electrons.com>
References: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
 <50EC3AD9.8000109@free-electrons.com>
 <20130109032305.GA22404@nchen-desktop>
 <50ED57EA.6080309@free-electrons.com>
Message-ID: <20130110013828.GA27399@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 12:43:38PM +0100, Maxime Ripard wrote:
> Hi Peter,
> 
> Thanks for your answer.
> 
> 
> > Please always enable both device and host mode for chipidea driver.
> > Current code still not consider all things for different mode config,
> > like device-only, host-only, otg.  In future, it is supposed to do
> > at dts file, and judge probe.
> 
> Then isn't the gadget mode configuration option supposed to depends on
> the host mode if it's known to be broken otherwise?

At udc, it uses otg_set_peripheral, which depends on otg. OTG depends on
both host and device are enabled.

In fact, we don't need to use otg_set_peripheral at udc if all usb part
is in chipidea driver, but currently, msm also uses chipidea/udc.c, and
its otg and host is out of chipidea/

I am working on suspend/resume, low power mode and wakeup on chipidea driver.
After that, I will work on it.

> 
> Thanks,
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 

-- 

Best Regards,
Peter Chen
