From: xuwei5@hisilicon.com (xuwei)
Date: Thu, 31 Jul 2014 14:22:44 +0800
Subject: [GIT PULL v2][for 3.17] pull request for hisilicon terminal soc
In-Reply-To: <CAOesGMj-m+XgDSGPS329EXHW8kMV6FdgVaCmeDgVL=Xn5vfOkA@mail.gmail.com>
References: <53D750CA.5090405@hisilicon.com>	<CAOesGMhEBsb_6vghQCHTm32FngZvURb2OozLpQu=UmJEY-MAKQ@mail.gmail.com>	<53D9DD53.4050909@hisilicon.com>	<CAOesGMgJjrQQFyszd-c_47d6REGXZKrXBuVU+KiJc8j9vY-B_Q@mail.gmail.com>
 <CAOesGMj-m+XgDSGPS329EXHW8kMV6FdgVaCmeDgVL=Xn5vfOkA@mail.gmail.com>
Message-ID: <53D9E0B4.1000202@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/7/31 14:16, Olof Johansson wrote:
> On Wed, Jul 30, 2014 at 11:14 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Wed, Jul 30, 2014 at 11:08 PM, xuwei <xuwei5@hisilicon.com> wrote:
>>>
>>>
>>> On 2014/7/31 13:32, Olof Johansson wrote:
>>>> Hi,
>>>>
>>>> There were a few things that still needed fixing here -- I took care
>>>> of most of them. See below.
>>>>
>>>>
>>>> On Tue, Jul 29, 2014 at 12:44 AM, xuwei <xuwei5@hisilicon.com> wrote:
>>>>> Hi Olof, Hi Kevin, Hi Arnd,
>>>>>
>>>>> Please help to merge pull request for hisilicon terminal soc.
>>>>>
>>>>> Best Regards,
>>>>> Wei
>>>>>
>>>>>
>>>>> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
>>>>>
>>>>>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>>   git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-for-3.17-v2
>>>>>
>>>>> for you to fetch changes up to eeea1ab9b53f311f634e87d9208daa564a97dbba:
>>>>>
>>>>>   ARM: hisi: remove smp from machine descriptor (2014-07-29 14:54:11 +0800)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> ARM: mach-hisi: Hisilicon teminal soc udaptes for 3.17
>>>>>
>>>>> - Rename Hi3716 to HiX5HD2
>>>>> HiX5HD2 is a SoC with dual Cortex A9 cores for STB market.
>>>>> And original Hi3xxx SoC is for mobile market.
>>>>> To avoid confusing the two types of SoCs and also because of
>>>>> different implementation(SMP, IPs integarted and earlycon configure),
>>>>> rename Hi3716 to HIX5HD2 ann add ARCH_HIX5HD2.
>>>>>
>>>>> - Add HiX5HD2 STB SoC and development kit board support
>>>>> - Change to use power reset driver to reboot for HiX5HD2
>>>>> - Add ARCH_HISI for the common configure of hisilicon SoCs
>>>>> - Change to use CPU_METHOD_OF_DECLARE for SMP on HiX5HD2 and hi3xxx
>>>>> - Enable L2 aux value for Hi3620
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Haifeng Yan (3):
>>>>>       ARM: debug: Rename Hi3716 to HIX5HD2
>>>>>       ARM: hisi: enable hix5hd2 SoC
>>>>>       ARM: dts: Add hix5hd2-dkb dts file.
>>>
>>> Hi Olof,
>>>
>>>> It is confusing -- is the SoC named HIX5HD2 or Hisilicon X5HD2? Seems
>>>> like there are references to both.
>>>
>>> The full name is Hisilicon X5HD2.
>>> But we also call it HIX5HD2.
>>
>> Ok. I think for consistency, it's better to call it X5HD2 everywhere
>> in the kernel where it's already prefixed by Hisilicon, such as
>> compatible strings and help texts on config options.

Hi Olof,

> Hrm, I just noticed that the ethernet driver also uses
> hisilicon,hix5hd2. Based on that, it's probably easier to go back to
> hisi-hix5hd2 everywhere again. I'll rename the dts/dtsi to hisi-hi*
> again. Oh well.

Thanks for your patience and kindness!

Best Regards,
Wei

> 
> -Olof
> 
> .
> 
