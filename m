From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Mar 2018 16:44:13 +0000
Subject: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
In-Reply-To: <CAH76GKOe=+WTrw8QEJ43+fyEfRPuo7+ds8VNoMCUqSNBMtxkyg@mail.gmail.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
 <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com>
 <20180302131545.q2vf6uc3yofofqdb@lakrids.cambridge.arm.com>
 <CAH76GKOe=+WTrw8QEJ43+fyEfRPuo7+ds8VNoMCUqSNBMtxkyg@mail.gmail.com>
Message-ID: <20180302164411.fxdx72ttz7livz2e@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 02:52:07PM +0100, Grzegorz Jaszczyk wrote:
> 2018-03-02 14:15 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> > Do you see this for a panic() in *any* interrupt handler?
> 
> I only test with this two interrupt handlers: watchdog and i2c but I
> think it will behave the same with others - I can try with other if
> you want, any suggestion which? Maybe with some PPI interrupt instead?
> >
> > Can you trigger the issue with magic-sysrq c, for example?
> 
> There is no problem when I trigger it via 'echo c >
> /proc/sysrq-trigger' - it works well all the time. The problem appears
> only, when the kexec/kdump procedure is triggered from interrupt
> context

I'd meant that you'd send sysrq + c over serial, rather than writing to
/proc/sysrq-trigger. That way, the panic will be in the context of the
UART IRQ handler.

If that shows the issue, that's ilikely to be the easiest way for
someone else to reproduce and investigate this.

Thanks,
Mark.
