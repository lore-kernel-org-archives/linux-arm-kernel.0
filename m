From: monstr@monstr.eu (Michal Simek)
Date: Mon, 14 Nov 2016 16:10:22 +0100
Subject: [PATCH] ARM: zynq: Reserve correct amount of non-DMA RAM
In-Reply-To: <CA+aJhH2yZqrwR=U2pgWZfxuF63FF75-NVwGHbDU=fFs7cmcg9w@mail.gmail.com>
References: <20161031162617.10565-1-kyle.roeschley@ni.com>
 <CAHTX3d+8kBYQwcUUcL1Z71Geij4EU3pjcv29=r8ndqSLW8iZDw@mail.gmail.com>
 <CA+aJhH11ty3xWQ5-CLCrPA5xH-dr_nVb8JCKZEvgJcm6Ha3xaA@mail.gmail.com>
 <CA+aJhH2yZqrwR=U2pgWZfxuF63FF75-NVwGHbDU=fFs7cmcg9w@mail.gmail.com>
Message-ID: <8db45834-ddda-ea44-567c-71ddac67e1bf@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.11.2016 10:57, Nathan Rossi wrote:
> On 10 November 2016 at 19:33, Nathan Rossi <nathan@nathanrossi.com> wrote:
>> On 10 November 2016 at 18:41, Michal Simek <monstr@monstr.eu> wrote:
>>> + Nathan
>>>
>>> 2016-10-31 17:26 GMT+01:00 Kyle Roeschley <kyle.roeschley@ni.com>:
>>>>
>>>> On Zynq, we haven't been reserving the correct amount of DMA-incapable
>>>> RAM to keep DMA away from it (per the Zynq TRM Section 4.1, it should be
>>>> the first 512k). In older kernels, this was masked by the
>>>> memblock_reserve call in arm_memblock_init(). Now, reserve the correct
>>>> amount excplicitly rather than relying on swapper_pg_dir, which is an
>>>> address and not a size anyway.
>>>>
>>>> Fixes: 46f5b96 ("ARM: zynq: Reserve not DMAable space in front of the
>>>> kernel")
>>>>
>>>> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
>>
>> Tested-by: Nathan Rossi <nathan@nathanrossi.com>
>>
>> For reference this causes problems with DEBUG_RODATA (which changed to
> 
> Sorry typo -> s/causes/caused/, as in "... this [incorrect reserving
> of the lower 512K] caused ...".
> 
> Regards,
> Nathan
> 
>> default yes for CPU_V7 in v4.6) due to padding memory between
>> .head.text and .text, allowing memory below 0x80000 to be available
>> for allocation as non-reserved memory.
Applied to zynq/soc
https://github.com/Xilinx/linux-xlnx/commits/zynq/soc

Thanks,
Michal

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/08ba1daa/attachment.sig>
