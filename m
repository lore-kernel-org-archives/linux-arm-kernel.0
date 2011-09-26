From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 26 Sep 2011 11:18:56 -0700
Subject: [PATCH 1/7] OMAP: PM: omap_device: add omap_hwmod_name_get_odev
In-Reply-To: <1314026347-21623-2-git-send-email-b-cousson@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-2-git-send-email-b-cousson@ti.com>
Message-ID: <4E80C210.8090200@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2011 08:19 AM, Benoit Cousson wrote:
> From: Nishanth Menon<nm@ti.com>
>
> An API which translates a standard hwmod name to corresponding
> omap_device is useful for drivers when they need to look up the
> device associated with a hwmod name to map back into the device
> structure pointers. These ideally should be used by drivers in
> mach directory. Using a generic hwmod name like "gpu" instead of
> the actual device name which could change in the future, allows
> us to:
> a) Could in effect help replace apis such as omap2_get_mpuss_device,
> omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device,
> etc..
> b) Scale to more devices rather than be restricted to named functions
> c) Simplify driver's platform_data from passing additional fields
> all doing the same thing with different function pointer names
> just for accessing a different device name.
>
> Signed-off-by: Nishanth Menon<nm@ti.com>
> [b-cousson at ti.com: rebased on top of Kevin's changes]
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> ---
>   arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>   arch/arm/plat-omap/omap_device.c              |   32 +++++++++++++++++++++++++
>   2 files changed, 33 insertions(+), 0 deletions(-)

One other comment on the API here.

This is an omap_hwmod_* API being added to omap_device.h.

Seems like the function name should be something more like:
omap_device_get_by_name()  (or _get_by_hwmod_name() or something.)

Kevin
