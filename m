From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 22 Mar 2018 13:00:21 +0100
Subject: [usb-next, v2 PATCH] usb: xhci: skip phys initialization of
 shared hcd
In-Reply-To: <1521710486.3717.146.camel@mhfsdcap03>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
 <20180322090127.GA12048@kroah.com>
 <1521710486.3717.146.camel@mhfsdcap03>
Message-ID: <20180322120021.GA3304@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 05:21:26PM +0800, Chunfeng Yun wrote:
> hi, 
> On Thu, 2018-03-22 at 10:01 +0100, Greg Kroah-Hartman wrote:
> > On Thu, Mar 22, 2018 at 04:39:20PM +0800, Chunfeng Yun wrote:
> > > The phys has already been initialized when add primary hcd,
> > > including usb2 phys and usb3 phys also if exist, so needn't
> > > re-parse "phys" property again.
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  drivers/usb/core/hcd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > What changed from version 1?
> V1: skip phys initialization when add shared HCD by setting
> xhci->shared_hcd->skip_phy_initialization=1;
> for both xhci-plat.c & xhci-mtk.c files.
> 
> V2: fix it in hcd.c suggested by Roger

Please put it in the patch itself, resend v3 with this info.

thanks,

greg k-h
