From: butao@huawei.com (Bu Tao)
Date: Fri, 23 Jun 2017 09:09:54 +0800
Subject: [PATCH v2 2/5] dt-bindings: scsi: ufs: add document for hi3660-ufs
In-Reply-To: <5c4c0a7b844055b32b8463fcee04401e@codeaurora.org>
References: <20170616065119.10704-1-butao@hisilicon.com>
 <20170616065119.10704-3-butao@hisilicon.com>
 <CAK8P3a2aPorzpUzwL=dkUkYNCGkhQMDPOkKRW1-=Hf=yCdvTsQ@mail.gmail.com>
 <0f79aeea-53e3-6bea-ffa6-0e057f2ff83b@huawei.com>
 <CAK8P3a2z7VbPb95Ltj=Duh1v_Yqxedb_g=ADNPWOrpEz1dCTuw@mail.gmail.com>
 <5c4c0a7b844055b32b8463fcee04401e@codeaurora.org>
Message-ID: <f1dad4f6-e424-7a38-8148-2669074efa35@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017/6/23 9:05, Subhash Jadavani ??:
> On 2017-06-22 04:51, Arnd Bergmann wrote:
>> On Thu, Jun 22, 2017 at 1:44 PM, Bu Tao <butao@huawei.com> wrote:
>>> ? 2017/6/17 5:51, Arnd Bergmann ??:
>>>> On Fri, Jun 16, 2017 at 8:51 AM, Bu Tao <butao@hisilicon.com> wrote:
>>>>> +Optional properties for board device:
>>>>> +- ufs-hi3660-use-rate-B                : specifies UFS rate-B
>>>>> +- ufs-hi3660-broken-fastauto   : specifies no fastauto
>>>>> +- ufs-hi3660-use-HS-GEAR3      : specifies UFS HS-GEAR3
>>>>> +- ufs-hi3660-use-HS-GEAR2      : specifies UFS HS-GEAR2
>>>>> +- ufs-hi3660-use-HS-GEAR1      : specifies UFS HS-GEAR1
>>>>> +- ufs-hi3660-broken-clk-gate-bypass    : specifies no clk-gate
>>>>> +- ufs-hi3660-use-one-line      : specifies UFS use one line work
>>>>> +- reset-gpio                   : specifies to reset devices
>>>>
>>>>
>>>> Some of these sound rather generic and might apply to UFS
>>>> implementations
>>>> other than hi3660, so I'd suggest adding them to the base ufs
>>>> binding with
>>>> a generic name instead.
>>>>
>>>> Any DT properties that might be useful across multiple implementations
>>>> should be parsed in generic code that gets called by the individual
>>>> drivers,
>>>> and then the properties that are specific to the integration work
>>>> done by
>>>> hisilicon should be prefixed with "hisilicon,", but not normally
>>>> with the
>>>> SoC name: it is quite possible that another SoC will be derived from
>>>> this
>>>> chip and it should reuse the properties.
>>>
>>>
>>> I do not know wheher other SoC need to use the optional properties as
>>> abover. So here the name of the optional properties has "hi3660".
>>
>> They should not have "hi3660" in their names either way, independent
>> of where they are used.
>
>
> Yes, i agree with Arnd that SoCs might also need these so please make
> these properties generic (put them under
> Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt) and also move
> their parsing code in generic driver (ufshcd.c or ufshcd-pltfrm.c).
>
Thanks for your comments. I will modify this and update soon.
>>
>>>> (note: this is different from the value of the "compatible" property
>>>> that
>>>> is meant to be as specific as possible".
>>>>
>>>> Also, please clarify how your binding relates to the ufshcd binding
>>>> in Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt: does
>>>> hi3660 implement any registers that are shared with ufshcd, or does
>>>> it use the same physical interface with a different register set?
>>>
>>> No, only show how to use the dt-binding for hi3660 SoC
>>
>> My question was about the hardware: does hi3660 implement ufshcd
>> or not?
>>
>>       Arnd
>
