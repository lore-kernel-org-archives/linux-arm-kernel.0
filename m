From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 08:44:05 +0000
Subject: [PATCH 1/3] ARM: PRIMA2: use DT_MACHINE_START and convert to
 generic board
In-Reply-To: <CAGsJ_4x+sm9=bg1Riyeb6JF0sSC-n=ZBAy6ibx_Styu5rM9yYA@mail.gmail.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <201208210753.12718.arnd@arndb.de>
 <CAGsJ_4x+sm9=bg1Riyeb6JF0sSC-n=ZBAy6ibx_Styu5rM9yYA@mail.gmail.com>
Message-ID: <201208210844.05153.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Barry Song wrote:
> > I mean the old version, not the new one. If you use MACHINE_START,
> > you cannot access the device tree data from the boot loader, which
> > means that none of the device drivers find their devices.
> 
> sorry i didn't get you.
> 
> DT is read to 0x3608000 by bootloader, and bootm has param "bootm
> 0x02008000 - 0x3608000" as:
> 
> bootcmd=mmc read 0 0x3608000 0x3780 0x80;mmc read 0 0x02008000 0x1800
> 0x1800;fdt addr 0x3608000;
> fdt resize;bootm 0x02008000 - 0x3608000
> 
> kernel has been always able to read DT data from bootloader.

Ah, right. I had to read the initialition code again, my incorrect
assumption was that we could not use a machine_desc that is
declared with MACHINE_START() together with a flattened device tree.

	Arnd
