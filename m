From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Dec 2010 10:41:16 +0000
Subject: generic irq handler and stack?
In-Reply-To: <201012071129.26211.tim.sander@hbm.com>
References: <201012071129.26211.tim.sander@hbm.com>
Message-ID: <20101207104116.GA20264@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 11:29:26AM +0100, Tim Sander wrote:
> The interrupt handling on the i.mx35x seems to handle only one interrupt at a 
> time. This generates larger then nessecary interrupt jitter. I am currently 
> investigating to reprogram the AVIC to enable higher priority interrupts to 
> interrupt lower priority interrupts. The mechanism is outlined in section 
> 13,3.8 of the IMX35 Reference Manual.

The kernel now runs _all_ interrupts with IRQs masked on the CPU.  See
e58aa3d2d0cc01ad8d6f7f640a0670433f794922.
