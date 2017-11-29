From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Nov 2017 09:36:42 -0800
Subject: [PATCH V2 2/7] PCI: handle FLR failure and allow other reset types
In-Reply-To: <1511763628-11856-3-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-3-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129173642.GC27742@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 01:20:23AM -0500, Sinan Kaya wrote:
> pci_flr_wait() and pci_af_flr() functions assume graceful return even
> though the device is inaccessible under error conditions.
> 
> Return -ENOTTY in error cases so that __pci_reset_function_locked() can
> try other reset types if AF_FLR/FLR reset fails.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
