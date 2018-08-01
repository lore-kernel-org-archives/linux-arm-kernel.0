From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Aug 2018 02:54:04 -0700
Subject: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <20180731142954.30345-7-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
Message-ID: <20180801095404.GA17585@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
> Platforms with a PCI bus will be offered the RapidIO menu since they may
> be want support for a RapidIO PCI device. Platforms without a PCI bus
> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> 
> Tested that kernel builds for arm64 with RapidIO subsystem and
> switch drivers enabled, also that the modules load successfully
> on a custom Aarch64 Qemu model.

As said before, please include it from drivers/Kconfig so that _all_
architectures supporting PCI (or other Rapidio attachements) get it
and not some arbitrary selection of architectures.
