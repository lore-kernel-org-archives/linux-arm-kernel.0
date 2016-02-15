From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Feb 2016 16:46:27 +0100
Subject: [PATCH 0/4] clean up irq_to_gpio and asm/gpio.h
In-Reply-To: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <1455551208-2825510-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I noticed that arch/arm/include/asm/gpio.h can almost be removed,
after we have already removed the file for most other architectures
now.

When I removed it, I ran into problems with irq_to_gpio(), which
we had already killed off in ARM, but it survived (barely) in the
global headers. this kills it off some more as well.

I'd suggest merging all four patches through the GPIO tree.

	Arnd
