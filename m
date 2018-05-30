From: ryan@finnie.org (Ryan Finnie)
Date: Tue, 29 May 2018 18:50:11 -0700
Subject: [PATCH V3 2/2] scsi: hpsa: drop shutdown callback
In-Reply-To: <1527542471-10316-2-git-send-email-okaya@codeaurora.org>
References: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
 <1527542471-10316-2-git-send-email-okaya@codeaurora.org>
Message-ID: <51bb7b82-c4a1-435c-7668-639db96d76e1@finnie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2018 02:21 PM, Sinan Kaya wrote:
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
> Drop the shutdown API and do an orderly clean up by using the remove.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Cc: stable at vger.kernel.org
> Reported-by: Ryan Finnie <ryan@finnie.org>

Tested successfully on DL360 Gen9 and DL380 Gen9.

Tested-by: Ryan Finnie <ryan@finnie.org>
