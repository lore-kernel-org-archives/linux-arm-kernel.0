From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Feb 2014 21:41:53 +0100 (CET)
Subject: [PATCH v3 5/7] clocksource/cadence_ttc: Use only one counter
In-Reply-To: <1391466877-28908-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
 <1391466877-28908-6-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <alpine.DEB.2.02.1402042138480.24986@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Feb 2014, Soren Brinkmann wrote:

> Currently the driver uses two of the three counters the TTC provides to
> implement a clocksource and a clockevent device. By using the TTC's
> match feature we can implement both use cases using a single counter
> only.

Are you entirely sure that this match feature is free of the infamous
HPET match feature issues?

See arch/x86/kernel/hpet.c: hpet_next_event()

If yes, please add a comment. If no ....

Thanks,

	tglx
