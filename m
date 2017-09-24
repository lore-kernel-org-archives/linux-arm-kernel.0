From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 24 Sep 2017 06:08:06 -0700
Subject: [PATCH 3/5] PCI: make pci_flr_wait() generic and rename to
 pci_dev_wait()
In-Reply-To: <1506212218-29103-3-git-send-email-okaya@codeaurora.org>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
 <1506212218-29103-3-git-send-email-okaya@codeaurora.org>
Message-ID: <20170924130806.GA12285@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 23, 2017 at 08:16:56PM -0400, Sinan Kaya wrote:
> Rev 3.1 Sec 2.3.1 Request Handling Rules:
> Valid reset conditions after which a device is permitted to return CRS
> are:
> * Cold, Warm, and Hot Resets,
> * FLR
> * A reset initiated in response to a D3hot to D0 uninitialized
> 
> Try to reuse FLR implementation towards other reset types.

Maybe call it pci_reset_wait instead of pci_dev_wait?
