From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Dec 2015 19:45:12 +0000
Subject: What happens if sched_clock_suspend() is never called?
In-Reply-To: <CAF_dkJAJ3g7S2i2zW81OD50Bwsg7NzuakbeeQaBhJvtVCyg86w@mail.gmail.com>
References: <CAF_dkJAJ3g7S2i2zW81OD50Bwsg7NzuakbeeQaBhJvtVCyg86w@mail.gmail.com>
Message-ID: <20151223194511.GU8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 11:11:20AM -0500, Patrick Doyle wrote:
> This feels like a bug to me.  It seems like sched_clock_register()
> should update the sched_clock_timer whenever it changes cd.wrap_kt.

sched_clock needs to be up and running early in the boot process
so the scheduler has a stable time source.  sched_clock must be
registered and configured by the time sched_clock_postinit() is
called, and after that no further registrations should be made.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
