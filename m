From: otavio@ossystems.com.br (Otavio Salvador)
Date: Tue, 3 Mar 2015 00:43:02 -0300
Subject: [PATCH] ARM: dts: warp: Add initial WaRP Board support
In-Reply-To: <20150303032937.GI20455@dragon>
References: <1424883739-374-1-git-send-email-otavio@ossystems.com.br>
 <20150303032937.GI20455@dragon>
Message-ID: <CAP9ODKotqeJW6sYg=Z9Xgu4QHa07G+q1ZJddZsZ9EUUMsN6N7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Tue, Mar 3, 2015 at 12:29 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Feb 25, 2015 at 02:02:19PM -0300, Otavio Salvador wrote:
>> The WaRP Board is a Wearable Reference Plaform. The board features:
>>
>>  - Freescale i.MX6 SoloLite processor with 512MB of RAM
>>  - Freescale FXOS8700CQ 6-axis Xtrinsic sensor
>>  - Freescale Kinetis KL16 MCU
>>  - Freescale Xtrinsic MMA955xL intelligent motion sensing platform
>>
>> The board implements a hybrid architecture to address the evolving
>> needs of the wearables market. The platform consists of a main board
>> and an example daughtercard with the ability to add additional
>> daughtercards for different usage models.
>>
>> For more information about the project, visit:
>>
>>  http://www.warpboard.org/
>>
>> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
>
> Pretty neat!  Only one comment about dts license below.
>
>> ---
>>  arch/arm/boot/dts/Makefile        |   3 +-
>>  arch/arm/boot/dts/imx6sl-warp.dts | 154 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 156 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/imx6sl-warp.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index a1c776b..1b49d57 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -299,7 +299,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>       imx6q-wandboard.dtb \
>>       imx6q-wandboard-revb1.dtb
>>  dtb-$(CONFIG_SOC_IMX6SL) += \
>> -     imx6sl-evk.dtb
>> +     imx6sl-evk.dtb \
>> +     imx6sl-warp.dtb
>>  dtb-$(CONFIG_SOC_IMX6SX) += \
>>       imx6sx-sabreauto.dtb \
>>       imx6sx-sdb.dtb
>> diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
>> new file mode 100644
>> index 0000000..dadb92f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6sl-warp.dts
>> @@ -0,0 +1,154 @@
>> +/*
>> + * Copyright 2014, 2015 O.S. Systems Software LTDA.
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>
> It's preferred to use GPL/X11 dual license for new dts files.  See
> arch/arm/boot/dts/imx6q-tbs2910.dts for example.

I sent a v2 changing it. Thanks for the remark :)

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
