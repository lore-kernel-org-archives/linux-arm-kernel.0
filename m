From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Tue, 14 Jan 2014 13:38:16 +0000
Subject: AArch64 kernel image decompression
In-Reply-To: <201401141351.18988.marex@denx.de>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
 <4250104.UfkPP3heXI@wuerfel> <201401141351.18988.marex@denx.de>
Message-ID: <819346bb83b04348a266643afd5bd6f6@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Marek Vasut [mailto:marex at denx.de]
> Sent: Tuesday, January 14, 2014 6:21 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Arnd Bergmann; Sharma Bhupesh-B45370; 'Catalin Marinas'; 'Josh
> Cartwright'; 'Will Deacon'; Wolfgang Denk
> Subject: Re: AArch64 kernel image decompression
> 
> On Monday, January 13, 2014 at 12:42:41 PM, Arnd Bergmann wrote:
> > On Monday 13 January 2014 11:29:20 bhupesh.sharma at freescale.com wrote:
> > > With the u-boot bootloader also having AArch64 support now (see
> > > [1]), it would make sense to add the uImage and decompressor support
> > > to the
> > > AArch64 Makefile in Linux kernel as well, so that u-boot can also
> > > boot uImages for AArch64 systems out-off-box.
> > >
> > > [1].
> > > http://git.denx.de/?p=u-boot/u-boot-arm.git;a=shortlog;h=refs/heads/
> > > aarc
> > > h64
> >
> > u-boot should never have to use a uImage on arm64, since it already
> > supports booting a vmlinux file.
> 
> Just a side-note. The benefit of uImage (resp. please use fitImage, as
> it's more
> modern) is that it is protected by checksum against possible corruption.
> Besides, U-Boot can do the decompression of uImage payload, so there's no
> need to have decompressor in arm64 kernel.
> 

I agree with Marek. Usually for non-cryptographic-secure (key based cryptography) boot
method the CRC protection is usually the best possible protection against Image
corruption. CRC check is usually used in a number of field-deployed solutions to ensure
linux image sanity. 

Regards,
Bhupesh
