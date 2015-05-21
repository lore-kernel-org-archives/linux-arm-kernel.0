From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 21 May 2015 15:26:10 -0700
Subject: [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
In-Reply-To: <20150521222059.GM4914@htj.duckdns.org>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
 <CAOMZO5DtNa2-bgdGmiiJM4JZ7MHz2THSsNMwT=9oWO1ThNu2KA@mail.gmail.com>
 <20150521222059.GM4914@htj.duckdns.org>
Message-ID: <CAN8TOE-eQF1QGSYTm12ryWy868jfJ+B1XUbSgpm9v275rCaFTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 3:20 PM, Tejun Heo <tj@kernel.org> wrote:
> On Thu, May 21, 2015 at 07:16:07PM -0300, Fabio Estevam wrote:
>> On Tue, May 12, 2015 at 8:28 PM, Brian Norris
>> <computersforpeace@gmail.com> wrote:
>>
>> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
>> > +       ahci = devm_ioremap_resource(&pdev->dev, res);
>> > +       if (IS_ERR(ahci))
>> > +               return 0;
>>
>> You should propagate 'return PTR_ERR(ahci)' instead.
>
> Brian, can you please update the patch?

Note how the function brcm_ahci_get_portmask() is used. In brcm_ahci_probe():

        priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
        if (!priv->port_mask)
                return -ENODEV;

I could try to change the return semantics if really needed. Or I
could add some comments on brcm_ahci_get_portmask() to note its return
semantics. Or I could just leave the driver as-is. Your call.

Brian
