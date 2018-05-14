From: songxiaowei@hisilicon.com (songxiaowei)
Date: Mon, 14 May 2018 07:40:17 +0000
Subject: =?utf-8?B?562U5aSNOiByZXBseTogW1BBVENIIHYzIDEvMl0gUENJOiBraXJpbjogQWRk?=
 =?utf-8?Q?_MSI_support?=
In-Reply-To: <CAHp75VfHfUCNKNun4-bb2BhwV6D9jg2+hzVjrDER+af0SrzqjA@mail.gmail.com>
References: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
 <CAHp75VfHfUCNKNun4-bb2BhwV6D9jg2+hzVjrDER+af0SrzqjA@mail.gmail.com>
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C54127E490@DGGEMA505-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy Shevchenko

> -----????-----
> ???: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
> ????: 2018?5?14? 15:17
> ???: songxiaowei <songxiaowei@hisilicon.com>
> ??: chenyao (F) <chenyao11@huawei.com>; Wangbinghui
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
> ??: Re: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
> 
> On Mon, May 14, 2018 at 4:11 AM, songxiaowei <songxiaowei@hisilicon.com>
> wrote:
> 
> >> > +       int ret;
> >> > +
> >> > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> >>
> >> > +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
> >> > +               if (pci->pp.msi_irq < 0) {
> >> > +                       dev_err(&pdev->dev, "failed to get MSI IRQ
> >> (%d)\n",
> >> > +                               pci->pp.msi_irq);
> >>
> >> > +                       return -ENODEV;
> >>
> >> Why shadowing actual error code?
> > [songxiaowei]  Sorry, I can't get your point about this, would you explain it
> for me.
> 
> platform_get_irq() returns either correct IRQ number or negative error code.
> In the code above you shadow the actual error (as returned by that
> call) by -ENODEV. Any reason why?
> 
[songxiaowei] I guess the reason is that she wanted to keep the same with other hosts,
           So, you'd like to use "return pci->pp.msi_irq " instead of " return -ENODEV ".
> --
> With Best Regards,
> Andy Shevchenko

Thanks a lot,
Xiaowei.
