From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 18:20:22 +0100
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131209165548.GE19163@arm.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312091735.05014.arnd@arndb.de> <20131209165548.GE19163@arm.com>
Message-ID: <201312091820.23006.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, Catalin Marinas wrote:
> CONFIG_PCI does not exist on arm64 yet (we have some internal patches
> but may not be ready to be posted before the holidays; they try to share
> code with other archs, so more discussions before merging). We could add
> CONFIG_PCI and some dummy functions on arm64 for development (not to be
> upstreamed) or Hanjun could continue to use the current patch before we
> get PCI working. In the order of priorities, we'll have to merge PCI
> before ACPI anyway.

Well, lack of PCI support on ARM64 is a much better reason for accepting
the patch than potential use on non-server platforms of course.

What is the status of the PCI work though? I suspect it won't be all
that hard to add minimal PCI support for a simple mmconfig plus
fixed I/O space based host of the kind that qemu can easily provide.

The hard part that we want to share code with other architectures is
supporting pluggable host controllers, and I think we can defer that
a bit.

	Arnd
