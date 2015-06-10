From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 10 Jun 2015 23:54:38 +0530
Subject: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
In-Reply-To: <CAPDyKFqA5BGXUV+_r63Xwtpm6Bzi2HB=UN0pDcu6FkjtHOaqew@mail.gmail.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
 <1432197817-22110-3-git-send-email-stripathi@apm.com>
 <CAPDyKFpxkNF9C8AOJ6+18CEcpZTKycPR0i5OuwPRr1Zc+VPJ5Q@mail.gmail.com>
 <CAOHikRASDmy7PwFjqmX7JAjW52DYR+d3RkE3yd_45NN5sHK7Pg@mail.gmail.com>
 <CAOHikRBB9Uyh4Z34_pFTdmA0A-vnV09zTi8iYEU+01XvmzSr_A@mail.gmail.com>
 <20150605145323.GA15110@shlinux1.ap.freescale.net>
 <CAOHikRCXuJryKgo7pjehi-SyosE1Rr2zFjc+9yWJwke_ib=Azw@mail.gmail.com>
 <CAPDyKFqk1_B-wH0Z2QwfxftJy8LLH6Ey9cg56eFxAj7zmeFmOg@mail.gmail.com>
 <CAPDyKFqA5BGXUV+_r63Xwtpm6Bzi2HB=UN0pDcu6FkjtHOaqew@mail.gmail.com>
Message-ID: <CAOHikRBGAF4LP8ZnkztUdKgRub8dt+x6xd6dhdJS-ZP9XJqTmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf, Dong

On Mon, Jun 8, 2015 at 2:08 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 8 June 2015 at 10:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> [...]
>>
>>>> >
>>>> >    Can you test this patch  on imx SoC ?
>>>> >
>>>>
>>>> (Your email have some format issue.)
>>>
>>> Yeah missed to sent in plain text mode.
>>>
>>>>
>>>> I have tested this patch and it does not break imx SoC.
>>>> You can add my tag.
>>>> Tested-by: Dong Aisheng <aisheng.dong@freescale.com>
>>>
>>> Thanks Dong !!
>>>
>>>>
>>>> However, it looks to me SDHCI_CAN_VDD_180 is only indicating the host VDD
>>>> capabiliies, not IO voltage capability.
>>
>> I think Dong is correct. I don't think SDHCI_CAN_VDD_180 is not
>
> /s /is not /is
>
>> related to UHS modes at all.
>>
>> At least the name of the field (SDHCI_CAN_VDD_180) indicates it's
>> about VDD/VCC, the core power and not the IO voltage.
>>
>>> Are you sure on this ?? If SDHCI host VDD is  1.8V then the cards are
>>> also capable to operate at 1.8V ? Didn't understand what you mean by
>>> IO voltage capability
>>>
>>>
>>>> SD3.0 cards require 1.8v IO voltage support.
>>>> So should this bit affect SD3.0 support?
>>>
>>> The preset value resgister says that  SDR modes requires 1.8V and we
>>> disable the modes based on capability or quirk.
>>
>> It requires 1.8V *IO voltage*, not VDD/VCC.

I agree on this now  . I will post a version where this quirk will be
added for arasan 4.9a that doesn't support 1.8v voltage signalling.

>>
>> [...]
>>
>> Kind regards
>> Uffe



-- 
Thanks,
with regards,
Suman Tripathi
