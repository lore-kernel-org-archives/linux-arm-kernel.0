From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 17 Oct 2013 10:46:36 +0530
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <525EEA18.1010802@wwwdotorg.org>
References: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
 <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007111728.GM12758@n2100.arm.linux.org.uk>
 <20131007103936.GH2954@intel.com>
 <CAA9_cmdSh8j5rmzZ=SsOG_pRa+Aq1odEEWKvVNOUv9G0Ma=dEw@mail.gmail.com>
 <525EEA18.1010802@wwwdotorg.org>
Message-ID: <20131017051636.GB14013@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 01:33:44PM -0600, Stephen Warren wrote:
> On 10/08/2013 07:34 PM, Dan Williams wrote:
> > On Mon, Oct 7, 2013 at 3:39 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> >> On Mon, Oct 07, 2013 at 12:17:28PM +0100, Russell King - ARM Linux wrote:
> ...
> >>> What may be better is to change the wording here: not DMA_SUCCESS but
> >>> DMA_COMPLETED.  That doesn't imply that it has been successful, merely
> >>> that the DMA engine has finished with the transaction.
> >>
> >> Agreed that its not indication of success but of DMA completetion. I have seen
> >> cases where slave perhiphral got stuck while sending last FIFO but since DMA
> >> finished transferiing to FIFO it says complete.
> 
> In that case, the DMA *has* completed. DMA is the transfer into the
> FIFO, not the handling of the FIFO content by the peripheral.
> 
> >> Dan do you agree?
> > 
> > Yes, it's an indication of completion, not necessarily success.
> 
> Surely by definition, a DMA can't *complete* without being successful.
> If the DMA failed, then it didn't complete, but rather must have been
> aborted or error'd out, without completing the whole transfer.
DMA means transferring of data, and that is what DMA compeletion would mean.
Once the data has left the DMA FIFO, we don't know if it filled up the memory
propery or get stuck in periphral FIFO, the dmaengine would have no knowledge or
control of it. So it can't claim the transfer was success from a data point of
view, hence the rename now!

~Vinod
-- 
