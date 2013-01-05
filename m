From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Jan 2013 14:09:58 +0000
Subject: [PATCH] ARM: smp: return from ipi_cpu_stop()
In-Reply-To: <1357391123-759-1-git-send-email-ulrich.hecht@gmail.com>
References: <1357391123-759-1-git-send-email-ulrich.hecht@gmail.com>
Message-ID: <20130105140958.GW2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 05, 2013 at 02:05:23PM +0100, Ulrich Hecht wrote:
> ipi_cpu_stop() is supposed to mark a CPU offline, but it's the job of the
> idle thread to actually shut it down.

Wrong.  Where do you get that idea from?

If you look at what x86 does, you'll notice that it too puts the CPU
into a busy loop.

Plus, there's no guarantee what so ever that anything will happen in the
idle loop; this is not the _normal_ CPU shutdown path, this is the "oh
fsck, we need to stop all other CPUs because we panic'd" handler.
