From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Tue, 14 Jan 2014 03:52:39 +0000
Subject: AArch64 kernel image decompression
In-Reply-To: <4250104.UfkPP3heXI@wuerfel>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <20140113111733.GD1189@mudshark.cambridge.arm.com>
 <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
 <4250104.UfkPP3heXI@wuerfel>
Message-ID: <e79fa209ffc4485d8cae87bae3daa656@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, January 13, 2014 5:13 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Sharma Bhupesh-B45370; 'Will Deacon'; 'Josh Cartwright'; 'Catalin
> Marinas'
> Subject: Re: AArch64 kernel image decompression
> 
> On Monday 13 January 2014 11:29:20 bhupesh.sharma at freescale.com wrote:
> >
> > With the u-boot bootloader also having AArch64 support now (see [1]),
> > it would make sense to add the uImage and decompressor support to the
> > AArch64 Makefile in Linux kernel as well, so that u-boot can also boot
> > uImages for AArch64 systems out-off-box.
> >
> > [1].
> > http://git.denx.de/?p=u-boot/u-boot-arm.git;a=shortlog;h=refs/heads/aa
> > rch64
> 
> u-boot should never have to use a uImage on arm64, since it already
> supports booting a vmlinux file.
> 
> A more sensible thing to add would be vmlinux.gz support in u-boot, if
> that doesn't exist already.
> 

AFAIK, u-boot requires a u-boot specific header (see [1]) on top of any image it wants to
boot - whether it's a uncompressed vmlinux or a compressed vmlinux.gz

In the ARM32 code base we had the Makefile rule to generate a uImage automatically (see [2]), with ARM64
now, I am forced to compress the vmlinux and put a u-boot header on top of it using 'mkimage' and then
feed the 'uImage' thus generated to the u-boot.

So, it would be good if the ARM64 Makefile can mimic the ARM32 one in this aspect - now that we have
a working u-boot capable of booting vanilla linux on an ARMv8 foundation model.

[1]. http://www.denx.de/wiki/DULG/UBootImages
[2]. https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/Makefile?id=refs/tags/next-20140110#n330

Regards,
Bhupesh
