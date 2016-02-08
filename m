From: dirk.behme@gmail.com (Dirk Behme)
Date: Mon, 8 Feb 2016 18:08:57 +0100
Subject: [PATCH v2] arm64: dts: r8a7795: Add L2 cache-controller nodes
In-Reply-To: <CAMuHMdUTUss=fR0Mdz+7tDD=RC6hufvkLC99Fp=PTiTgaSSGNA@mail.gmail.com>
References: <1452953856-5146-1-git-send-email-dirk.behme@gmail.com>
 <56B2370D.2010102@gmail.com> <20160205095758.GE16556@verge.net.au>
 <CAMuHMdVRhwGh2bvfNSguX0XnMW0eEgLRTCt3Y3-+KfV0Jy9WHw@mail.gmail.com>
 <56B857AC.4090701@de.bosch.com>
 <CAMuHMdUTUss=fR0Mdz+7tDD=RC6hufvkLC99Fp=PTiTgaSSGNA@mail.gmail.com>
Message-ID: <56B8CBA9.8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 08.02.2016 10:01, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Mon, Feb 8, 2016 at 9:54 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> On 08.02.2016 09:42, Geert Uytterhoeven wrote:
>>> On Fri, Feb 5, 2016 at 10:57 AM, Simon Horman <horms@verge.net.au> wrote:
>>>> On Wed, Feb 03, 2016 at 06:21:17PM +0100, Dirk Behme wrote:
>>>>> On 16.01.2016 15:17, Dirk Behme wrote:
>>>>>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>
>>>>>> Add device nodes for the L2 caches, and link the CPU node to its L2
>>>>>> cache node.
>>>>>>
>>>>>> The L2 cache for the Cortex-A57 CPU cores is 2 MiB large (organized as
>>>>>> 128 KiB x 16 ways).
>>>>>>
>>>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>>>>
>>>> [snip]
>>>>
>>>>> Any further comments to this? If not, could this be applied?
>>>>
>>>> Sorry for the delay.
>>>>
>>>> This looks good; I have queued it up.
>>>>
>>>> It should appear in the next (and devel) branches of my renesas tree
>>>> soon.
>>>> And in linux-next whenever it includes my updated next branch.
>>>
>>> So you not only dropped the (controversial) timing related properties, but
>>> in addition:
>>>
>>> +               cache-unified;
>>> +               cache-level = <2>;
>>>
>>> At least the "cache-level" property is marked as required in ePAPR.
>>> For "cache-unified", the wording is not that strict in ePAPR, but that
>>> property
>>> depends on being a unified cache in the first place.
>>>
>>> So I think these two properties should be re-added.
>>
>> If I remember correctly, first, these entries are not used at all on ARMv8.
>> And second, I think it was mentioned that we therefore want to drop them:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394936.html
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/devicetree/bindings/arm/l2c2x0.txt?id=0bed4b7aa02c06e05121875dc443295d55b9d91d
>
> I believe the discussion was only about the latency properties, which are
> documented in the l2c2x0 DT bindings, and deemed to not apply here


Hmm, the two bindings cache-unified and cache-level are documented in 
bindings/arm/l2c2x0.txt, too.


> The DT bindings documented in ePAPR are generic, and apply to all hardware,
> unless extended or overridden by more-specific DT bindings.


I still can't see the benefit of adding entries to the device tree 
which are not used at all (and most probably don't make sense on that 
platform). But if anybody has a different opinion and maybe good 
arguments for it, that would be fine, too :)

Best regards

Dirk
