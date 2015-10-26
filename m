From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 26 Oct 2015 17:00:54 +0800
Subject: [PATCH v6 3/4] arm64/arm, numa, dt: adding numa dt binding
 implementation for arm64 platforms
In-Reply-To: <CAFpQJXXN-xixG2k7JJuJeCbLkGmR4RKX3heEeaOCpWBVNL4Mog@mail.gmail.com>
References: <1445337931-11344-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1445337931-11344-4-git-send-email-gkulkarni@caviumnetworks.com>
 <CACVXFVMiZs_g3qw99-PhxLiX5oLe8_z5cOAfJZ_4-09jN2koCQ@mail.gmail.com>
 <CAFpQJXX8VXX+gTBn-+7MepSAOzbOuc-yWJe4f=B7MH_Nj7FsKw@mail.gmail.com>
 <CACVXFVPoZqjFeqK7=M7wK0JQ0iS9tYoN8BHsYMc25OL-4j=e1g@mail.gmail.com>
 <CACVXFVO5QGu9z1C49Wos_A5MpPafABL+WDidiHp3S2v1xUsRZw@mail.gmail.com>
 <CAFpQJXXN-xixG2k7JJuJeCbLkGmR4RKX3heEeaOCpWBVNL4Mog@mail.gmail.com>
Message-ID: <CACVXFVO=WuC01-B6Dxdi6CxT=B0kDJXG4VFsYxyEarfQwPaVqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 4:24 PM, Ganapatrao Kulkarni
<gpkulkarni@gmail.com> wrote:
> On Mon, Oct 26, 2015 at 12:50 PM, Ming Lei <ming.lei@canonical.com> wrote:
>> On Mon, Oct 26, 2015 at 12:53 PM, Ming Lei <ming.lei@canonical.com> wrote:
>>> On Mon, Oct 26, 2015 at 11:50 AM, Ganapatrao Kulkarni
>>> <gpkulkarni@gmail.com> wrote:
>>>> On Mon, Oct 26, 2015 at 7:14 AM, Ming Lei <ming.lei@canonical.com> wrote:
>>>>> On Tue, Oct 20, 2015 at 6:45 PM, Ganapatrao Kulkarni
>>>>> <gkulkarni@caviumnetworks.com> wrote:
>>>>>> Adding numa dt binding support for arm64 based platforms.
>>>>>> dt node parsing for numa topology is done using device property
>>>>>> proximity and device node distance-map.
>>>>>>
>>>>>> Reviewed-by: Robert Richter <rrichter@cavium.com>
>>>>>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>>>>> ---
>>>>>>  arch/arm64/Kconfig            |  10 ++
>>>>>>  arch/arm64/include/asm/numa.h |  10 ++
>>>>>>  arch/arm64/kernel/Makefile    |   1 +
>>>>>>  arch/arm64/kernel/of_numa.c   | 221 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>  arch/arm64/kernel/smp.c       |   1 +
>>>>>>  arch/arm64/mm/numa.c          |  10 +-
>>>>>>  6 files changed, 252 insertions(+), 1 deletion(-)
>>>>>>  create mode 100644 arch/arm64/kernel/of_numa.c
>>>>>>
>>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>>> index 0f9cdc7..6cf8d20 100644
>>>>>> --- a/arch/arm64/Kconfig
>>>>>> +++ b/arch/arm64/Kconfig
>>>>>> @@ -426,6 +426,16 @@ config NUMA
>>>>>>           local memory controller of the CPU and add some more
>>>>>>           NUMA awareness to the kernel.
>>>>>>
>>>>>> +config OF_NUMA
>>>>>> +       bool "Device Tree NUMA support"
>>>>>> +       depends on NUMA
>>>>>> +       depends on OF
>>>>>> +       default y
>>>>>> +       help
>>>>>> +         Enable Device Tree NUMA support.
>>>>>> +         This enables the numa mapping of cpu, memory, io and
>>>>>> +         inter node distances using dt bindings.
>>>>>
>>>>> Enabling the above config option can cause numa_init() warning in
>>>>> numa-less arm64 system, please see the following report:
>>>> this is taken care. which version are you using?
>>>
>>> V5.
>>
>> The issue persists on V6 too, so looks V7 is needed.
> can you please share the boot log with v6.
> you can send to me only.

http://kernel.ubuntu.com/~ming/bugs/1509221/4.3-rc7-numa.dmesg

>>
>>>
>>>>
>>>>>
>>>>>           https://bugs.launchpad.net/bugs/1509221
>>>>>
>>>>> Thanks,
>>>>
>>>> Thanks
>>>> Ganapat
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
