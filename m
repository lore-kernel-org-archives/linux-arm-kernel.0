From: tj@kernel.org (Tejun Heo)
Date: Thu, 21 May 2015 18:20:59 -0400
Subject: [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
In-Reply-To: <CAOMZO5DtNa2-bgdGmiiJM4JZ7MHz2THSsNMwT=9oWO1ThNu2KA@mail.gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
 <CAOMZO5DtNa2-bgdGmiiJM4JZ7MHz2THSsNMwT=9oWO1ThNu2KA@mail.gmail.com>
Message-ID: <20150521222059.GM4914@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 07:16:07PM -0300, Fabio Estevam wrote:
> On Tue, May 12, 2015 at 8:28 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> 
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
> > +       ahci = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(ahci))
> > +               return 0;
> 
> You should propagate 'return PTR_ERR(ahci)' instead.

Brian, can you please update the patch?

Thanks.

-- 
tejun
