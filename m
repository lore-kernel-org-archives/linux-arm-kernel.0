From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Nov 2011 09:25:36 -0800
Subject: [PATCH] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <20111123050012.GS19069@tbergstrom-lnx.Nvidia.com>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com>
 <20111118120352.GZ19069@tbergstrom-lnx.Nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74E63@HQMAIL01.nvidia.com>
 <20111121122212.GL19069@tbergstrom-lnx.Nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C0E5@HQMAIL01.nvidia.com>
 <20111123050012.GS19069@tbergstrom-lnx.Nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C6F0@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Tuesday, November 22, 2011 10:00 PM:
...
> I think we need to model the GPIO IRQs as a seperate interrupt controller.
> That way the WM8903 node can refer to the GPIO IRQ as an IRQ without
> hardcoding the global interrupt number, similar to the way we specify the
> SPI number in the device nodes and not the global interrupt number.

Yes, you're right.

I'd originally thought that the GPIO IRQs fed directly into the GIC, but
now that I read the docs, I see that the GPIO controller really is an
interrupt aggregator/controller.

-- 
nvpublic
