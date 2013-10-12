From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 Oct 2013 15:13:15 +0800
Subject: [PATCH 2/2] PCI: imx6: Fix the clock for PCIe
In-Reply-To: <201310111355.04746.marex@denx.de>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
 <1381457552-6575-2-git-send-email-marex@denx.de>
 <000c01cec652$55adbb30$01093190$%han@samsung.com>
 <201310111355.04746.marex@denx.de>
Message-ID: <20131012071312.GA21305@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 01:55:04PM +0200, Marek Vasut wrote:
> > It is because driver part was merged into PCI tree by Bjorn Helgaas,[1]
> > and arch part was merged into i.MX tree by Shawn Guo.[2]
> > Thus, your patch can make the conflict issue.
> > 
> > For example,
> >   [PATCH 1/2] ARM: dts: imx6qdl: Fix the clock for PCIe
> >   [PATCH 2/2] PCI: imx6: Fix the clock for PCIe
> > 
> > Then, 1st patch can be merged to i.MX tree, and 2nd patch can be merged
> > to PCI tree.
> > 
> > If I am wrong, please let me know kindly. :-)
> 
> By all means, you're right. Is the patch addressing the issue correctly (if we 
> ignore that it's not split)? Shawn?

I need to first understand if you are seeing the issue with the latest
linux-next like next-20131010.  Note, linux-next tree goes to
git://gitorious.org/thierryreding/linux-next [1] these days.

Shawn

[1] https://lkml.org/lkml/2013/9/30/179
