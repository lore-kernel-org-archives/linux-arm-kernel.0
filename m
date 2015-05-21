From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 21 May 2015 19:16:07 -0300
Subject: [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
In-Reply-To: <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
Message-ID: <CAOMZO5DtNa2-bgdGmiiJM4JZ7MHz2THSsNMwT=9oWO1ThNu2KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 8:28 PM, Brian Norris
<computersforpeace@gmail.com> wrote:

> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
> +       ahci = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(ahci))
> +               return 0;

You should propagate 'return PTR_ERR(ahci)' instead.
