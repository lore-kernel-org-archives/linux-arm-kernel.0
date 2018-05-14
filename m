From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 14 May 2018 10:16:54 +0300
Subject: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
In-Reply-To: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
References: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
Message-ID: <CAHp75VfHfUCNKNun4-bb2BhwV6D9jg2+hzVjrDER+af0SrzqjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 4:11 AM, songxiaowei <songxiaowei@hisilicon.com> wrote:

>> > +       int ret;
>> > +
>> > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>
>> > +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
>> > +               if (pci->pp.msi_irq < 0) {
>> > +                       dev_err(&pdev->dev, "failed to get MSI IRQ
>> (%d)\n",
>> > +                               pci->pp.msi_irq);
>>
>> > +                       return -ENODEV;
>>
>> Why shadowing actual error code?
> [songxiaowei]  Sorry, I can't get your point about this, would you explain it for me.

platform_get_irq() returns either correct IRQ number or negative error code.
In the code above you shadow the actual error (as returned by that
call) by -ENODEV. Any reason why?

-- 
With Best Regards,
Andy Shevchenko
