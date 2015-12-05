From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Sat, 5 Dec 2015 11:12:43 +0800
Subject: [PATCH] usb: xhci-mtk: fix AHB bus hang up caused by roothubs
 polling
In-Reply-To: <56619410.4000705@cogentembedded.com>
References: <1449196807-31785-1-git-send-email-chunfeng.yun@mediatek.com>
 <56619410.4000705@cogentembedded.com>
Message-ID: <1449285163.11314.5.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Fri, 2015-12-04 at 16:24 +0300, Sergei Shtylyov wrote:
> Hello.
> 
>     Sorry for the grammar nitpicking but since it's in the comments, I felt 
> the necessity to comment.
> 
> On 12/4/2015 5:40 AM, Chunfeng Yun wrote:
> 
> > when ip fail to enter sleep mode, register access protection will
> 
>     Fails.
> 
> > be disabed, at the same time if all clocks are disabled, access
>       ^^^^^^^ disabled
> 
> > register will hang up AHB bus.
> > the common case causes ip sleep fail is that after all ports enter
> 
>     Failure.
> 
> > U3 but before ip enters sleep mode, a port receives a resume
> > signal('K'). this will happens when such as clicks mouse to try to
> > do remote wakeup to stop system enter suspend.
> 
>     Wake up.
> 
> > so stop polling roothubs to avoid access xHCI register on bus
> 
>     Root hubs. Accessing.
> 
> > suspend, and restart it when bus resume.
> 
>     Resumes. Or "is resumed", maybe?
> 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >   drivers/usb/host/xhci-mtk.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > index c9ab6a4..38635fb 100644
> > --- a/drivers/usb/host/xhci-mtk.c
> > +++ b/drivers/usb/host/xhci-mtk.c
> > @@ -696,9 +696,24 @@ static int xhci_mtk_remove(struct platform_device *dev)
> >   }
> >
> >   #ifdef CONFIG_PM_SLEEP
> > +/*
> > + * if ip sleep fail, and all clocks are disabled, access register will hang
> 
>     Fails.
> 
> > + * AHB bus, so stop poll roothubs to avoid regs access on bus suspend.
> 
>     Polling.
> 
> > + * and no need to check whether ip sleep fail or not; this will cause SPM to
> 
>     Failed.
> 
> > + * wakeup system immediately after system suspend complete if ip sleep
> 
>     Wake up.
> 
> > + * fail, it is what we wanted.
> 
>     Fails.
> 

I do need to pay more attention to the grammar from now on.

Thanks a lot

> > + */
> [...]
> 
> MBR, Sergei
> 
