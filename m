From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Sep 2012 09:31:46 +0100
Subject: [PATCH v2 04/15] dmaengine: Pass no_wakeup parameter via
 device_prep_dma_cyclic() callback
In-Reply-To: <CACRpkdYAxFzPAZgMsdj9C3YVLzMc_w41Xs0SiqX-1DWaZqxAdw@mail.gmail.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
 <CACRpkdYAxFzPAZgMsdj9C3YVLzMc_w41Xs0SiqX-1DWaZqxAdw@mail.gmail.com>
Message-ID: <20120918083146.GE12445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 11:01:23AM +0200, Linus Walleij wrote:
> On Thu, Sep 13, 2012 at 3:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> > Change the parameter list of device_prep_dma_cyclic() so the DMA drivers
> > can receive the no_wakeup request coming from client drivers.
> > This feature can be used during audio operation to disable all audio
> > related interrupts.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> > CC: Barry Song <baohua.song@csr.com>
> > CC: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> > CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > CC: Vista Silicon <javier.martin@vista-silicon.com>
> > CC: Zhangfei Gao <zhangfei.gao@marvell.com>
> > CC: Shawn Guo <shawn.guo@linaro.org>
> > CC: Laxman Dewangan <ldewangan@nvidia.com>
> 
> After some discussion with clever people I know I have come to the conclusion
> that this is a good idea, so:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

NAKed-by: me

If you look at the other sub-threads of the patch you're acking, you'll
notice that there's a v3 of this patch set which changes the way this is
done.
