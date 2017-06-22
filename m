From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Jun 2017 14:15:54 +0200
Subject: [PATCH v2 2/5] dt-bindings: scsi: ufs: add document for hi3660-ufs
In-Reply-To: <24438c4d-21c8-6302-acd4-4f0e223232ce@huawei.com>
References: <20170616065119.10704-1-butao@hisilicon.com>
 <20170616065119.10704-3-butao@hisilicon.com>
 <CAK8P3a2aPorzpUzwL=dkUkYNCGkhQMDPOkKRW1-=Hf=yCdvTsQ@mail.gmail.com>
 <0f79aeea-53e3-6bea-ffa6-0e057f2ff83b@huawei.com>
 <CAK8P3a2z7VbPb95Ltj=Duh1v_Yqxedb_g=ADNPWOrpEz1dCTuw@mail.gmail.com>
 <24438c4d-21c8-6302-acd4-4f0e223232ce@huawei.com>
Message-ID: <CAK8P3a1MRx5zRp5-7iDY32+6PGsyHFaOom-bkWmftpLUS=8gBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 1:58 PM, Bu Tao <butao@huawei.com> wrote:
> ? 2017/6/22 19:51, Arnd Bergmann ??:
>> On Thu, Jun 22, 2017 at 1:44 PM, Bu Tao <butao@huawei.com> wrote:
>>> ? 2017/6/17 5:51, Arnd Bergmann ??:
>>>> On Fri, Jun 16, 2017 at 8:51 AM, Bu Tao <butao@hisilicon.com> wrote:
>>>
>>> I do not know wheher other SoC need to use the optional properties as
>>> abover. So here the name of the optional properties has "hi3660".
>>
>>
>> They should not have "hi3660" in their names either way, independent
>> of where they are used.
>
>
> Oh, change the "hi3660" to "hisilicon"?
> e.g. ufs-hi3660-use-rate-B  -->  ufs-hisilicon-use-rate-B

No, just 'use-rate-B', no prefix for this.

>>>> (note: this is different from the value of the "compatible" property
>>>> that
>>>> is meant to be as specific as possible".
>>>>
>>>> Also, please clarify how your binding relates to the ufshcd binding
>>>> in Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt: does
>>>> hi3660 implement any registers that are shared with ufshcd, or does
>>>> it use the same physical interface with a different register set?
>>>
>>>
>>> No, only show how to use the dt-binding for hi3660 SoC
>>
>>
>> My question was about the hardware: does hi3660 implement ufshcd
>> or not?
>
>
> YES

Ok, then the properties should be documented as optional in the
Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt file for anything
that has a proper interpretation in the context of the generic ufshcd
driver.

      Arnd
