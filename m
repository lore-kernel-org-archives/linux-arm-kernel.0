From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Nov 2017 09:36:21 -0800
Subject: [PATCH V2 1/7] PCI: protect restore with device lock to be
 consistent
In-Reply-To: <1511763628-11856-2-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-2-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129173621.GB27742@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 01:20:22AM -0500, Sinan Kaya wrote:
> Commit b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify() usage
> with device_lock()") added protection around pci_dev_restore() function so
> that device specific remove callback does not cause a race condition
> against hotplug.
> 
> pci_dev_lock() usage has been forgotten in two different places in the
> code. Adding locks for pci_slot_restore() and moving pci_dev_restore()
> inside the locks for pci_try_reset_function().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
