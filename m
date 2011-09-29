From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 29 Sep 2011 22:12:08 +0200 (CEST)
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <009101cc7e7b$1ebece00$5c3c6a00$%kim@samsung.com>
References: <20110908215314.829452535@linutronix.de>
	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
	<20110913133258.GA6267@n2100.arm.linux.org.uk>
	<CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
	<20110913175312.GB6267@n2100.arm.linux.org.uk>
	<20110923084001.GP17169@n2100.arm.linux.org.uk>
	<009101cc7e7b$1ebece00$5c3c6a00$%kim@samsung.com>
Message-ID: <alpine.LFD.2.02.1109292211060.2711@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Sep 2011, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> But as Amit said, current EXYNOS4 SoCs which are using SPI for local timers
> has problem that the irq_set_affinity() method is called in
> percpu_timer_setup() before CPU1 becomes online with the commit
> 5dfc54e087c15f823ee9b6541d2f0f314e69cbed ("ARM: GIC: avoid routing
> interrupts to offline CPUs"). So I will check again.

Why is a per cpu interrupt having an irq_set_affinity() function at all?
 
Thanks,

	tglx
