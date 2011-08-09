From: vinod.koul@intel.com (Koul, Vinod)
Date: Tue, 09 Aug 2011 10:06:18 +0530
Subject: [PATCH] dmaengine: pl330: add missing include of scatterlist.h
In-Reply-To: <CABb+yY2bt0M0X0o-2578eBcP7vwvjykCykKv6e0+HZ17Qset_w@mail.gmail.com>
References: <1312830866-2932-1-git-send-email-robherring2@gmail.com>
	<CABb+yY2bt0M0X0o-2578eBcP7vwvjykCykKv6e0+HZ17Qset_w@mail.gmail.com>
Message-ID: <1312864578.1539.46.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-08-09 at 00:59 +0530, Jassi Brar wrote:
> On Tue, Aug 9, 2011 at 12:44 AM, Rob Herring <robherring2@gmail.com> wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> >
> > scatterlist.h was getting implicitly included and now is not which
> > causes this compile error:
> >
> > drivers/dma/pl330.c: In function ?pl330_prep_slave_sg?:
> > drivers/dma/pl330.c:603:2: error: implicit declaration of function
> > ?for_each_sg?
> >
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Cc: Vinod Koul <vkoul@infradead.org>
> 
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> 
> thnx

Commit 90b44f8 introduces dmaengine_prep_slave_single API which adds
scatterlist.h in dmaengine.h, since you already include dmaengine.h this
patch shouldn't be required

-- 
~Vinod
