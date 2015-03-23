From: eliad@wizery.com (Eliad Peller)
Date: Mon, 23 Mar 2015 10:27:41 +0200
Subject: [PATCH v7 6/6] wlcore: remove wl12xx_platform_data
In-Reply-To: <550FCD16.6030809@ti.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
 <1426696710-6891-7-git-send-email-eliad@wizery.com>
 <550FC60F.4050206@ti.com>
 <CAB3XZEdyQGtHzY-61baafBQuJ3hNHv1MSkBD+1EmjYzgoSG58g@mail.gmail.com>
 <550FCD16.6030809@ti.com>
Message-ID: <CAB3XZEeKUwDE9NJzX-W1fKc9gP4kG+EjKN+XJbdaaADc1vi-BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 10:21 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>>> On Wednesday 18 March 2015 10:08 PM, Eliad Peller wrote:
>>>> Now that we have wlcore device-tree bindings in place
>>>> (for both wl12xx and wl18xx), remove the legacy
>>>> wl12xx_platform_data struct, and move its members
>>>> into the platform device data (that is passed to wlcore)
>>>>
>>>> Davinci 850 is the only platform that still set
>>>> the platform data in the legacy way (and doesn't
>>>> have DT bindings), so remove the relevant
>>>> code/Kconfig option from the board file (as suggested
>>>> by Sekhar Nori)
>>>>
>>>> Since no one currently uses wlcore_spi, simply remove its
>>>> platform data support (DT bindings will have to be added
>>>> if someone actually needs it)
>>>>
>>>> Signed-off-by: Luciano Coelho <luca@coelho.fi>
>>>> Signed-off-by: Eliad Peller <eliad@wizery.com>
>>>> ---
>>>> v7:
>>>> * fix spi compilation (Tony)
>>>> * remove irq/irq_trigger from wlcore_platdev_data (they are
>>>>   being passed separately)
>>>>
>>>>  arch/arm/mach-davinci/Kconfig                  |  11 ---
>>>>  arch/arm/mach-davinci/board-da850-evm.c        | 113 -------------------------
>>>>  drivers/net/wireless/ti/wilink_platform_data.c |  25 ------
>>>>  drivers/net/wireless/ti/wl12xx/main.c          |  19 ++---
>>>>  drivers/net/wireless/ti/wlcore/boot.c          |   1 -
>>>>  drivers/net/wireless/ti/wlcore/main.c          |   4 +-
>>>>  drivers/net/wireless/ti/wlcore/sdio.c          |  76 +++++------------
>>>>  drivers/net/wireless/ti/wlcore/spi.c           |   6 +-
>>>>  drivers/net/wireless/ti/wlcore/wlcore_i.h      |   6 +-
>>>>  include/linux/wl12xx.h                         |  25 ------
>>>>  10 files changed, 35 insertions(+), 251 deletions(-)
>>>
>>> The patch looks good to me, but it will be nice to know to which base it
>>> applies cleanly. I tried applying to v4.0-rc1 and linux-next and both
>>> failed.
>>>
>> The patchset was rebased on top of v4.0-rc4.
>> (Note that you'll have to apply the whole series, as this patch relies
>> on some intermediate changes done by the previous patches in the
>> patchset)
>
> I was applying the whole series, but over v4.0-rc1 :) Its best to
> mention the baseline in cover-letter itself.
>
check out again the cover-letter. you probably overlooked it :)

> The DA850 related changes in the patch look good to me.
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
>
thanks,
Eliad.
