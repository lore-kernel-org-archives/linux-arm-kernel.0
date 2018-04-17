From: david@lechnology.com (David Lechner)
Date: Tue, 17 Apr 2018 10:56:25 -0500
Subject: [PATCH] ARM: dts: da850: fix W=1 warnings with pinmux node
In-Reply-To: <20180417123600.23548-1-nsekhar@ti.com>
References: <20180417123600.23548-1-nsekhar@ti.com>
Message-ID: <d45ed86f-3b99-707e-e584-cbdcb2f5552d@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2018 07:36 AM, Sekhar Nori wrote:
> Remove unused #address-cells and #size-cells from pinmux
> node. This fixes W=1 warnings of the type:
> 
> arch/arm/boot/dts/da850-lcdk.dtb: Warning (avoid_unnecessary_addr_size): /soc at 1c00000/pinmux at 14120: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Tested on DA850 LCDK by checking output of:
> 
> /sys/kernel/debug/pinctrl/1c14120.pinmux-pinctrl-single/pins
> 
> before and after the change.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
