From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Apr 2018 11:20:14 +0200
Subject: [PATCH/RFC 7/8] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig
 symbol
In-Reply-To: <1524230914-10175-8-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-8-git-send-email-geert+renesas@glider.be>
Message-ID: <20180423092011.qnhcorgcu2j5hrls@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 03:28:33PM +0200, Geert Uytterhoeven wrote:
> All drivers for Renesas ARM SoCs have gained proper ARCH_RENESAS
> platform dependencies.  Hence finish the conversion from ARCH_SHMOBILE
> to ARCH_RENESAS for Renesas 32-bit ARM SoCs, as started by commit
> 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on the previous patches in this series, hence the RFC.
> 
> JFTR, after this, the following symbols for drivers supporting only
> Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
>   - CONFIG_KEYBOARD_SH_KEYSC,
>   - CONFIG_VIDEO_SH_VOU,
>   - CONFIG_VIDEO_SH_MOBILE_CEU,
>   - CONFIG_DRM_SHMOBILE[*],
>   - CONFIG_FB_SH_MOBILE_MERAM.
> (changes for a shmobile_defconfig .config)
> 
> [*] CONFIG_DRM_SHMOBILE has a dependency on ARM, but it was never wired
>     up.  From the use of sh_mobile_meram, I guess it was meant for
>     SH-Mobile AP4 on Mackerel or AP4EVB, which are long gone.
>     So the only remaining upstream platforms that could make use of it
>     are legacy SuperH SH-Mobile SoCs?

That sounds about right. If there is interest I can sift through my mail
archive and see if it yields any answers.
