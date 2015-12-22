From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 14:49:07 +0000
Subject: How to get better precision out of getrusage on the ARM?
In-Reply-To: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
References: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
Message-ID: <20151222144907.GK8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 09:30:30AM -0500, Patrick Doyle wrote:
> Short version:
> My application running on a Cortex-A5 processor (the SAMA5D2 from
> Atmel) calls getrusage(RUSAGE_THREAD, ...), which returns cpu time
> quantized to the kernel tick frequency (100Hz or 1Khz, depending on
> CONFIG_HZ_100 vs CONFIG_HZ_1000).
> 
> How can I get better precision for sched_clock on the (Cortex-A5) ARM?
>  The x86 uses the TSC.

You need to provide a sched_clock() implementation using
sched_clock_register().

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
