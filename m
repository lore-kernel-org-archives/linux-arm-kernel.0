From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 27 May 2015 09:12:48 +0200
Subject: [PATCH V2 3/6] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <20150523174149.GA16004@earth>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com>
 <20150523174149.GA16004@earth>
Message-ID: <55656E70.6030906@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

Am 23.05.2015 um 19:41 schrieb Sebastian Reichel:
> Hi,
>
> On Wed, Apr 29, 2015 at 10:32:24PM +0000, Stefan Wahren wrote:
>> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
>> power subsystem. It's required to trigger the probing of the underlying
>> drivers like on-chip regulators.
> I'm not sure what you need the power supply class for. I see only
> one property (ac connected), which is constant. Maybe just drop
> the power supply stuff?

those SoCs could be powered by 3 different sources:
- 5V wall
- USB
- battery

I choose the first one as a base, because it's the simplest one.
Unfortunately i don't have the time to implement all of them.

The Freescale downstream kernel (based on 2.6.35) [1] has a driver to
handle all MXS power sources. But i think a clean implementation from
the scratch would be necessary for mainline.

> This would leave an almost empty driver, which just sets a single
> register at probe time and probes more drivers. That would probably
> be more fitting for the MFD subsystem.

I don't have any problems with fitting the driver to MFD.

> -- Sebastian

[1] -
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/power/mxs/linux.c?h=imx_2.6.35_maintain
