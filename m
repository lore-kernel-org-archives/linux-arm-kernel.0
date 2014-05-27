From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 27 May 2014 10:44:40 -0700
Subject: [PATCH v11 0/3] Exynos 5410 support
In-Reply-To: <7hr43f9mmn.fsf@paris.lan> (Kevin Hilman's message of "Tue, 27
 May 2014 10:06:56 -0700")
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
 <7hr43f9mmn.fsf@paris.lan>
Message-ID: <7hd2ez9kvr.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@linaro.org> writes:

> Tarek Dakhran <t.dakhran@samsung.com> writes:
>
>> The series of patches represent support of Exynos 5410 SoC
>>
>> The Exynos 5410 is the first Samsung SoC based on big.LITTLE architecture
>>
>> Patches add new platform description, support of clock controller and device
>> tree for Exynos 5410.
>>
>> Has been build on Samsung Linux Kernel
>>   (branch: for-next, commit: 97eae6c Merge branch 'v3.16-next/multiplatform' into for-next)
>>
>> Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
>> 		    2) Exynos 5410 reference board (multi_v7_defconfig)
>> 		    3) Odroid-XU board (exynos_defconfig)
>> 		    4) Odroid-XU board (multi_v7_defconfig)
>
> Tested-by: Kevin Hilman <khilman@linaro.org>
>
> FYI, I boot tested this on an odroid-xu (exynos_defconfig and
> multi_v7_defconfig.)

Oops, I may have spoke to soon.  There seem to be some problems with
multi_v7_defconfig.

Applying this series directly on the commit mentioned above and testing,
it works just fine using multi_v7_defconfig.

However, if I directly test the current contents of the samsung for-next
branch (where this series has been merged) it no longer boots on the
odroid-xu.

A quick diff shows that there are some other changes to
multi_v7_defconfig in the samsung/for-next branch that may be causing
problems here.

Kevin
