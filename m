From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 27 May 2014 13:44:31 -0700
Subject: [PATCH v11 0/3] Exynos 5410 support
In-Reply-To: <5384F79C.6000204@gmail.com>
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
 <7hr43f9mmn.fsf@paris.lan> <7hd2ez9kvr.fsf@paris.lan>
 <CANhyOUcGTbbQLxYWsAZG00ENSDa4pj+MP2i7Rx=PfyqN1CY6WQ@mail.gmail.com>
 <5384F79C.6000204@gmail.com>
Message-ID: <CAGa+x86t-4S_Qf1jvBJApyALOQHgFeZQbxAqc+YQ_5102vmWqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 1:37 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 27.05.2014 22:17, Tarek Dakhran wrote:
>> Hi,
>>
>> On Tue, May 27, 2014 at 9:44 PM, Kevin Hilman <khilman@linaro.org> wrote:
>>> Kevin Hilman <khilman@linaro.org> writes:
>>>
>>>> Tarek Dakhran <t.dakhran@samsung.com> writes:
>>>>
>>>>> The series of patches represent support of Exynos 5410 SoC
>>>>>
>>>>> The Exynos 5410 is the first Samsung SoC based on big.LITTLE architecture
>>>>>
>>>>> Patches add new platform description, support of clock controller and device
>>>>> tree for Exynos 5410.
>>>>>
>>>>> Has been build on Samsung Linux Kernel
>>>>>   (branch: for-next, commit: 97eae6c Merge branch 'v3.16-next/multiplatform' into for-next)
>>>>>
>>>>> Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
>>>>>                  2) Exynos 5410 reference board (multi_v7_defconfig)
>>>>>                  3) Odroid-XU board (exynos_defconfig)
>>>>>                  4) Odroid-XU board (multi_v7_defconfig)
>>>>
>>>> Tested-by: Kevin Hilman <khilman@linaro.org>
>>>>
>>>> FYI, I boot tested this on an odroid-xu (exynos_defconfig and
>>>> multi_v7_defconfig.)
>>>
>>> Oops, I may have spoke to soon.  There seem to be some problems with
>>> multi_v7_defconfig.
>>>
>>> Applying this series directly on the commit mentioned above and testing,
>>> it works just fine using multi_v7_defconfig.
>>
>> Thank you for testing.
>>
>>> However, if I directly test the current contents of the samsung for-next
>>> branch (where this series has been merged) it no longer boots on the
>>> odroid-xu.
>>> A quick diff shows that there are some other changes to
>>> multi_v7_defconfig in the samsung/for-next branch that may be causing
>>> problems here.
>>
>> Yes. Right you are. There is no ARCH_EXYNOS defined in multi_v7_defconfig
>> at current state (branch: for-next commit: ca610da Merge branch
>> 'v3.16-next/dt-samsung-3' into for-next).
>> So booting kernel on 5410 SoC is not possible with multi_v7_defconfig.
>> Please use exynos_defconfig.
>
> I wonder if this patch isn't maybe the missing part:
>
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/32414
>
> Olof asked Kukjin to separate it from his pull requests, so it can be
> applied directly to ARM SoC tree to avoid conflicts.

Yup, samsung/for-next + that patch boots fine on the odroid-xu using
multi_v7_defconfig.

Thanks,

Kevin
