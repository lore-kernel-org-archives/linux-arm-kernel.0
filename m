From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Apr 2015 09:09:47 -0500
Subject: [PATCH 1/2] ARM: simplify timer initialisation and remove
 arm_timer.h inclusion
In-Reply-To: <1430390662-18246-2-git-send-email-sudeep.holla@arm.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1430390662-18246-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAL_JsqK8pPLCkrVFHaWr-RhOkPzaF+D_kZ5h9BahvN7CoYZO0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 5:44 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> The header asm/hardware/arm_timer.h is included in various machine
> specific files to access TIMER_CTRL and initialise to a known state.
> However that's not required as the clock{source,event} driver timer-sp
> initialises all the timer being used.

I believe the idea is not to initialize the timers being used, but the
ones not being used and perhaps left running by the bootloader. Cases
where the interrupt is shared could cause a problem.

Rob
