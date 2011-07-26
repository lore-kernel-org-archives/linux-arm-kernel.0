From: vkoul@infradead.org (Vinod Koul)
Date: Tue, 26 Jul 2011 16:16:42 +0530
Subject: [PATCH v2] dmaengine: pl330: make platform data optional
In-Reply-To: <CABb+yY1BydX=YMe_nenkYr+bsH-3k3gObO3qav5AA5DrxMP=2Q@mail.gmail.com>
References: <1310518811-379-1-git-send-email-robherring2@gmail.com>
	<1311627904-24045-1-git-send-email-robherring2@gmail.com>
	<CABb+yY1BydX=YMe_nenkYr+bsH-3k3gObO3qav5AA5DrxMP=2Q@mail.gmail.com>
Message-ID: <1311677203.24316.4.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-07-26 at 10:09 +0530, Jassi Brar wrote:
> On Tue, Jul 26, 2011 at 2:35 AM, Rob Herring <robherring2@gmail.com> wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> >
> > The pl330 needs platform data for describing peripheral connections, but
> > some platforms may only support memory to memory dma channels. In this
> > case, we can probe for how many channels there are and don't need the
> > platform data.
> >
> > As memcpy requests don't need channel private data to hold peripheral
> > info, allow private data to be NULL in this case.
> >
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Cc: Vinod Koul <vkoul@infradead.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> >
> > ---
> > Vinod, Can you apply this updated version instead?
> >
> > v2:
> >  - Added null ptr check
> >
> >  drivers/dma/pl330.c |   64 ++++++++++++++++++++++++++++----------------------
> >  1 files changed, 36 insertions(+), 28 deletions(-)
> 
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Applied thanks

-- 
~Vinod Koul
Intel Corp.
