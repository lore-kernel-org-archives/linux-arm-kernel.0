From: josh.coombs@gmail.com (Josh Coombs)
Date: Sat, 3 Nov 2012 08:54:21 -0400
Subject: Possible regression in 3.7-rc3 on Marvell Kirkwood
In-Reply-To: <20121103080300.GA9907@lunn.ch>
References: <20121103080300.GA9907@lunn.ch>
Message-ID: <CAMW5UfYmjCq0nnGY6bxV_HxizHSV0UiW74thhers096ufv3E_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'll fire up with ignore log level to get the full traces and post
those this afternoon.  Given it will be a LOT of text, would you
prefer I include them in the email, pastebin the output and provide
links, or dump the log onto my webserver with a link?

Josh C

On Sat, Nov 3, 2012 at 4:03 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Josh
>
> Are you not seeing a stack trace?
>
> [   64.312377] BUG: scheduling while atomic: crond/151/0x40000300
> [   79.771862] BUG: scheduling while atomic: swapper/0/0x40000500
> [   81.826267] BUG: scheduling while atomic: swapper/0/0x40000500
> [   90.330911] BUG: scheduling while atomic: swapper/0/0x40000500
>
>         printk(KERN_ERR "BUG: scheduling while atomic: %s/%d/0x%08x\n",
>                 prev->comm, prev->pid, preempt_count());
>
>         debug_show_held_locks(prev);
>         print_modules();
>         if (irqs_disabled())
>                 print_irqtrace_events(prev);
>         dump_stack();
>         add_taint(TAINT_WARN);
>
> Andrew
