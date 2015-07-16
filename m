From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 16 Jul 2015 07:44:41 +0200
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: Enable max77802 regulator
In-Reply-To: <55A6FEA0.8090202@samsung.com>
References: <1436977965-7078-1-git-send-email-javier@osg.samsung.com>
 <1436977965-7078-2-git-send-email-javier@osg.samsung.com>
 <55A6FEA0.8090202@samsung.com>
Message-ID: <55A744C9.6040703@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

Thanks for the feedback.

On 07/16/2015 02:45 AM, Krzysztof Kozlowski wrote:
> On 16.07.2015 01:32, Javier Martinez Canillas wrote:
>> The Maxim max77802 Power Management IC has besides other devices, a set of
>> regulators. Commit f3caa529c6f5 ("ARM: multi_v7_defconfig: Enable max77802
>> regulator, rtc and clock drivers") was supposed to enable the config option
>> for the regulator driver as a module but the final version that landed did
>> not include this. So this patch enables the needed Kconfig option.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Please describe why do you want to enable it (IOW who will benefit from
> enabling it?). This symbol was removed by Kukjin from your commit:
> 	[kgene at kernel.org: removing useless REGULATOR_MAX77802 config]
> so justification would be welcomed.
>

You are right, sorry for not making the commit message clear. This PMIC
is used by a couple of Exynos5 based boars such as the Peach Pit and Pi
Chromebooks. I expect it to be found in other designs too just like the
max77686 is found in many Exynos5 based boards.

I'll add this to the commit message on v2.
 
> Beside the commit description I agree with the patch.
>

Does this mean I can add your Reviewed-by to this patch as well?

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
