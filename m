From: songxiaowei@hisilicon.com (songxiaowei)
Date: Mon, 14 May 2018 01:11:10 +0000
Subject: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Andy Shevchenko

Yao is on maternity leave, and I'll take over the job after discussing with her.

> -----????-----
> ???: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
> ????: 2018?5?14? 7:16
> ???: chenyao (F) <chenyao11@huawei.com>
> ??: songxiaowei <songxiaowei@hisilicon.com>; Wangbinghui
> <wangbinghui@hisilicon.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>;
> Bjorn Helgaas <bhelgaas@google.com>; xuwei (O) <xuwei5@huawei.com>;
> Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-pci at vger.kernel.org; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-arm Mailing List
> <linux-arm-kernel@lists.infradead.org>; devicetree
> <devicetree@vger.kernel.org>; dimitrysh at google.com;
> guodong.xu at linaro.org; Suzhuangluan <suzhuangluan@hisilicon.com>; Kongfei
> <kongfei@hisilicon.com>
> ??: Re: [PATCH v3 1/2] PCI: kirin: Add MSI support
> 
> On Fri, May 11, 2018 at 12:15 PM, Yao Chen <chenyao11@huawei.com> wrote:
> > Add support for MSI.
> 
> 
> > +       int ret;
> > +
> > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> 
> > +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
> > +               if (pci->pp.msi_irq < 0) {
> > +                       dev_err(&pdev->dev, "failed to get MSI IRQ
> (%d)\n",
> > +                               pci->pp.msi_irq);
> 
> > +                       return -ENODEV;
> 
> Why shadowing actual error code?
[songxiaowei]  Sorry, I can't get your point about this, would you explain it for me.
> 
> > +               }
> > +               ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> > +                                      kirin_pcie_msi_irq_handler,
> > +                                      IRQF_SHARED |
> IRQF_NO_THREAD,
> > +                                      "kirin_pcie_msi", &pci->pp);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "failed to request MSI
> IRQ %d\n",
> > +                               pci->pp.msi_irq);
> > +                       return ret;
> > +               }
> 
> It would be easy to read and maintain if this would be a separate function.
[songxiaowei] Yes, a separate function will be better, and I'll fix it.
> 
> > +       }
> 
> 
> 
> --
> With Best Regards,
> Andy Shevchenko

Thanks a lot,

Best Regards,
Xiaowei Song
