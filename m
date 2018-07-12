From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 12 Jul 2018 22:48:37 +0100
Subject: [GIT PULL] arm64: hisilicon fixes for 4.18
In-Reply-To: <CAGoBSJoh0SKMBm=Hgh9rX8G+VcN93C3PxYiA56232OW76AWk-w@mail.gmail.com>
References: <5B354942.1060306@hisilicon.com>
 <20180629210808.qeftfbyf2rcrocda@localhost> <5B39C0CC.1070503@hisilicon.com>
 <CAGoBSJoh0SKMBm=Hgh9rX8G+VcN93C3PxYiA56232OW76AWk-w@mail.gmail.com>
Message-ID: <5B47CCB5.9000009@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On 2018/7/12 15:39, Ryan Grachek wrote:
> Hi All,
> 
> On Mon, Jul 2, 2018 at 1:06 AM, Wei Xu <xuwei5@hisilicon.com> wrote:
>> Hi Olof,
>>
>> On 2018/6/30 5:08, Olof Johansson wrote:
>>>
>>> On Thu, Jun 28, 2018 at 09:46:58PM +0100, Wei Xu wrote:
>>>>
>>>> Hi Olof, Hi Arnd,
>>>>
>>>> Please help to pull the following fix.
>>>> Thanks!
>>>>
>>>> Best Regards,
>>>> Wei
>>>>
>>>> ---
>>>>
>>>> The following changes since commit
>>>> ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>>>
>>>>    Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>    git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-4.18
>>>>
>>>> for you to fetch changes up to a30449eb3ac908f26b4bc963a58039a5f2725ffa:
>>>>
>>>>    arm64: dts: hikey960: Define wl1837 power capabilities (2018-06-28
>>>> 17:07:44 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> ARM64: hisi fixes for 4.18
>>>>
>>>> - Added power capabilities for the mmc host controller on the
>>>>    hikey and hikey960 boards to avoid broken wifi.
>>>
>>> Thanks, merged. However, this seems to keep wifi power on during suspend?
>>> That
>>> seems suboptimal for suspend power consumption. Any work going on to fix
>>> root
>>> cause?
>>
>>
>> Thanks!
>> I will sync with my colleagues about that issue and hope we can get a fix
>> soon.
>>
>> Best Regards,
>> Wei
>>
>>>
>>> -Olof
>>>
>>> .
>>>
>>
>>
> 
> According to Eyal Reizer from TI, "keep-power-in-suspend" is needed in
> case of planning to use "WoWLAN".
> In hindsight, I see this property was already enabled in the SoC file
> (hi3660.dtsi), so that issue had
> already existed prior to my patch. Should I submit patch to remove the
> property from both the SoC
> and board file?

Thanks! Please :)
I think we can remove it firstly and if the real user want to use the WoWLAN,
they can add it in their dts file.

Best Regards,
Wei

> 
> -Ryan
> 
> .
> 
