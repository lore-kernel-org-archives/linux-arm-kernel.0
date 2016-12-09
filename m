From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Dec 2016 20:02:00 +0000
Subject: [PATCH] nommu: allow mmap when !CONFIG_MMU
In-Reply-To: <1480600080-30196-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1480600080-30196-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <20161209200200.GN14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 02:48:00PM +0100, Benjamin Gaignard wrote:
> commit ab6494f0c96f ("nommu: Add noMMU support to the DMA API") have
> add CONFIG_MMU compilation flag but that prohibit to use dma_mmap_wc()
> when the platform doesn't have MMU.
> 
> This patch call vm_iomap_memory() in noMMU case to test if addresses
> are correct and set wma->vm_flags rather than all return an error.

ITYM vma.

I think this is fine, but I've no way to know as I don't run nommu here...
I've been hoping that others working on nommu would at least give an
ack or something, but I guess not.

So, please put it in the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
