From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 9 Dec 2014 11:40:03 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <20141208142321.GE11285@n2100.arm.linux.org.uk>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
 <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
 <20141205151843.GV11285@n2100.arm.linux.org.uk>
 <CAJe_ZhfDsfehCXHB6pCuQ6672kXBYFxh687cZT1qaSCOyLy76g@mail.gmail.com>
 <20141208130727.GK16827@intel.com>
 <20141208142321.GE11285@n2100.arm.linux.org.uk>
Message-ID: <20141209061003.GX16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 02:23:21PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 08, 2014 at 06:37:27PM +0530, Vinod Koul wrote:
> > I actually like the split model, you can also prepare txn ahead of time and
> > submit them when needed.
> 
> Actually, you can't - that's not permitted.  I have email(s) from Dan
> explicitly stating that it is permitted for a driver to take a spinlock
> in their prepare callback, and release it when the descriptor is
> submitted.  Several DMA engine drivers (particularly those in for
> async_tx) do exactly that.
> 
> The reason that submit is separate from prepare is to allow DMA engine
> users to set a callback - if it weren't for that, there wouldn't be a
> submit step, prepare would have done everything.
Yes thats right.

Do you mind pointing to thread Dan replied, I would like to add these bits
and anything else missing to Documentation

Thanks
-- 
~Vinod
