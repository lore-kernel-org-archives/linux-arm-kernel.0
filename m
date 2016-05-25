From: nm@ti.com (Nishanth Menon)
Date: Wed, 25 May 2016 11:09:50 -0500
Subject: [PATCH 0/2] arm: dra7: Add i2c6 instance hwmod and dt entries
In-Reply-To: <20160525125341.10044-1-rk@ti.com>
References: <20160525125341.10044-1-rk@ti.com>
Message-ID: <5745CE4E.3020903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2016 07:53 AM, Ravikumar Kattekola wrote:
> DRA72x devices have a sixth i2c ocntroller instance.
> Following patches add the required hwmod structure and
> device tree nodes.
> 
> Reference doc: DRA72x TRM [ SPRUHP2Q ]
> 
> Tested on :
> DRA72x Rev B EVM
> 
> Ravikumar Kattekola (2):
>   arm: dra7: Add hwmod entry for i2c6
>   dts: dra7: Add device tree node for i2c6
> 
>  arch/arm/boot/dts/dra7.dtsi               | 11 +++++++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 23 +++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
NAK. reasoning:
a) i2c6 is a custom IP integration with completely non-standard
dependencies with cross device dependencies for pretty much a specific
usecase -> usage is pretty much limited for generic support - the
decision is NOT to support this instance in Linux kernel - internal
discussion forwarded to developer.
b) the patches themselves are wrong -> it applies to DRA72x not
generic DRA7x platform
c) patches themselves are in the wrong format (wrong subject line etc).
d) patches don't handle the SoC internal device dependencies either ->
in short will not function in a generic solution for all variations of
platforms.

-- 
Regards,
Nishanth Menon
