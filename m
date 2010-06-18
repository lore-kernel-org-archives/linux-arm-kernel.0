From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 18 Jun 2010 11:33:55 +0300
Subject: invalid address for enqueue_task
In-Reply-To: <201006171230.38101.alexander.stein@systec-electronic.com>
References: <201006171230.38101.alexander.stein@systec-electronic.com>
Message-ID: <20100618083355.GA28107@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 12:30:37PM +0200, Alexander Stein wrote:
> 
> After doing some research I found out that sched_class inside struct_task has 
> been modified to some bogus address so sched_class->enqueue_task 
> (kernel/sched.c:1886) jumps to some invalid address.

While I cannot help you with this specific problem, I think it is
worth to mention that this kind of bugs are exactly where kdump
might prove to be useful. As now you have a snapshot of the system
during the time of the crash, you might be able to dig out the cause
using tools like gdb and crash[1]

Currently kdump patches are not in mainline but if you decide to
take that route, they can be found by searching this ML and I can
provide assistance for setting them up.

Regards,
MW

[1] http://people.redhat.com/~anderson/

( crash doesn't have ARM support but I have experimental patches
  to make it work on ARM as well )
