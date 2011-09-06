From: msalter@redhat.com (Mark Salter)
Date: Tue, 06 Sep 2011 10:37:15 -0400
Subject: [PATCH 2/3] define ARM-specific dma_coherent_write_sync
In-Reply-To: <CAHkRjk7ZMDQh8sYf7N_4LLS12JU2ps8dkC34gNWNH+-Zp0p8Rg@mail.gmail.com>
References: <1314826214-22428-1-git-send-email-msalter@redhat.com>
	<1314826214-22428-3-git-send-email-msalter@redhat.com>
	<CAHkRjk7ZMDQh8sYf7N_4LLS12JU2ps8dkC34gNWNH+-Zp0p8Rg@mail.gmail.com>
Message-ID: <1315319837.2313.1.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-09-06 at 15:32 +0100, Catalin Marinas wrote:
> That's what mb() and wmb() do already, at least on ARM. Why do we need
> another API? IIRC from past discussions on linux-arch around barriers,
> the mb() should be sufficient in the case of DMA coherent buffers.
> That's why macros like writel() on ARM have the mb() added by default
> (for cases where you start the DMA transfer by writing to a device
> register). 

For USB EHCI, the driver does not necessarily write to a register after
writing to DMA coherent memory. In some cases, the controller polls for
information written by the driver.

--Mark
