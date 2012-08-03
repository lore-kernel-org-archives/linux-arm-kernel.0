From: koen@dominion.thruhere.net (Koen Kooi)
Date: Fri, 3 Aug 2012 14:50:22 +0200
Subject: [PATCH 3/4] arm/dts: omap5-evm: Add keypad data
In-Reply-To: <1343997486-710-4-git-send-email-sourav.poddar@ti.com>
References: <1343997486-710-1-git-send-email-sourav.poddar@ti.com>
 <1343997486-710-4-git-send-email-sourav.poddar@ti.com>
Message-ID: <D32DBB77-844C-400A-9E3F-3F779431D1C7@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 3 aug. 2012, om 14:38 heeft Sourav Poddar <sourav.poddar@ti.com> het volgende geschreven:

> Add keypad data node in omap5 device tree file.
> Also fill the device tree binding parameters
> with the required value in "omap5-evm" dts file.
> 
> Tested on omap5430 evm with 3.5 custom kernel.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> arch/arm/boot/dts/omap5-evm.dts |   12 ++++++++++++
> arch/arm/boot/dts/omap5.dtsi    |    5 +++++
> 2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> index 45a8aeb..09fe941 100644
> --- a/arch/arm/boot/dts/omap5-evm.dts
> +++ b/arch/arm/boot/dts/omap5-evm.dts
> @@ -17,6 +17,18 @@
> 		device_type = "memory";
> 		reg = <0x80000000 0x40000000>; /* 1 GB */
> 	};
> +
> +	keypad {
> +		keypad,num-rows = <8>;
> +		keypad,num-columns = <8>;
> +		linux,keymap = < 0x02020073
> +			0x02030072
> +			0x020400e7
> +			0x02050066
> +			0x0206006b
> +			0x020700d9 >;
> +		linux,input-no-autorepeat;
> +	};

This not a criticism on your patch, but a generic question about DT: Is there no way to have nice constants for keys like we have in the kernel, like KEY_POWER, KEY_UP, etc? If no, does DT allow comments so I can look at a dts and see which keycodes are mapped instead of having to dig up the sources?

regards,

Koen
