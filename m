From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 23 Jun 2017 18:22:13 +0800
Subject: next-20170621 build: 1 failures 7 warnings (next-20170621)
In-Reply-To: <20170623094356.GA5337@red-moon>
References: <E1dNcMp-0005RN-1w@optimist>
 <20170621100440.vcaxagg4yjca2cv4@sirena.org.uk>
 <1498209196.26313.71.camel@mtkswgap22> <20170623094356.GA5337@red-moon>
Message-ID: <1498213333.2190.24.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-06-23 at 10:43 +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 23, 2017 at 05:13:16PM +0800, Ryder Lee wrote:
> > Sorry for late reply, 
> > 
> > +Lorenzo
> > 
> > On Wed, 2017-06-21 at 18:04 +0800, Mark Brown wrote:
> > > On Wed, Jun 21, 2017 at 10:56:07AM +0100, Build bot for Mark Brown wrote:
> > > 
> > > Today's -next fails to build an arm allmodconfig due to:
> > > 
> > > > 	arm-allmodconfig
> > > > ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]
> > > 
> > > caused by eaf3023b0498a (PCI: mediatek: Add MediaTek PCIe host
> > > controller support).
> > 
> > 
> > Hi Lorenzo,
> > 
> > I picked up your changes and had some modifications like what you did
> > for other platforms:
> > 
> > 9f8e3a5 PCI: Add devm_pci_alloc_host_bridge() interface 
> > 35a1a84 PCI: Add pci_free_host_bridge() interface
> > e33aafd PCI: Initialize bridge release function at bridge allocation
> > 
> > ...and it looks Okay.
> > 
> > I have also noticed that you continue sending patches for other
> > platforms but I have not yet had a look in detail. I'm quite busy these
> > days and don't have time to dig it, hence it is becoming a little
> > unmanageable for me.
> 
> If it is unmanageable you don't add yourself as a maintainer of that
> PCI host bridge driver, you know, we are all busy.
> 
> Your driver in the PCI tree as it stands contains already two bugs:
> 
> 1) It leaks memory on the probe failure path
> 2) pci_fixup_irqs() is broken on configurations with multiple host
>    bridges
> 
> And we keep copy'n'pasting that code.

Sure, I have already tested it, and I'll send a patch with your new
methods :)


> > Did you have a chance to send the same patches for MediaTek?  I
> > appreciate that and I can help to test it on our platforms.
> 
> No, how could I have sent them ? It is not upstream and it is a separate
> branch in the PCI tree. As I mentioned in another thread it is probably
> best to drop my pci_fixup_irqs() removal patches since it is impossible
> to work on them without a stable branch to apply them against, in the
> interim we keep adding PCI host bridges that use the wrong interfaces by
> copy'n'pasting code that I have been trying to remove.
> 
> I think the best solution is to repost my series when v4.13-rc1 appears
> and ask all new crop of host bridge drivers to rebase against it.
> 
> I won't be able to follow mailing lists till end of next week, which
> is bad timing.

I meant I'm also not sure how to do it in separate branch. I didn't
notice what you discussed in another thread. Sorry about that.

> Bjorn, is the plan above ok ? Please let me know how you want to
> proceed.
> 
> Thanks,
> Lorenzo

Ryder
