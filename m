From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 24 Sep 2018 10:17:02 +0200
Subject: [PATCH V2 3/3] arm64: dts: broadcom: Add reference to Compute
 Module IO Board V3
In-Reply-To: <20180923173940.GE9849@bart.dudau.co.uk>
References: <1535393148-24163-1-git-send-email-stefan.wahren@i2se.com>
 <1535393148-24163-4-git-send-email-stefan.wahren@i2se.com>
 <20180923173940.GE9849@bart.dudau.co.uk>
Message-ID: <b42d2e57-8bcd-0d6a-7a4d-aeefedcdd5f3@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

[add Arnd and Olof]


Am 23.09.2018 um 19:39 schrieb Liviu Dudau:
> On Mon, Aug 27, 2018 at 08:05:48PM +0200, Stefan Wahren wrote:
>> This adds a reference to the dts of the Compute Module IO Board V3 in arm,
>> so we don't need to maintain the content in arm64.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  arch/arm64/boot/dts/broadcom/Makefile                | 3 ++-
>>  arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 ++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
>> index 1193a9e..3d98f5f 100644
>> --- a/arch/arm64/boot/dts/broadcom/Makefile
>> +++ b/arch/arm64/boot/dts/broadcom/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb \
>> -			      bcm2837-rpi-3-b-plus.dtb
>> +			      bcm2837-rpi-3-b-plus.dtb \
>> +			      bcm2837-rpi-cm3-io3.dts
> This should be the .dtb file, not the .dts. At compile time make is not going
> to complain, because it finds the file, but make dtbs_install will fail.
>
> I'm not sure if you want a patch or if you can fix it in your public tree.

oops, please send a patch (with a fixes tag and Arnd & Olof in CC)
because this patch has already been pulled for 4.20.

>
>
> Found out while trying to install the dtbs from linux-next 20180920
>
> Best regards,
> Liviu
>
>>  
>>  subdir-y	+= northstar2
>>  subdir-y	+= stingray
>> diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> new file mode 100644
>> index 0000000..b1c4ab2
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> @@ -0,0 +1,2 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "arm/bcm2837-rpi-cm3-io3.dts"
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
