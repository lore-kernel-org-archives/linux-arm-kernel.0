From: loeliger@gmail.com (Jon Loeliger)
Date: Sat, 21 Jun 2014 17:44:59 -0500
Subject: A clockevent IRQ delivery question
In-Reply-To: <CAJgR-BiLiskWsFOK2Nr7ysTktkkAJnz8p4HJBb_YJReN3KzQXw@mail.gmail.com>
References: <CAJgR-BjUpaR0cxew+-fz5YcDu0VKzim-rhLF4j1hEnR_4O+Jsg@mail.gmail.com>
 <53A446C0.10200@linaro.org>
 <CAJgR-Bj+tgCpKTT7FxM-1JMvN7CKUgpaikfbXPQx5ep6+7W2mA@mail.gmail.com>
 <20140620152335.GT32514@n2100.arm.linux.org.uk>
 <CAJgR-BiLiskWsFOK2Nr7ysTktkkAJnz8p4HJBb_YJReN3KzQXw@mail.gmail.com>
Message-ID: <CAJgR-Bgn=5Ln53faiTP4hM5TLvCLu655HXY3w=5uwvTgxA9PxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 10:31 AM, Jon Loeliger <loeliger@gmail.com> wrote:

> OK, I'll leave things as they stand in my port for now
> as that appears to be working even if not ideal yet!

"Appears" is the key word here.  Sometimes it boots fully to a prompt,
and sometimes it doesn't, mostly depending on which printk()s I leave in
or take out.  So something flakey or timing sensitive perhaps.

If I manually inspect the timers from a different CPU in the system,
I can see them counting and reloading, but I am not getting
an interrupt delivered to some CPU.  I am trying to determine if it
is a broken timer IP block that is failing to generate an interrupt, or if
is a failed IRQ delivery to one of the cores.  Both cores are in the
idle loop.  If I manually trigger an interrupt, the kernel panics and
claims that a CPU was non-responsive for something like 50 seconds.

Do I need to do some form of IRQ broadcast to ensure all CPUs are
receiving the timer ticks?  How do I set that up?  Pointer to an example?

Thanks,
jdl
