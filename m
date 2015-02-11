From: Peter.Chen@freescale.com (Peter Chen)
Date: Wed, 11 Feb 2015 01:36:58 +0000
Subject: [PATCH v3 4/5] usb: phy: load usb phy earlier
In-Reply-To: <20150210144925.GD16711@saruman.tx.rr.com>
References: <20150210070424.GC32709@shlinux2>
 <20150210144925.GD16711@saruman.tx.rr.com>
Message-ID: <BN3PR0301MB08492D4F583C3C7ED250E0B781250@BN3PR0301MB0849.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> On Tue, Feb 10, 2015 at 03:04:28PM +0800, Peter Chen wrote:
> > This patch does not belong to phy, so, doesn't need to add phy in
> > subject, meanwhile, please add GregKH as TO list, he is the right one
> > to queue this patch.
> >
> > Reply-To:
> > In-Reply-To: <1423554627-694-5-git-send-email-zhangfei.gao@linaro.org>
> >
> > On Tue, Feb 10, 2015 at 03:50:26PM +0800, Zhangfei Gao wrote:
> > > Since phy is definitely used in usb controller, load the phy earlier
> > > to make boot time shorter.
> > >
> > > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > > Acked-by: Peter Chen <peter.chen@freescale.com>
> 
> NAK, make sure there are no such dependencies with your controller driver.
> They should know how to defer probing if their resources aren't available yet.
> 

I NAKed it first.

But after thinking more, I think it is a good patch, USB PHY works proper
is the base for coming USB controller operation, with this patch,
it can avoid the controller drivers which are linked earlier than USB PHY
always being probed deferral, look at drivers/Makefile, it links drivers
follow the similar method.

Zhangfei, you may need to add more description in your commit log to prove
it is a good improvement.

Peter
