From: arokux@gmail.com (Arokux X)
Date: Sun, 6 Oct 2013 01:32:13 +0200
Subject: [linux-sunxi] [PATCH 0/4] Add support for the Allwinner A31 Reset
 Controllers
In-Reply-To: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAPNxggaUW1B8Ea-gSo+XV2P9s4MRa1L25_ZAvOWyLN6VqQ6wsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Sat, Oct 5, 2013 at 4:39 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi everyone,
>
> This patchset adds support for the reset controllers found in the Allwinner A31
> SoCs. Since these controllers are pretty simple, basically just a few MMIO
> registers, with a single bit controlling the reset state of the other devices
> it asserts in reset, the driver is quite simple as well.

I think we need something smarter here. There are reset bits all over
the place. After a hint by Emilio and small chat with Oliver I've
realized I have 3 reset bits in USB host clock module [0].

Maybe implementation like this one [1] where a mask can be passed as a
parameter will be more appropriate? (Those reset bits behave the same
as gatable clocks really.)

Best,
Arokux

[0] https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/arch/arm/mach-sun4i/include/mach/ccmu_regs.h#L392
[1] https://github.com/arokux/linux/blob/sunxi-next-usb/drivers/clk/sunxi/clk-sunxi.c#L678
