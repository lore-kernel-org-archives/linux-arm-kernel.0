From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 3 Nov 2012 09:03:00 +0100
Subject: Possible regression in 3.7-rc3 on Marvell Kirkwood
Message-ID: <20121103080300.GA9907@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh

Are you not seeing a stack trace?

[   64.312377] BUG: scheduling while atomic: crond/151/0x40000300
[   79.771862] BUG: scheduling while atomic: swapper/0/0x40000500
[   81.826267] BUG: scheduling while atomic: swapper/0/0x40000500
[   90.330911] BUG: scheduling while atomic: swapper/0/0x40000500

        printk(KERN_ERR "BUG: scheduling while atomic: %s/%d/0x%08x\n",
                prev->comm, prev->pid, preempt_count());

        debug_show_held_locks(prev);
        print_modules();
        if (irqs_disabled())
                print_irqtrace_events(prev);
        dump_stack();
        add_taint(TAINT_WARN);

Andrew
