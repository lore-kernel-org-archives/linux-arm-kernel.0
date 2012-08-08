From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 08 Aug 2012 12:43:14 -0600
Subject: [PATCH 1/8] arm: vt8500: Add device tree files for VIA/Wondermedia
 SoC's
In-Reply-To: <1344389967-8465-2-git-send-email-linux@prisktech.co.nz>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <5022B342.7080606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2012 07:39 PM, Tony Prisk wrote:
> Add device tree files for VT8500, WM8505 and WM8650 SoC's and
> reference boards.

> diff --git a/arch/arm/boot/dts/vt8500_ref.dts b/arch/arm/boot/dts/vt8500_ref.dts

It appears more typical to use "-" rather than "_" in the filename to
join SoC and board names.

I guess "_ref" means "reference". Is that how the boards are commonly
known? Are you sure there will never be another reference board for
these SoCs? Given the "model" values in the file, something more like
vt8500-bv07.dts might be more appropriate?

> +	/*
> +	 * Display node is based on Sascha Hauer's patch on dri-devel.
> +	 * Added a bpp property to calculate the size of the framebuffer
> +	 * until the binding is formalized.
> +	 */
> +	display {

Maybe it's better to just hold off on adding this node, to wait until
the binding is complete so this file doesn't churn? Certainly it sounded
like Sascha was going to change the binding a little in response to
comments it received.
