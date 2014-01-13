From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jan 2014 12:42:41 +0100
Subject: AArch64 kernel image decompression
In-Reply-To: <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <20140113111733.GD1189@mudshark.cambridge.arm.com>
 <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <4250104.UfkPP3heXI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 January 2014 11:29:20 bhupesh.sharma at freescale.com wrote:
> 
> With the u-boot bootloader also having AArch64 support now (see [1]), it would
> make sense to add the uImage and decompressor support to the AArch64 Makefile in 
> Linux kernel as well, so that u-boot can also boot uImages for AArch64 systems
> out-off-box.
> 
> [1]. http://git.denx.de/?p=u-boot/u-boot-arm.git;a=shortlog;h=refs/heads/aarch64

u-boot should never have to use a uImage on arm64, since it already
supports booting a vmlinux file.

A more sensible thing to add would be vmlinux.gz support in u-boot,
if that doesn't exist already.

	Arnd
