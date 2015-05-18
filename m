From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 May 2015 11:40:43 +0100
Subject: [PATCH 1/2] ARM: simplify timer initialisation and remove
 arm_timer.h inclusion
In-Reply-To: <CAL_JsqK8pPLCkrVFHaWr-RhOkPzaF+D_kZ5h9BahvN7CoYZO0w@mail.gmail.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1430390662-18246-2-git-send-email-sudeep.holla@arm.com>
 <CAL_JsqK8pPLCkrVFHaWr-RhOkPzaF+D_kZ5h9BahvN7CoYZO0w@mail.gmail.com>
Message-ID: <20150518104043.GS2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:09:47AM -0500, Rob Herring wrote:
> On Thu, Apr 30, 2015 at 5:44 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > The header asm/hardware/arm_timer.h is included in various machine
> > specific files to access TIMER_CTRL and initialise to a known state.
> > However that's not required as the clock{source,event} driver timer-sp
> > initialises all the timer being used.
> 
> I believe the idea is not to initialize the timers being used, but the
> ones not being used and perhaps left running by the bootloader. Cases
> where the interrupt is shared could cause a problem.

Exactly.  IMHO this code needs to stay.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
