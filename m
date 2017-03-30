From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 30 Mar 2017 22:31:10 +0200
Subject: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
In-Reply-To: <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <1908501.jAQQKvjW4f@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 30, 2017 11:26:58 PM zhichang.yuan wrote:
> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access I/O
> with some special host-local I/O ports known on x86. To access the I/O
> peripherals, an indirect-IO mechanism is introduced to mapped the host-local
> I/O to system logical/fake PIO similar the PCI MMIO on architectures where no
> separate I/O space exists. Just as PCI MMIO, the host I/O range should be
> registered before probing the downstream devices and set up the I/O mapping.
> But current ACPI bus probing doesn't support these indirect-IO hosts/devices.
> 
> This patch introdueces a new ACPI handler for this device category. Through the
> handler attach callback, the indirect-IO hosts I/O registration is done and
> all peripherals' I/O resources are translated into logic/fake PIO before
> starting the enumeration.

Can you explain to me briefly what exactly this code is expected to be doing?

Thanks,
Rafael
