From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 6 Jun 2018 09:03:55 -0700
Subject: [PATCH] ARM: dts: cygnus: Add HWRNG node
In-Reply-To: <20180606093441.16483-1-peron.clem@gmail.com>
References: <20180606093441.16483-1-peron.clem@gmail.com>
Message-ID: <c8836130-1d96-b813-4e87-5011db679ba8@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Clement,


On 18-06-06 02:34 AM, Cl?ment P?ron wrote:
> From: Cl?ment Peron <clement.peron@devialet.com>
>
> There is a HWRNG in Broadcom Cygnus SoC, so enable it.
>
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
Thanks for upstreaming some missing Cygnus components.

But, the problem is the tarball release from Broadcom you are extracting 
these changes from does not contain git history; so, you are missing the 
original authors and signed-off's.
I checked our internal git repository and for this commit the author is:
Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>

Please adjust author and signed-off appropriately.? If there are other 
changes you are extracting from the source tarballs you have please 
contact me so we can construct patch appropriately.

Regards,
Scott
> ---
>   arch/arm/boot/dts/bcm-cygnus.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 1cee40ac4613..b7178e84d56d 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -452,6 +452,11 @@
>   			status = "disabled";
>   		};
>   
> +		hwrng: hwrng at 18032000 {
> +			compatible = "brcm,iproc-rng200";
> +			reg = <0x18032000 0x28>;
> +		};
> +
>   		sdhci0: sdhci at 18041000 {
>   			compatible = "brcm,sdhci-iproc-cygnus";
>   			reg = <0x18041000 0x100>;
