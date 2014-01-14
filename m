From: marex@denx.de (Marek Vasut)
Date: Tue, 14 Jan 2014 13:51:18 +0100
Subject: AArch64 kernel image decompression
In-Reply-To: <4250104.UfkPP3heXI@wuerfel>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
 <4250104.UfkPP3heXI@wuerfel>
Message-ID: <201401141351.18988.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 13, 2014 at 12:42:41 PM, Arnd Bergmann wrote:
> On Monday 13 January 2014 11:29:20 bhupesh.sharma at freescale.com wrote:
> > With the u-boot bootloader also having AArch64 support now (see [1]), it
> > would make sense to add the uImage and decompressor support to the
> > AArch64 Makefile in Linux kernel as well, so that u-boot can also boot
> > uImages for AArch64 systems out-off-box.
> > 
> > [1].
> > http://git.denx.de/?p=u-boot/u-boot-arm.git;a=shortlog;h=refs/heads/aarc
> > h64
> 
> u-boot should never have to use a uImage on arm64, since it already
> supports booting a vmlinux file.

Just a side-note. The benefit of uImage (resp. please use fitImage, as it's more 
modern) is that it is protected by checksum against possible corruption. 
Besides, U-Boot can do the decompression of uImage payload, so there's no need 
to have decompressor in arm64 kernel.

Best regards,
Marek Vasut
