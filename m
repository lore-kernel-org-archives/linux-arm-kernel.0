From: kishon@ti.com (kishon)
Date: Wed, 30 Jan 2013 11:21:35 +0530
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130129203050.GT1906@pengutronix.de>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com> <20130129203050.GT1906@pengutronix.de>
Message-ID: <5108B4E7.4020505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013 02:00 AM, Sascha Hauer wrote:
> On Tue, Jan 29, 2013 at 07:14:51PM +0530, kishon wrote:
>> Hi,
>>
>> On Tuesday 29 January 2013 04:52 PM, Sascha Hauer wrote:
>>> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>>
>>> This adds two little devicetree helper functions for determining the
>>> dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
>>> the devicetree.
>>>
>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>
>>> The properties and their values have been taken from the fsl-mph-dr driver.
>>> This binding is also documented (though currently not used) for the tegra
>>> ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
>>> This is a first attempt to parse these bindings at a common place so that
>>> others can make use of it.
>>>
>>> Basically I want to know whether this binding is recommended for new drivers
>>> since normally the devicetree uses '-' instead of '_', and maybe there are
>>> other problems with it.
>>>
>>> I need this binding for the chipidea driver. I suspect that the fsl-mph-dr
>>> driver also really handles a chipidea core.
>>>
>>> Should we agree on this I would convert the fsl-mph-dr driver to use these
>>> helpers.
>>>
>>> Sascha
>>>
>>>   drivers/usb/core/Makefile |    1 +
>>>   drivers/usb/core/of.c     |   76 +++++++++++++++++++++++++++++++++++++++++++++
>>
>> This file should ideally go into drivers/usb/phy/.
>
> I originally wanted to do that, but the host/peripheral/otg property is
> not phy specific. DO you still want to move it there?

I think then you can just move of_usb_get_phy_mode() to phy/of.c.
Then we can also move some functions defined in otg.c (specific to PHY 
and dt) to phy/of.c.

Thanks
Kishon
