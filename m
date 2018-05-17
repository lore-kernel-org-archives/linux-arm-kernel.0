From: vincent.weaver@maine.edu (Vince Weaver)
Date: Thu, 17 May 2018 12:34:56 -0400 (EDT)
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <1412187220.62585.1526572780332@email.1und1.de>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
Message-ID: <alpine.DEB.2.21.1805171233500.7984@macbook-air>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 May 2018, Stefan Wahren wrote:

> 
> > Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:
> > 
> > 
> > The a53 and a7 counters seem to match up, so we advertise a7 so that
> > arm32 can probe.

so how closely did you look at the a53/a7 differences?  I see some major 
differences, especially with the CPU_CYCLES event (0xff vs 0x11).

The proper fix here might be to add a cortex-a53 PMU entry to the armv7 
code rather than trying to treat it as a cortex-a7.

Vince
