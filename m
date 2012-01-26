From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 25 Jan 2012 18:22:26 -0600
Subject: 3.3-rc1 console lag (was: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime
 adaptation + cleanup)
Message-ID: <CAB-zwWg4RS4J1YCcbfMWjLSCcV=oHqk9vaUKKKr0WjnTEuOmxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 11, 2011 at 3:57 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
> Converting uart driver to adapt to pm runtime API's.
> Code re-org + cleanup.
> Moving some functionality from serial.c to omap-serial.c
...
>
> Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.
> And for pm_qos usage ensure CONFIG_CPU_IDLE is selected other wise
> console might be sluggish.

There is console lag for omap2plus_defconfig given that
CONFIG_CPU_IDLE is not enabled. Is the intention to force CPU_IDLE
into the defconfig or find an alternative for the new pm_qos when cpu
idle is disabled.

Seen on beagle-xm and 3.3-rc1.

Regards,

Omar
