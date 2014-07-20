From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 20 Jul 2014 12:25:34 +0200
Subject: [PATCH resend v2] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <CAKv+Gu_2CYU+Th4xZ3EfjCFqQzBfJ88Hrtx1LwUbG79+1=cqJw@mail.gmail.com>
References: <1405079210-30044-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140714133644.GE1779@arm.com>
 <CAKv+Gu_2CYU+Th4xZ3EfjCFqQzBfJ88Hrtx1LwUbG79+1=cqJw@mail.gmail.com>
Message-ID: <CAKv+Gu9K=Hp97cFK2D_HTe=CD6-spvUcP6itOyLB-DcgQatmyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2014 15:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 14 July 2014 15:36, Will Deacon <will.deacon@arm.com> wrote:
>> On Fri, Jul 11, 2014 at 12:46:50PM +0100, Ard Biesheuvel wrote:
>>> From: Yi Li <yi.li@linaro.org>
>>>
>>> SMbios is important for server hardware vendors. It implements a spec for
>>> providing descriptive information about the platform. Things like serial
>>> numbers, physical layout of the ports, build configuration data, and the like.
>>>
>>> This has been tested by dmidecode and lshw tools.
>>>
>>> Signed-off-by: Yi Li <yi.li@linaro.org>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>> Changes since previous version:
>>> - changed double inclusion guard to arm64 flavour
>>> - use kzalloc(GFP_KERNEL) as GFP_ATOMIC is not needed
>>> - do a sanity check on the size of the requested mapping
>>
>> Technically, this patch looks fine to me:
>>
>>   Reviewed-by: Will Deacon <will.deacon@arm.com>
>>

Hello Catalin,

This has been tested by Yi on FVP and Juno.
Are you ok to take this?

-- 
Ard.


>
> Thanks.
>
>> It would be good if somebody with a relevant platform could confirm that
>> it works/is useful though.
>>
>
> The usefulness has been debated here a couple of times before:
> Grant's take on it is here
> http://marc.info/?l=linux-arm-kernel&m=140206407411522&w=2
>
> As to whether it works: I have asked Yi to retest this version of the
> patch with lshw and dmidecode
> @Yi: could you please share your findings here?
>
