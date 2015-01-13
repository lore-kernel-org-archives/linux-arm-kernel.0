From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Jan 2015 10:07:09 -0800
Subject: [PATCH V2] ARM: dts: Only build dtb if associated Arch and/or SoC
 is enabled
In-Reply-To: <2841623.hUI7NQFVvE@wuerfel>
References: <1419920427-29121-1-git-send-email-pbrobinson@gmail.com>
 <20150112224203.GL22090@quad.lixom.net>
 <2841623.hUI7NQFVvE@wuerfel>
Message-ID: <CAOesGMhWaqNtN+Jue=rgtC1aHAScNG=YSBe1PCn-r7WArX7Ovw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 4:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 12 January 2015 14:42:03 Olof Johansson wrote:
>>
>> I've applied this on next/dt now, hopefully it won't become too much of
>> a headache of conflicts during this release cycle. At least doing it on that
>> branch should keep us from exposing it up outside our tree.
>>
>
> I had to add this snippet to get my local tree to build again:
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7be7a6f62d81..3308d110bdc7 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -303,7 +303,7 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
>         imx6sl-evk.dtb
>  dtb-$(CONFIG_SOC_IMX6SX) += \
>         imx6sx-sabreauto.dtb \
> -       imx6sx-sdb.dtb \
> +       imx6sx-sdb.dtb
>  dtb-$(CONFIG_SOC_LS1021A) += \
>         ls1021a-qds.dtb \
>         ls1021a-twr.dtb

I found that after merging, and fixed up the commit in arm-soc, but it
seems that Stephen fetched for linux-next before I did the fixup.


-Olof
