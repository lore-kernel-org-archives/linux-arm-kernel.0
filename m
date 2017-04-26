From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 26 Apr 2017 16:41:02 +0800
Subject: [RFC] usb: chipidea: set dma_ops for the created ci_hdrc
 platform_device
In-Reply-To: <CAK8P3a09fJCexChnoEyBpLK17rHaQTz9G+7iZWRocZGykyxsWA@mail.gmail.com>
References: <20170425180151.0f03ca0e@xhacker>
 <CAK8P3a09fJCexChnoEyBpLK17rHaQTz9G+7iZWRocZGykyxsWA@mail.gmail.com>
Message-ID: <20170426164102.5bd1a48b@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 25 Apr 2017 13:09:27 +0200 Arnd Bergmann wrote:

> On Tue, Apr 25, 2017 at 12:01 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> > Hi all,
> >
> > After commit 1dccb598df549 ("arm64: simplify dma_get_ops"), the chipidea
> > driver can't work any more on Marvell Berlin arm64 platforms, the reason
> > is the created ci_hdrc platform_device's dma_ops is dummy_dma_ops, so all
> > dma related operations will fail. The fix I can think of would be something
> > as below:
> >
> > And I noticed that dwc3 has the same issue[1], and as pointed out in its
> > discussion, the patch can't fix None-DT platforms, so could you please
> > guide me what's the proper fix which can be mainlined?  
> 
> I think the right solution is:
> 
> - Set the "sysdev" pointer tin the USB device o the device structure that
>   was created by DT or the legacy board file and remove the manual
>   setting of dma_mask,  parms and the dma_configure. This should
>   make everything work as expected in case of DT
> 

oh yeah! I see a proper fix in linux-next tree, thanks for fixing it.
