From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 16 Jan 2017 10:02:20 +0100
Subject: USB: OHCI: high softirq load
In-Reply-To: <bd83e3b2-b329-3635-2917-0ffe61d3535f@overkiz.com>
References: <bd83e3b2-b329-3635-2917-0ffe61d3535f@overkiz.com>
Message-ID: <20170116100220.0b00658e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Mon, 16 Jan 2017 08:45:58 +0100
Antoine Aubert <a.aubert@overkiz.com> wrote:

> Hi,
> 
> Im working on a AT91SAM9G25cu board
> (arch/arm/boot/dts/at91-kizboxmini.dts). We use linux-4.1.31, and when
> OHCI is enabled, I got some wired effects.

Can you test on a more recent kernel (4.9 or 4.10-rc4)?

> 
> eg with 3 FTDI pluged, interrupts: more than 3.5k/s, cpu softirq > 24%,
> loadavg > 0.5

Can you check which interrupt is triggered (cat /proc/interrupts), and
enable debug messages in drivers/usb/host/ohci-at91.c?

Thanks,

Boris

> 
> This issue disappear when disabling OHCI and use EHCI only.
> 
> What are the usual causes, and where to begin with ?
> 
> Thanks in advance,
> 
