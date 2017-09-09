From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Sep 2017 16:30:20 +0100
Subject: arm: Export save_stack_trace_tsk()
In-Reply-To: <001b01d3203f$c04a4e40$40deeac0$@codeaurora.org>
References: <001b01d3203f$c04a4e40$40deeac0$@codeaurora.org>
Message-ID: <20170909153020.GC20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 01:53:49PM -0700, Dustin Brown wrote:
> The kernel watchdog is a great debugging tool for finding tasks that
> consume a disproportionate amount of CPU time in contiguous chunks. One
> can imagine building a similar watchdog for arbitrary driver threads
> using save_stack_trace_tsk() and print_stack_trace(). However, this is
> not viable for dynamically loaded driver modules on ARM platforms
> because save_stack_trace_tsk() is not exported for those architectures.
> Export save_stack_trace_tsk() for the ARM architecture to align with x86
> and support various debugging use cases such as arbitrary driver thread
> watchdog timers.

Hi Dustin,

I'm not sure why, but when I merged this, your commit log appears to be
entirely on two very long lines.  Linux requires that commit messages
are sensibly wrapped such that they can be read in git log on an 80
column display - please take care in future to ensure that commit
messages are appropriately wrapped.

I'm having to reformat the commit manually.

There are cases where wrapping is not appropriate (eg, when quoting
program output or kernel messages.)

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
