From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 18:03:45 +0000
Subject: [PATCH 09/17] ASoC: Tegra I2S: Remove dependency on pdev->id
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C711@HQMAIL01.nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-10-git-send-email-swarren@nvidia.com>
 <20111123110338.GC21073@opensource.wolfsonmicro.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C711@HQMAIL01.nvidia.com>
Message-ID: <20111123180345.GJ30049@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 09:54:21AM -0800, Stephen Warren wrote:
> Mark Brown wrote at Wednesday, November 23, 2011 4:04 AM:

> > This should really be part of the same commit as the arch/arm side
> > change in order to avoid bisection breaks as from the point of view of
> > non-DT systems it's moving the number into the name.

> Sorry, I don't quite follow here; the original hard-coded dai structures
> already had the ID in the name, and hence exactly match the platform
> device names tegra-i2s.0 and tegra-i2s.1:

If you're renaming the devices I'd expect the device to driver binding
to break as the device name changes - actually looking at the code again
I'm a bit depressed that the platform driver binding works at all with
this as you've not renamed the driver but you have renamed the devices
and they're still binding.  I'd have expected the match to be on a
(name, id) not on the result of rendering those down to a display name.

The whole bodge here just smells a bit to be honest, we ought to be able
to match things up without jumping through this hoop.
