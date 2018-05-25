From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 25 May 2018 17:10:24 -0500
Subject: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
In-Reply-To: <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
 <20180524183502.GB85822@bhelgaas-glaptop.roam.corp.google.com>
 <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
Message-ID: <20180525221024.GC92995@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 09:30:59AM -0400, Sinan Kaya wrote:
> On 5/24/2018 2:35 PM, Bjorn Helgaas wrote:
> > That sounds like a reasonable idea, and it is definitely another can
> > of worms.  I looked briefly at some of the .shutdown() cases:
> 
> should we throw it into 4.18 and see what happens?

It wouldn't solve this particular problem because hpsa *does* have a
.shutdown() method.  The problem is that it doesn't work -- it's
supposed to stop DMA and interrupts but it apparently doesn't.

I think we need to fix hpsa first.
