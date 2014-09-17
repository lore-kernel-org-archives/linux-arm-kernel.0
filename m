From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 17 Sep 2014 20:04:01 +0100
Subject: [PATCH 7/9] phy: remove .owner field for drivers using
 module_platform_driver
In-Reply-To: <5419B485.8010002@ti.com>
References: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
 <1408106416-19044-8-git-send-email-peter.griffin@linaro.org>
 <5419B485.8010002@ti.com>
Message-ID: <20140917190401.GA31237@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Wed, 17 Sep 2014, Kishon Vijay Abraham I wrote:

> Hi,
> 
> On Friday 15 August 2014 06:10 PM, Peter Griffin wrote:
> > This patch removes the superflous .owner field for drivers which
> > use the module_platform_driver or platform_driver_register api,
> > as this is overriden in __platform_driver_register.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

<snip>
> >  drivers/phy/phy-twl4030-usb.c       | 1 -
> 
> twl4030-usb doesn't use module_platform_driver. Care to resend this patch
> along? I've merged all other patches in this series.

That is true, but it does use platform_driver_register  whih overrides .owner.
So the patch is stil good I think (fyi see include/linux/platform_device.h).

regards,

Peter.
