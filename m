From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Jun 2012 09:54:22 -0600
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <20120614121234.GC3913@opensource.wolfsonmicro.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
Message-ID: <4FDA092E.10301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2012 06:12 AM, Mark Brown wrote:
> On Thu, Jun 14, 2012 at 08:31:20AM +0200, Thierry Reding wrote:
>> On Wed, Jun 13, 2012 at 03:17:06PM -0600, Stephen Warren wrote:
> 
>>> The core of the issue is that:
> 
>>> * Tegra30 support is via device tree. * We have an SDIO bus,
>>> and the WiFi device attached to that bus is enumerable. * Since
>>> the WiFi device is enumerable, no node exists in the DT to 
>>> represent it. * However, the driver for the WiFi device needs
>>> certain information, such as the reset GPIO ID and perhaps
>>> power GPIO.
> 
>> PCI devices are also enumerable and yet they can be matched up
>> with nodes in the device tree. Perhaps something similar could be
>> added for the SDIO bus?
> 
> This seems to make the most sense - pushing this through the
> regulator API is just a bodge.

Yes, that seems reasonable.

Presumably the power GPIO should be a fixed regulator though, since it
is a power control not just a plain old GPIO? That said, the current
driver apparently deals with this as a GPIO already.

The reset GPIO can separately/directly controlled by the WiFi driver
though.
