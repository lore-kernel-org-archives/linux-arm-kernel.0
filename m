From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 Jul 2012 20:50:02 +0000
Subject: [PATCH 5/6] ARM: ux500: Enable HIGHMEM on all mop500 platforms
In-Reply-To: <20120731143732.GS6802@n2100.arm.linux.org.uk>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <5017EBDC.6010005@linaro.org> <20120731143732.GS6802@n2100.arm.linux.org.uk>
Message-ID: <201207312050.03113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 July 2012, Russell King - ARM Linux wrote:
> I still fail to see how not having highmem enabled would ever cause memory
> corruption errors (unless something dealing with memory in a very very
> wrong way - iow, not using one of the reservation or memory allocation
> methods provided by the kernel.)

The problem is that all users of ux500 systems pass a command line like

vmalloc=256M mem=128M at 0 mali.mali_mem=32M at 128M hwmem=168M at 160M mem=48M at 328M mem_issw=1M at 383M mem=640M at 384M

This is of course totally bogus and should not be done. If I understand
Lee correctly, one of the issues resulting from passing a command
line like this without enabling highmem is memory corruption.

"Doctor it hurts when I do this ..."

	Arnd
