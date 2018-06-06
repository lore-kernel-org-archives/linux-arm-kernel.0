From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 05 Jun 2018 21:19:57 -0400
Subject: [PATCH V5] scsi: hpsa: disable device during shutdown
In-Reply-To: <1527913733-16492-1-git-send-email-okaya@codeaurora.org> (Sinan
 Kaya's message of "Sat, 2 Jun 2018 00:28:53 -0400")
References: <1527913733-16492-1-git-send-email-okaya@codeaurora.org>
Message-ID: <yq1d0x4g18i.fsf@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sinan,

> 'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
> shutdown")' has been added to kernel to shutdown pending PCIe port
> service interrupts during reboot so that a newly started kexec kernel
> wouldn't observe pending interrupts.
>
> pcie_port_device_remove() is disabling the root port and switches by
> calling pci_disable_device() after all PCIe service drivers are shutdown.
>
> This has been found to cause crashes on HP DL360 Gen9 machines during
> reboot due to hpsa driver not clearing the bus master bit during the
> shutdown procedure by calling pci_disable_device().
>
> Disable device as part of the shutdown sequence.

Applied to 4.18/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
