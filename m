From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Sep 2012 15:40:18 +0200
Subject: [PATCH V2] ARM: mx28: Skip OCOTP FEC MAC setup if in DT
In-Reply-To: <20120925114411.GE14216@S2101-09.ap.freescale.net>
References: <1348572738-9743-1-git-send-email-marex@denx.de>
 <20120925114411.GE14216@S2101-09.ap.freescale.net>
Message-ID: <201209251540.18719.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Sep 25, 2012 at 01:32:18PM +0200, Marek Vasut wrote:
> > Currently, the kernel unconditionally adds "local-mac-address" and
> > "mac-address" properties under both FEC ethernet DT nodes in case
> > the update_fec_mac_prop() function is called. These properties are
> > loaded with MAC address compiled from vendors OUI and a per-device
> > NIC saved in OCOTP storage.
> > 
> > Some more advanced bootloaders do augment the DT passed to the kernel
> > by these properties already. In such case, it is wrong for kernel to
> > override these values.
> > 
> > Adjust the FEC MAC address loading so that in case the DT properties
> > are already present in the DT passed from the bootloader, skip the
> > loading from OCOTP altogether. If the DT properties are not present,
> > load them from OCOTP.
> > 
> > Note that the later case will lead to zeroed out MAC address if OCOTP
> > is not programmed. This will lead to FEC not working at all.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> 
> Queued for 3.8, thanks.

Ain't this a bugfix? So maybe CC stable etc. ?

Best regards,
Marek Vasut
