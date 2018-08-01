From: alex.bou9@gmail.com (Alex Bounine)
Date: Wed, 1 Aug 2018 09:15:57 -0400
Subject: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <20180801095404.GA17585@infradead.org>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
Message-ID: <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>
>> Tested that kernel builds for arm64 with RapidIO subsystem and
>> switch drivers enabled, also that the modules load successfully
>> on a custom Aarch64 Qemu model.
> 
> As said before, please include it from drivers/Kconfig so that _all_
> architectures supporting PCI (or other Rapidio attachements) get it
> and not some arbitrary selection of architectures.
> 
As it was replied earlier this is not a random selection of 
architectures but only ones that implement support for RapidIO as system 
bus. If other architectures choose to adopt RapidIO we will include them 
as well.

On some platforms RapidIO can be the only system bus available replacing 
PCI/PCIe or RapidIO can coexist with PCIe.

As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or 
"Bus Support" (ARMs) sub-menu and from system configuration option it 
should be kept this way.

Current location of RAPIDIO configuration option is familiar to users of 
PowerPC and x86 platforms, and is similarly available in some ARM 
manufacturers kernel code trees.

drivers/Kconfig will be used for configuring drivers for peripheral 
RapidIO devices if/when such device drivers will be published.
