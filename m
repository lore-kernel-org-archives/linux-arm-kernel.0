From: b32955@freescale.com (Huang Shijie)
Date: Fri, 17 Jan 2014 14:54:03 +0800
Subject: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
 <52D7A237.8@freescale.com>
 <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
 <20140117020226.GB27652@shlinux2.ap.freescale.net>
 <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
Message-ID: <20140117065401.GA6140@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 12:36:08PM +0530, Jagan Teki wrote:
> >> My basic question is like I have a qspi spi controller in my SOC and I
> >> designed two boards B1 and B2
> >
> > okay.
> >
> >> B1 with quad spi controller connected with non-flash as a slave and B2
> >> with quad spi controller connected
> >> with quad flash as a slave.
> > You can use the framework for B2. But for B1, you should not use the framework,
> > since this framework is just for the SPI-NOR. If you do not connected with
> > a NOR, i think it's better to code another driver for your controller.
> 
> Means we have two separate controller drivers for same controller one
> with spi-nor and
> another with spi is it?
Take drivers/spi/spi-imx.c for example, if you connect a NOR to it, you only
need to add a NOR device node in the device tree. In the probe, it will call
the m25p80.c to probe the NOR device.

But if we connect other device to it. you should set another device node for it.

I am not sure if your controller driver can works as the spi-imx.c

thanks
Huang Shijie



 
