From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 14:18:32 +0100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
In-Reply-To: <20150113111636.7bc5785c@canb.auug.org.au>
References: <20150113111636.7bc5785c@canb.auug.org.au>
Message-ID: <3097971.rZTsHKr4DO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 January 2015 11:16:36 Stephen Rothwell wrote:
>  -      imx6q-tx6q-1110.dtb \
>  -      imx6sl-evk.dtb \
>  +      imx6q-tx6q-1110.dtb
>  +dtb-$(CONFIG_SOC_IMX6SL) += \
>  +      imx6sl-evk.dtb
>  +dtb-$(CONFIG_SOC_IMX6SX) += \
> +       imx6sx-sabreauto.dtb \
>         imx6sx-sdb.dtb \
>  +dtb-$(CONFIG_SOC_LS1021A) += \
>         ls1021a-qds.dtb \
>  -      ls1021a-twr.dtb \
>  +      ls1021a-twr.dtb
>  +dtb-$(CONFIG_SOC_VF610) += \
> 

There is an extraneous '\' character behind imx6sx-sdb.dtb now, which caused
build errors for me. We should soon be able to merge the other branches into
arm-soc to avoid the entire set of merge conflicts, until then please
change your recorded resolution to avoid the build error.

Thanks!

	Arnd
