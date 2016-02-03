From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 3 Feb 2016 09:42:30 +0100
Subject: [RFC PATCH 0/3] arm64 initrd mapping/relocation
In-Reply-To: <56B1222D.3000604@redhat.com>
References: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
 <56B1222D.3000604@redhat.com>
Message-ID: <CAKv+Gu_K69O4c-500mxxYd=2Se+S=+fjXHkqdLdZ0QUtC4Lbbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2016 at 22:39, Mark Langsdorf <mlangsdo@redhat.com> wrote:
> On 02/02/2016 11:56 AM, Ard Biesheuvel wrote:
>>
>> After discussing in linux-efi with Mark, and on #armlinux with Will, this
>> is
>> a proposal for dealing with initrd memory that is potentially not covered
>> by
>> the linear region.
>>
>> Note that this will look slightly differently when some of the KASLR work
>> gets
>> merged, but this should only affect the way we deal with the initrd if it
>> sits
>> outside of the linear region.
>>
>> Mostly intended for discussion, not tested at all.
>>
>> Ard Biesheuvel (3):
>>    memblock: add routine to clear the MEMBLOCK_NOMAP flag for a region
>>    arm64: add the initrd region to the linear mapping explicitly
>>    arm64: remove the now unneeded relocate_initrd()
>
>
> I discovered the original problem on AMD Seattle and these patches
> fixed it for me.
>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>

Thanks Mark.

I will let Will confirm when and how these patches will be merged.

-- 
Ard.
