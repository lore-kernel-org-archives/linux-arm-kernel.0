From: jeffy.chen@rock-chips.com (jeffy)
Date: Sat, 14 Oct 2017 02:25:48 +0800
Subject: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early system
 PM callbacks
In-Reply-To: <59E103B0.8060705@rock-chips.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
 <20171013155120.GA137489@google.com>
 <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
 <59E103B0.8060705@rock-chips.com>
Message-ID: <59E1052C.3000503@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2017 02:19 AM, jeffy wrote:
>
>
> it looks like the suspend sequence depends on the dt node sequence, and
> we are putting display-subsystem dt node above spi dt node, so it would
> be earlier in the device list, then got suspended later than spi device.
>
> the pwm backlight and cros_ec_spi pwm are very interesting, not only
> about suspend dependency... if we unbind cros_ec_spi pwm, the pwm
> backlight would still hold a reference to it, and crash the kernel later.

or maybe we should move device_pm_add() from device_add() to driver_bound()?
