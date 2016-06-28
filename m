From: a0393675@ti.com (Keerthy)
Date: Tue, 28 Jun 2016 17:57:07 +0530
Subject: [PATCH v4 0/6] mfd: tps65218: Clean ups
In-Reply-To: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
References: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
Message-ID: <57726D1B.4050008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 28 June 2016 02:52 PM, Keerthy wrote:
> The series cleans up mainly the regulator driver and implements
> the device tree parsing using the regulator framework. Removes
> all the redundant compatibles for the individual regulators.
> Adds platform_device_id table for the gpio and power button modules.
>
> One of the patch removes redundant read wrapper and makes
> use of regmap_read wherever necessary.
>
> The series is checked for all the regulator registrations on
> am437x-gp-evm and am437x-sk-evm.
>
> Boot log on am437x-sk-evm: http://pastebin.ubuntu.com/18016754/

Seems like with https://lkml.org/lkml/2016/6/24/122 pulled in. Only
mfd and regulator patches need a bit of re-basing. I am sending a v6
of the series with all the driver patches.

>
> Changes in v4:
>
> For gpio-tps65218 reatined the compatible table.
> Fixed missing ';' in the power button patch.
> Fixed comments on the Documentation patch.
> Split the Device Tree patches to a separate series.
>
> Changes in v3:
>
> Missed making corresponding changes in the power button and gpio
> drivers. Added couple of patches to fix them to use mfd_cell way
> of parsing.
>
> Keerthy (6):
>    mfd: tps65218: Remove redundant read wrapper
>    Documentation: regulator: tps65218: Update examples
>    input: tps65218-pwrbutton: Add platform_device_id table
>    gpio: tps65218-gpio: Add platform_device_id table
>    mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
>    regulator: tps65218: Remove all the compatibles
>
>   .../devicetree/bindings/regulator/tps65218.txt     |  87 ++++++++++---
>   drivers/gpio/gpio-tps65218.c                       |  10 +-
>   drivers/input/misc/tps65218-pwrbutton.c            |  10 +-
>   drivers/mfd/tps65218.c                             |  32 ++---
>   drivers/regulator/tps65218-regulator.c             | 134 ++++++++-------------
>   include/linux/mfd/tps65218.h                       |   2 -
>   6 files changed, 152 insertions(+), 123 deletions(-)
>
