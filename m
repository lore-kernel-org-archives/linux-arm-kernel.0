From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Aug 2012 15:14:14 +0100
Subject: omap_device: query on "fck" clk alias created
In-Reply-To: <50191F00.1040501@ti.com>
References: <50191F00.1040501@ti.com>
Message-ID: <20120801141414.GM7405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 05:50:16PM +0530, Vaibhav Hiremath wrote:
> The clk_get() api will not work, unless we pass both the arguments (dev,
> con_id) properly. Now expecting driver to always label con_id with "fck"
> is undesirable, as the same driver can be reused on multiple platforms,
> which can be non-omap and/or non-ti platforms.

Why not?

The connection ID is defined by the driver, and the platform stuff is
expected to provide drivers with what they require.  It's not the other
way around (platforms don't tell drivers what they require.)

In other words, if the device has two clocks, one called ick and one called
fck, then the device _should_ use clk_get() specifying "ick" for one, and
"fck" for the other.

And platforms better provide an "ick" and a "fck" for the device, even if
they have no respresentation for one or other of them (in which case you
supply a dummy clock.)
