From: dustinb@codeaurora.org (Dustin Brown)
Date: Mon, 11 Sep 2017 10:12:01 -0700
Subject: arm: Export save_stack_trace_tsk()
In-Reply-To: <20170909153020.GC20805@n2100.armlinux.org.uk>
References: <001b01d3203f$c04a4e40$40deeac0$@codeaurora.org>
 <20170909153020.GC20805@n2100.armlinux.org.uk>
Message-ID: <002801d32b21$15c42e90$414c8bb0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I apologize for the trouble! I'm not sure how it happened (it looks fund
below after all), but I will try to be extra careful in the future.

Thanks,

-Dustin

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk] 
Sent: Saturday, September 9, 2017 8:30 AM
To: Dustin Brown <dustinb@codeaurora.org>
Cc: linux-arm-kernel at lists.infradead.org
Subject: Re: arm: Export save_stack_trace_tsk()

On Mon, Aug 28, 2017 at 01:53:49PM -0700, Dustin Brown wrote:
> The kernel watchdog is a great debugging tool for finding tasks that 
> consume a disproportionate amount of CPU time in contiguous chunks. 
> One can imagine building a similar watchdog for arbitrary driver 
> threads using save_stack_trace_tsk() and print_stack_trace(). However, 
> this is not viable for dynamically loaded driver modules on ARM 
> platforms because save_stack_trace_tsk() is not exported for those
architectures.
> Export save_stack_trace_tsk() for the ARM architecture to align with 
> x86 and support various debugging use cases such as arbitrary driver 
> thread watchdog timers.

Hi Dustin,

I'm not sure why, but when I merged this, your commit log appears to be
entirely on two very long lines.  Linux requires that commit messages are
sensibly wrapped such that they can be read in git log on an 80 column
display - please take care in future to ensure that commit messages are
appropriately wrapped.

I'm having to reformat the commit manually.

There are cases where wrapping is not appropriate (eg, when quoting program
output or kernel messages.)

Thanks.

--
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
