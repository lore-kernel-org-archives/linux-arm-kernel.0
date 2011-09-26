From: khilman@ti.com (Kevin Hilman)
Date: Mon, 26 Sep 2011 11:24:33 -0700
Subject: [PATCH v2 1/6] OMAP: omap_device: Add omap_hwmod_name_get_dev
In-Reply-To: <1314973520-3585-2-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 2 Sep 2011 16:25:15 +0200")
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
	<1314973520-3585-2-git-send-email-b-cousson@ti.com>
Message-ID: <87zkhrcgbi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> An API which translates a standard hwmod name to corresponding
> platform_device is useful for drivers when they need to look up the
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
> Provide an omap_hwmod_name_get_dev helper function to convert
> hwmod to device pointer.
> This wrapper provides ability for drivers to convert directly
> from hwmod name back to device pointer without having to handle
> this on a driver by driver basis.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> [b-cousson at ti.com: Adapt it to the new pdev pointer inside od,
> remove the unneeded helpers, and fold the next patch here]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

I replied to wrong version of patch before, here's the comment again:

One other comment on the API here.

This is an omap_hwmod_* API being added to omap_device.h.

Seems like the function name should be something more like:
omap_device_get_by_name(), or probably omap_device_get_by_hwmod_name().

Kevin 
