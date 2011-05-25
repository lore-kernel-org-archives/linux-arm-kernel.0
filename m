From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 25 May 2011 13:56:49 +0530
Subject: [PATCH] dmaengine: Add API documentation for slave dma usage
In-Reply-To: <BANLkTikAm=D_YNFt0Regeas6AX8116L0-A@mail.gmail.com>
References: <1306238657-30089-1-git-send-email-vinod.koul@intel.com>
	<BANLkTikDPeEFWdsVQ=Ak8jXEXsC-+uoOaw@mail.gmail.com>
	<1306253171.30236.9.camel@vkoul-udesk3>
	<BANLkTikjxECNAK5eS5hSu2bbEKpZX341Dw@mail.gmail.com>
	<BANLkTikAm=D_YNFt0Regeas6AX8116L0-A@mail.gmail.com>
Message-ID: <1306312009.30236.110.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-25 at 09:47 +0200, Per Forlin wrote:
> On 24 May 2011 23:03, Dan Williams <dan.j.williams@intel.com> wrote:

> >>> Does submit really start the transfer as well? My interpretation of
> >>> submit is that is only adds desc to a pending queue. When calling
> >>> issue_pending all these descs will be schedule for DMA transfer. Calls
> >>> to submit after this point will added to the pending queue again and
> >>> not be issued until calling issue_pending once more.
> >> For slave dma devices, submit() is used to start the transaction if the
> >> channel is idle. If its already doing a transaction then it will queue
> >> it up and submit once cureent excuting one is completed. It is not
> >> required to call issue_pending once more.
> >> I am not sure if this is true for non slave usage, Dan would that be
> >> correct for you as well?
> >
> > No, ->submit() is just an "add this descriptor to the chain"
> > operation, and ->issue_pending() is always required to make sure the
> > everything submitted previously is actively executing.  This was a
> > holdover from the very first dmaengine implementation where, for
> > efficiency reasons, it could save mmio writes by batching the issuing
> > of requests.
> Thanks Dan for clarifying.
> Vinod, I propose that the submit and issue_pending works the same for
> SLAVE and none SLAVE channels. The API should have the same definition
> independent of DMA_CAP. Please enlighten me if there are things I have
> foreseen on this matter.
I am okay with making this same for the slave devices as well.

That would also require to change few drivers which start the txn in
submit()


-- 
~Vinod
