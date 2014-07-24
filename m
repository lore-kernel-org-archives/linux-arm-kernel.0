From: olof@lixom.net (Olof Johansson)
Date: Thu, 24 Jul 2014 08:39:30 -0700
Subject: linux-next: manual merge of the usb tree with the arm-soc tree
In-Reply-To: <20140724163329.03002387@canb.auug.org.au>
References: <20140724162811.5e12107a@canb.auug.org.au>
 <20140724163329.03002387@canb.auug.org.au>
Message-ID: <CAOesGMgZHHKLMeyGKq_ZfSxWsRcLL3a=ogbW8s=KTUrjf6L3qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 11:33 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Greg,
>
> On Thu, 24 Jul 2014 16:28:11 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the usb tree got a conflict in
>> drivers/phy/Kconfig between commit 64562e99477f ("phy: Add drivers for
>> PCIe and SATA phy on SPEAr13xx") from the arm-soc tree and commit
>> 1de990d8a169 ("phy: qcom: Add driver for QCOM APQ8064 SATA PHY") from
>> the usb tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary (no action
>> is required).
>
> Also drivers/phy/Makefile
>
> --
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
>
> diff --cc drivers/phy/Makefile
> index 241c741e6e39,971ad0aac388..000000000000
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@@ -18,8 -21,7 +21,10 @@@ phy-exynos-usb2-y                    += phy-samsung-usb2
>   phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2) += phy-exynos4210-usb2.o
>   phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2) += phy-exynos4x12-usb2.o
>   phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2) += phy-exynos5250-usb2.o
>  +phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)    += phy-s5pv210-usb2.o
>   obj-$(CONFIG_PHY_EXYNOS5_USBDRD)      += phy-exynos5-usbdrd.o
>   obj-$(CONFIG_PHY_XGENE)                       += phy-xgene.o
>  +obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)  += phy-spear1310-miphy.o
>  +obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)  += phy-spear1340-miphy.o
> + obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)   += phy-qcom-apq8064-sata.o
> + obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)   += phy-qcom-ipq806x-sata.o


We've both been sinners here. New entries should be added in
alphabetical order to avoid these conflicts, and neither of us caught
it.

Resolution looks OK though.


-Olof
