From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 6 Aug 2011 01:15:13 +0900
Subject: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049F171EF4@HQMAIL01.nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<1312498820-2275-2-git-send-email-swarren@nvidia.com>
	<20110805000148.GB13321@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049F171EC1@HQMAIL01.nvidia.com>
	<20110805053510.GA16956@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049F171EF4@HQMAIL01.nvidia.com>
Message-ID: <20110805161511.GB3438@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 08:29:38AM -0700, Stephen Warren wrote:
> Mark Brown wrote at Thursday, August 04, 2011 11:35 PM:

> > But it's not a bug to use a GPIO as an IRQ source, otherwise we wouldn't
> > have gpio_to_irq() in the first place.

> 2) Two pieces of unrelated code somehow accidentally get a GPIO and IRQ
> number that map to the same resource, e.g. due to incorrect board files or
> Device Tree content. This is probably a bug, but ends up looking exactly
> the same as far as the IRQ code's gpio_request call failing in the patch I
> posted.

Right, but this doesn't mean we can break the legitimate users to catch
the buggy ones.
