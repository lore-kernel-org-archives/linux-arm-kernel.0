From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Sat, 5 Jan 2013 16:08:07 +0100
Subject: [PATCH] ARM: smp: return from ipi_cpu_stop()
In-Reply-To: <20130105140958.GW2631@n2100.arm.linux.org.uk>
References: <1357391123-759-1-git-send-email-ulrich.hecht@gmail.com>
 <20130105140958.GW2631@n2100.arm.linux.org.uk>
Message-ID: <CAO3366wSDU=Qge+MbCXUDDiX=gdzJ-DgLkH-9TbKQT-iou1VDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 5, 2013 at 3:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jan 05, 2013 at 02:05:23PM +0100, Ulrich Hecht wrote:
>> ipi_cpu_stop() is supposed to mark a CPU offline, but it's the job of the
>> idle thread to actually shut it down.
>
> Wrong.  Where do you get that idea from?

I think it's because that's where the only code path ending up at
shmobile_cpu_die() starts:
cpu_idle() -> cpu_die() -> platform_cpu_die() -> smp_ops.cpu_die()
(which is set to shmobile_cpu_die() on my board).

CU
Uli
