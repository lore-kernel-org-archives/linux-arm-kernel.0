From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 31 Aug 2017 18:08:00 +0200
Subject: [PATCH v2 2/4] usb: xhci-mtk: add generic compatible string
In-Reply-To: <20170831160343.GA11200@kroah.com>
References: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
 <33fa448238c0d95f0cfd6c2be3bd5c4e657a0cd4.1502854628.git.chunfeng.yun@mediatek.com>
 <1503443673.17567.8.camel@mhfsdcap03>
 <20170831160343.GA11200@kroah.com>
Message-ID: <20170831160800.GA11700@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 06:03:43PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 23, 2017 at 07:14:33AM +0800, Chunfeng Yun wrote:
> > Hi, Mathias
> > 
> > On Wed, 2017-08-16 at 14:08 +0800, Chunfeng Yun wrote:
> > > The xhci-mtk driver is a generic driver for MediaTek xHCI IP, add
> > > a generic compatible to avoid confusion when support new SoCs but
> > > use a compatible with specific SoC's name "mt8173".
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  drivers/usb/host/xhci-mtk.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > > index 67d5dc7..8fb6065 100644
> > > --- a/drivers/usb/host/xhci-mtk.c
> > > +++ b/drivers/usb/host/xhci-mtk.c
> > > @@ -795,6 +795,7 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
> > >  #ifdef CONFIG_OF
> > >  static const struct of_device_id mtk_xhci_of_match[] = {
> > >  	{ .compatible = "mediatek,mt8173-xhci"},
> > > +	{ .compatible = "mediatek,mtk-xhci"},
> > >  	{ },
> > >  };
> > >  MODULE_DEVICE_TABLE(of, mtk_xhci_of_match);
> > 
> > Do you have any comment about this patch?
> > Thanks.
> 
> We need an ack from the device-tree maintainers before we can take
> them...

Oh nevermind, I see that on the later patches, sorry for the noise...

greg k-h
