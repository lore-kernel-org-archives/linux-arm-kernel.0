From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Dec 2014 14:38:50 +0000
Subject: [PATCH 5/8] mfd: Add ST's Low Power Controller driver
In-Reply-To: <5276146.VV460E9Y1P@wuerfel>
References: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
 <2928949.OKYp272uiY@wuerfel> <20141215135052.GC13885@x1>
 <5276146.VV460E9Y1P@wuerfel>
Message-ID: <20141215143850.GD13885@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Dec 2014, Arnd Bergmann wrote:

> On Monday 15 December 2014 13:50:52 Lee Jones wrote:
> > > > 
> > > 
> > > I don't think it's necessary to have the MFD node if only one of the
> > > two modes can be used based on a DT property. It should be enough
> > > to have both the rtc and the wdt driver list the same compatible
> > > string and check the property in the probe function to decide if
> > > they want to drive the device or not:
> > 
> > I tried that and it didn't work.  Only one driver probed.
> > 
> > 
> 
> Strange, the code in really_probe() and the comment in device_attach()
> suggest that this is not the intentional behavior. What error
> code did you return? If it's -ENODEV or -ENXIO, it should keep
> trying the other drivers, otherwise it will give up.

Oh I see.  So if I return -ENODEV it will keep trying to bind with
other drivers.  I'll try that and report back.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
