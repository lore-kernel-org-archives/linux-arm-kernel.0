From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 27 Mar 2018 09:14:56 -0500
Subject: [GIT PULL 2/2] arm64: stratix10: defconfig update for v4.17
In-Reply-To: <CAK8P3a0TTKEsmMavojQQcFG4-Y3EiDNtavLV2QdyHjNXHTE2Lw@mail.gmail.com>
References: <1521834884-23795-1-git-send-email-dinguyen@kernel.org>
 <1521834884-23795-2-git-send-email-dinguyen@kernel.org>
 <CAK8P3a0TTKEsmMavojQQcFG4-Y3EiDNtavLV2QdyHjNXHTE2Lw@mail.gmail.com>
Message-ID: <c2860375-961a-65c4-ff23-6a2c4485699b@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/27/2018 08:31 AM, Arnd Bergmann wrote:
> On Fri, Mar 23, 2018 at 8:54 PM, Dinh Nguyen <dinguyen@kernel.org> wrote:
> 
>> ----------------------------------------------------------------
>> ARM64: stratix10: defconfig updates for 4.17
>> -enables STMMAC_ETH controller that is present on Stratix10
> 
> I got a conflict against an earlier patch that enabled CONFIG_STMMAC_ETH=m
> and kept that version, as I see no need to have it built-in, see below for the
> merge conflict resolution.
> 
>      Arnd
> 
> diff --cc arch/arm64/configs/defconfig
> index 1d3b40615efb,a3ea32e4312f..5e4ff17a3ad8
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -220,8 -209,12 +220,13 @@@ CONFIG_QCOM_EMAC=
>   CONFIG_RAVB=y
>   CONFIG_SMC91X=y
>   CONFIG_SMSC911X=y
>  -CONFIG_STMMAC_ETH=y
>  +CONFIG_SNI_NETSEC=y
>  +CONFIG_STMMAC_ETH=m
> + CONFIG_DWMAC_IPQ806X=m
> + CONFIG_DWMAC_MESON=m
> + CONFIG_DWMAC_ROCKCHIP=m
> + CONFIG_DWMAC_SUNXI=m
> + CONFIG_DWMAC_SUN8I=m
>   CONFIG_MDIO_BUS_MUX_MMIOREG=y
>   CONFIG_AT803X_PHY=m
>   CONFIG_MARVELL_PHY=m
> 

The Stratix10 SoC needs to use the stmmac ethernet driver if it the user
wants to mount a filesystem over NFS. Is there a way to load the
ethernet module during boot-up before trying to mount into a RFS?

Dinh
