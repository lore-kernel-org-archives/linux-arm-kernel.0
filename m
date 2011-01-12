From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 12 Jan 2011 17:03:14 -0600
Subject: [PATCH 1/2] mach-mmp: MMP2 Drive Strength FAST using wrong value
In-Reply-To: <DE4BADCB-9705-427A-B80E-BB45B8678ACB@marvell.com>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
	<201101062029.45604.arnd@arndb.de>
	<ABCC071A-5598-48AA-9545-2712FA0BB624@marvell.com>
	<201101071851.54872.arnd@arndb.de>
	<DE4BADCB-9705-427A-B80E-BB45B8678ACB@marvell.com>
Message-ID: <AANLkTinMWvGfwF0WrinsTh7SJqLu7TfUMZduCPNMGOHp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 7, 2011 at 1:26 PM, Philip Rakity <prakity@marvell.com> wrote:
>
> Drive strength for MMP2 is a 2 bit value but because of the mapping in
> plat-pxa/mfp.h needs to be shifted up one bit to handle real
> location in mfp registers. ?(MMP2 and PXA910 drive strength start
> at bit 11 while PXA168 starts at bit 10).
>
> Values 0, 1, 2, and 3 effectively need to be
> 0, 2, 4, and 6 to fit into register. ?8 does not work.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Tested-by: John Watlington <wad@laptop.org>

Applied.

> ---
> ?arch/arm/mach-mmp/include/mach/mfp-mmp2.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/mfp-mmp2.h b/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
> index 117e303..4ad3862 100644
> --- a/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
> +++ b/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
> @@ -6,7 +6,7 @@
> ?#define MFP_DRIVE_VERY_SLOW ? ?(0x0 << 13)
> ?#define MFP_DRIVE_SLOW ? ? ? ? (0x2 << 13)
> ?#define MFP_DRIVE_MEDIUM ? ? ? (0x4 << 13)
> -#define MFP_DRIVE_FAST ? ? ? ? (0x8 << 13)
> +#define MFP_DRIVE_FAST ? ? ? ? (0x6 << 13)
>
> ?/* GPIO */
> ?#define GPIO0_GPIO ? ? MFP_CFG(GPIO0, AF0)
> --
> 1.7.0.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
