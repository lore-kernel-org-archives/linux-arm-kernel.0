From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 12 Jan 2011 17:58:51 -0600
Subject: [PATCH 2/2] mach-mmp: PXA910 Drive Strength FAST using wrong value
In-Reply-To: <2F4B855B-51EF-49A9-B0AC-F2B75E3FE639@marvell.com>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
	<201101062029.45604.arnd@arndb.de>
	<ABCC071A-5598-48AA-9545-2712FA0BB624@marvell.com>
	<201101071851.54872.arnd@arndb.de>
	<DE4BADCB-9705-427A-B80E-BB45B8678ACB@marvell.com>
	<2F4B855B-51EF-49A9-B0AC-F2B75E3FE639@marvell.com>
Message-ID: <AANLkTimyahxraLzp11VtCUf6MdD3nNctMG9-vZup9LL+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 7, 2011 at 1:27 PM, Philip Rakity <prakity@marvell.com> wrote:
>
> Drive strength for PXA910 is a 2 bit value but because of the mapping in
> plat-pxa/mfp.h needs to be shifted up one bit to handle real
> location in mfp registers. ?(MMP2 and PXA910 drive strength start
> at bit 11 while PXA168 starts at bit 10).
>
> Values 0, 1, 2, and 3 effectively need to be
> 0, 2, 4, and 6 to fit into register. ?8 does not work.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Applied.

> ---
> ?arch/arm/mach-mmp/include/mach/mfp-pxa910.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> index 7e8a80f..fbd7ee8 100644
> --- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> +++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> @@ -6,7 +6,7 @@
> ?#define MFP_DRIVE_VERY_SLOW ? ?(0x0 << 13)
> ?#define MFP_DRIVE_SLOW ? ? ? ? (0x2 << 13)
> ?#define MFP_DRIVE_MEDIUM ? ? ? (0x4 << 13)
> -#define MFP_DRIVE_FAST ? ? ? ? (0x8 << 13)
> +#define MFP_DRIVE_FAST ? ? ? ? (0x6 << 13)
>
> ?/* UART2 */
> ?#define GPIO47_UART2_RXD ? ? ? MFP_CFG(GPIO47, AF6)
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
