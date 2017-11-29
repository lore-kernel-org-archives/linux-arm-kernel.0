From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Nov 2017 09:38:01 -0800
Subject: [PATCH V2 3/7] PCI: make pci_flr_wait() generic and rename to
 pci_dev_wait()
In-Reply-To: <1511763628-11856-4-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-4-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129173801.GD27742@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 01:20:24AM -0500, Sinan Kaya wrote:
> Rev 3.1 Sec 2.3.1 Request Handling Rules:
> Valid reset conditions after which a device is permitted to return CRS
> are:
> * Cold, Warm, and Hot Resets,
> * FLR
> * A reset initiated in response to a D3hot to D0 uninitialized
> 
> Try to reuse FLR implementation towards other reset types.

Should we keep a helper for the FLR wait?  If not I guess the reference
for AF_FLR should be the PCI spec, not the PCIE spec.
