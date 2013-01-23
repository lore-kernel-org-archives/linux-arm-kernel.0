From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jan 2013 17:00:55 +0000
Subject: Kernel API for SGI usage
In-Reply-To: <CANudz+sMppk5UZK+Vf_hWZYZzPJMunhPJQs0qbu1-dPy9WRikA@mail.gmail.com>
References: <CANudz+tDzfU1xJgsjeuQBL7r5cwosvSEH6tct5aO8c+LvAm4pA@mail.gmail.com>
 <20130123164620.GR23505@n2100.arm.linux.org.uk>
 <CANudz+sMppk5UZK+Vf_hWZYZzPJMunhPJQs0qbu1-dPy9WRikA@mail.gmail.com>
Message-ID: <20130123170054.GS23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 12:51:50AM +0800, loody wrote:
> hi Russell:
> 
> 2013/1/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Thu, Jan 24, 2013 at 12:39:54AM +0800, loody wrote:
> >> hi all:
> >> The other cores on my Soc need SGI to be waken up from reset state.
> >> Could any one header and functions I need to include and used for?
> >
> > That's almost what every platform does.  Plenty of examples in the
> > platform SMP code for you to look at.
> Nice to meet you
> Would you please show me a hint or function name for reference?
> 
> Appreciate your help, @_@

It even comes with comments:

        /*
         * Send the secondary CPU a soft interrupt, thereby causing
         * the boot monitor to read the system wide flags register,
         * and branch to the address found there.
         */
        gic_raise_softirq(cpumask_of(cpu), 0);
