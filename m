From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Sat, 5 Jan 2013 15:49:33 +0100
Subject: [PATCH] ARM: smp: return from ipi_cpu_stop()
In-Reply-To: <20130105140958.GW2631@n2100.arm.linux.org.uk>
References: <1357391123-759-1-git-send-email-ulrich.hecht@gmail.com>
 <20130105140958.GW2631@n2100.arm.linux.org.uk>
Message-ID: <CAO3366w39Cm0qZ1vtH+f9AZjbzoa0ycMfFJuWP5L4+j=6mq1PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 5, 2013 at 3:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Plus, there's no guarantee what so ever that anything will happen in the
> idle loop; this is not the _normal_ CPU shutdown path, this is the "oh
> fsck, we need to stop all other CPUs because we panic'd" handler.

So who's job is it then to call cpu_die()? Because that's what doesn't
happen and leaves the second core spinning, wrecking the kexec'd
kernel.

CU
Uli
