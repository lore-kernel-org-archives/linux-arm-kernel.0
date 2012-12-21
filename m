From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Dec 2012 15:38:02 +0530
Subject: [RFC PATCH 0/5] clockevents: decouple broadcast mechanism from
 drivers
In-Reply-To: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
Message-ID: <50D43502.1070402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Tuesday 18 December 2012 05:36 PM, Mark Rutland wrote:
> In some SMP systems, cpu-local timers may stop delivering interrupts
> when in low power states, or not all CPUs may have local timers. To
> support these systems we have a mechanism for broadcasting timer ticks
> to other CPUs. This mechanism relies on the struct
> clock_event_device::broadcast function pointer, which is a
> driver-specific mechanism for broadcasting ticks to other CPUs.
>
> As the broadcast mechanism is architecture-specific, placing the
> broadcast function on struct clock_event_device ties each driver to a
> single architecture. Additionally the driver or architecture backend
> must handle the routing of broadcast ticks to the correct
> clock_event_device, leading to duplication of the list of active
> clock_event_devices.
>
> These patches introduce a generic mechanism for handling the receipt of
> timer broadcasts, and an optional architecture-specific broadcast
> function which allows drivers to be decoupled from a particular
> architecture will retaining support for timer tick broadcasts. These
> mechanisms are wired up for the arm port, and have been boot-tested on a
> pandaboard.
>
Apart from the relevant comments given against couple of patches and
Stephen's printk string comment, the series looks pretty good to me.

I have tested the series with CPUIdle where the broadcast is actually
used actively.

So feel free to add,
Reviewed-tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
