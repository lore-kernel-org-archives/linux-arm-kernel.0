From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 11:06:18 +0200
Subject: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
In-Reply-To: <561E1957.5030503@hisilicon.com>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
 <11677087.JbqAo0FWJE@wuerfel> <561E1957.5030503@hisilicon.com>
Message-ID: <30775300.COZ4nEMWXC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 16:59:03 Zhou Wang wrote:
> 
> Hi Arnd,
> 
> In Hip05 PCIe host, it uses GITS_TRANSLATER's address to get TLP package
> which contains MSI address and MSI data, and then combine BDF and MSI data
> to a 32 bit data which will be writen to GITS_TRANSLATER register of ITS.
> 
> I think maybe this is a defect of our PCIe controller.

I'd consider it a bug in the firmware if this is not set up correctly
before boot.

> > I don't think what you do here is safe because the 'reg' property
> > of the MSI controller might point to the address that is used for
> > the message directly.
> 
> I see your point, however we must get address of GITS_TRANSLATER and
> set it to PCIe host. How about adding necessary comments here?

This seems to just be static setup that should be done before Linux
is even loaded. Any reason you can't do it that way?

	Arnd
