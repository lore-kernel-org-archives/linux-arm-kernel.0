From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jan 2014 21:47:36 +0000
Subject: [BUG] shmobile build failure
In-Reply-To: <CAOesGMiZrfP1GkdNqxKTUHHynMMH2i2x+1dwmZeuJ37CcaDOrA@mail.gmail.com>
References: <20140102172413.GB7383@n2100.arm.linux.org.uk>
 <CAOesGMiZrfP1GkdNqxKTUHHynMMH2i2x+1dwmZeuJ37CcaDOrA@mail.gmail.com>
Message-ID: <20140102214736.GE7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 09:36:07AM -0800, Olof Johansson wrote:
> On Thu, Jan 2, 2014 at 9:24 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > allmodconfig and allyesconfig fail with this error:
> >
> > arch/arm/mach-shmobile/setup-rcar-gen2.c:21:32: fatal error: linux/clk/shmobile.h: No such file or directory
> >
> > My guess is that shmobile on its own doesn't build because of this.
> > Is there a screwed dependency between arm-soc and the clk git trees?
> 
> Yeah, I noticed this too but hadn't had a chance to report it yet --
> holidays followed by getting sick.
> 
> I'm guessing they have a dependency on clk rework that we haven't merged.

Have you run any allmod or allyesconfig builds recently?  The logs from
those builds are excessively big and unreadable due to this:

warning: __mcount_loc already exists: object-file.o

being spat out for every object file being built, and I can't figure out
what's causing that.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
