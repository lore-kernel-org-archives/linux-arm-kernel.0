From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 21 Apr 2016 05:17:50 +0000
Subject: [PATCH 2/2] dmaengine: vdma: Add clock support
In-Reply-To: <CAAtXAHd=QER9ukD8LKpHCGdmsv=MzJ4bxkvWVEatpfUhsh98SQ@mail.gmail.com>
References: <1461136800-20334-1-git-send-email-appanad@xilinx.com>
 <1461136800-20334-2-git-send-email-appanad@xilinx.com>
 <CAAtXAHd=QER9ukD8LKpHCGdmsv=MzJ4bxkvWVEatpfUhsh98SQ@mail.gmail.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A579616@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

        Thanks for the review...

> -----Original Message-----
> From: Moritz Fischer [mailto:moritz.fischer at ettus.com]
> Sent: Thursday, April 21, 2016 12:09 AM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: Rob Herring <robh+dt@kernel.org>; pawel.moll at arm.com; Mark Rutland
> <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>;
> Kumar Gala <galak@codeaurora.org>; Michal Simek <michals@xilinx.com>;
> Soren Brinkmann <sorenb@xilinx.com>; Vinod Koul <vinod.koul@intel.com>;
> Dan Williams <dan.j.williams@intel.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; Luis de Bethencourt
> <luis@debethencourt.com>; Anirudha Sarangi <anirudh@xilinx.com>; Punnaiah
> Choudary Kalluri <punnaia@xilinx.com>; Devicetree List
> <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
> kernel at lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel at vger.kernel.org>; dmaengine at vger.kernel.org
> Subject: Re: [PATCH 2/2] dmaengine: vdma: Add clock support
>
> Hi,
>
> thanks for looking into this.
>
> On Wed, Apr 20, 2016 at 12:20 AM, Kedareswara rao Appana
> <appana.durga.rao@xilinx.com> wrote:
>
> > +static int xdma_clk_init(struct xilinx_dma_device *xdev, bool enable)
> > +{
> > +       int i = 0, ret;
> > +
> > +       for (i = 0; i < xdev->numclks; i++) {
> > +               if (enable) {
> > +                       ret = clk_prepare_enable(xdev->clks[i]);
> > +                       if (ret) {
> > +                               dev_err(xdev->dev,
> > +                                       "failed to enable the axidma clock\n");
> > +                               return ret;
>
> What happens to the ones you already turned on, if say the third fails?

Will fix in the next version of the patch...

Regards,
Kedar.
>
> Cheers,
>
> Moritz


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
