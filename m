From: balbi@kernel.org (Felipe Balbi)
Date: Mon, 04 Jul 2016 14:33:31 +0300
Subject: [BUG] Regression, usb-dwc3 not working, Odroid XU3, usb 3.0
In-Reply-To: <577A47D3.7020900@samsung.com>
References: <577A47D3.7020900@samsung.com>
Message-ID: <87shvpljsk.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> Hi,
>
>
> Since three recent next releases (first on 20160630), on Odroid XU3 board
> the USB 3.0 host port (the only one) stopped working.
>
> This is a "samsung,exynos5250-dwusb3" (drivers/usb/dwc3/dwc3-exynos.c).
>
> Two issues here:
> 1. The port does not show up as USB 3.0 device.
> This one device is missing:
> 	Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>
> 2. The port does not work even for 2.0 devices (I didn't test 1.0).
>
>
> config: exynos_defconfig (ARM)
> DTS: exynos5422-odroidxu3.dts

apply [1] and try again. That commit is already in greg/usb-testing [2]
and it should trickle down to usb-next shortly.

[1] https://marc.info/?l=linux-usb&m=146728795330915&w=2
[2] https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=usb-testing&id=322832f2f19e04c866a0ce4bdac8cff8e695f2b3

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160704/0e9c28b5/attachment.sig>
