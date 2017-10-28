From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 28 Oct 2017 11:07:30 +0200
Subject: [RFC PATCH v10 0/7] PCI: rockchip: Move PCIe WAKE# handling into
 pci core
In-Reply-To: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
Message-ID: <1872710.P2f02irZl9@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 27, 2017 9:26:05 AM CEST Jeffy Chen wrote:
> 
> Currently we are handling wake irq in mrvl wifi driver. Move it into
> pci core.
> 
> Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).
> 
> 
> Changes in v10:
> Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
> since dedicated wakeirq will be lost in device_set_wakeup_enable(false).
> 
> Changes in v9:
> Add section for PCI devices and rewrite the commit message.
> Rewrite the commit message.
> Fix check error in .cleanup().
> Move dedicated wakeirq setup to setup() callback and use
> device_set_wakeup_enable() to enable/disable.
> 
> Changes in v8:
> Add optional "pci", and rewrite commit message.
> Rewrite the commit message.
> Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
> 
> Changes in v7:
> Move PCIE_WAKE handling into pci core.
> 
> Changes in v6:
> Fix device_init_wake error handling, and add some comments.
> 
> Changes in v5:
> Move to pci.txt
> Use "wakeup" instead of "wake"
> Rebase.
> 
> Changes in v3:
> Fix error handling.
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq.
> 
> Jeffy Chen (7):
>   dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
>   of/irq: Adjust of_pci_irq parsing for multiple interrupts
>   mwifiex: Disable wakeup irq handling for pcie
>   arm64: dts: rockchip: Move PCIe WAKE# irq to pcie driver for Gru
>   PCI: Make pci_platform_pm_ops's callbacks optional
>   PCI / PM: Move acpi wakeup code to pci core
>   PCI / PM: Add support for the PCIe WAKE# signal for OF

Overall, I don't quite like the direction this is going into, but I need to
have a deeper look.  Which may take some time, so please bear with me.

Thanks,
Rafael
