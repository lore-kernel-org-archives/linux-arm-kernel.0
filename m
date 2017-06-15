From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 15 Jun 2017 15:08:40 +0300
Subject: arm64: next-20170614 panics on boot
Message-ID: <20170615120840.ce7v4hxflueu4s7o@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux next falls into panic in init_IRQ():
arch/arm64/kernel/irq.c:
 53 void __init init_IRQ(void)
 54 {
 55         irqchip_init();
 56         if (!handle_arch_irq)
 57                 panic("No interrupt controller found.");
 58 }


Bisecting points to the patch 6fedb069def034 ("of: Provide dummy
of_device_compatible_match() for compile-testing"), but reverting it
doesn't help. It seems like yesterday's linux-next also hangs.  Right
now I cannot continue with debugging, but if nothing will get clear,
I'll back to it at this evening.

Yury
