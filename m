From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 4 Nov 2017 14:57:03 +0000
Subject: [PATCH 3/5] dt-bindings: arm: Document Socionext MB86S71 and
 Fujitsu F-Cue
In-Reply-To: <a39e3d09-4182-ee54-c855-3817498b306a@suse.de>
References: <20170625170020.11791-1-afaerber@suse.de>
 <20170625170020.11791-4-afaerber@suse.de>
 <20170628164605.2gnvrv4g7jluzyrm@rob-hp-laptop>
 <CAK7LNATqjOMUajUCYVq=L6wWVTUEc1M7Po+KQ3M3Z=A7+FHX5w@mail.gmail.com>
 <51221840-b08e-45f1-5601-937fb15f3947@suse.de>
 <CAK7LNASYvdWq5rV6q5Xf4Zqjso3H+XQY9Z6byJgcgfN7wT6fog@mail.gmail.com>
 <a39e3d09-4182-ee54-c855-3817498b306a@suse.de>
Message-ID: <CAKv+Gu8fkOhQCx-BsyTkottkk63dohzSqa8RhAgTDcMVcmFbxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 November 2017 at 13:44, Andreas F?rber <afaerber@suse.de> wrote:
> Hi everyone,
>
> The non-building clk driver has been removed for 4.14, but this patchset
> seems stuck on matters of naming and maintenance...
>
> Am 30.06.2017 um 01:18 schrieb Masahiro Yamada:
>> Hi Andreas,
>>
>> 2017-06-29 21:53 GMT+09:00 Andreas F?rber <afaerber@suse.de>:
>>> Hi Masahiro-san,
>>>
>>> Am 29.06.2017 um 14:18 schrieb Masahiro Yamada:
>>>> 2017-06-29 1:46 GMT+09:00 Rob Herring <robh@kernel.org>:
>>>>> On Sun, Jun 25, 2017 at 07:00:18PM +0200, Andreas F?rber wrote:
>>>>>> For consistency with existing SoC bindings, use "fujitsu,mb86s71" but
>>>>>> socionext.txt.
>>>>>>
>>>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/arm/socionext.txt | 17 +++++++++++++++++
>>>>>>  1 file changed, 17 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/arm/socionext.txt
>>>>>
>>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>>> --
>>>>
>>>> I do not mind this, but
>>>> please note there are multiple product lines in Socionext
>>>> because Socionext merged LSI divisions from Panasonic and Fujitsu.
>>>>
>>>> I maintain documents for Socionext UniPhier SoC family
>>>> (which inherits SoC architecture of Panasonic)
>>>> in Documentation/devicetree/bindings/arm/uniphier/.
>>>
>>> Actually you seemed to be lacking bindings beyond the cache controller
>>> for Uniphier:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/arm/uniphier
>>>
>>> The SoC compatible, e.g. "socionext,uniphier-ld11", needs to be defined
>>> somewhere too, as done here. A git-grep for that particular compatible
>>> only finds derived clk and reset bindings.
>>
>> I can care to send a patch later, but it is off-topic here.
>
> [The relevance was that had there been any bindings precedence from
> UniPhier, it would've influenced my naming choices.]
>
>>> Using socionext.txt allows you to add those bindings to a shared file;
>>> if you prefer to host them separately below uniphier/ or as uniphier.txt
>>
>> I was thinking of this way.
>>
>> For example, TI has omap/, keystone/, davinci.txt, etc.
>> in this directory level.
>>
>>
>>> do you have a better name suggestion for this one? I was trying to keep
>>> our options open to later add SC2A11 in socionext.txt, and I also saw
>>> some mb8ac300 or so (MB86S7x predecessor?) in downstream sources, so I
>>> don't know a good common name for the non-Panasonic parts. And if we
>>> take fujitsu.txt for MB86S7x to match the vendor prefix then we will
>>> need a separate file for the new SC2A11 IIUC.
>>
>> I have no idea.
>> Actually, I am not familiar with those SoCs.
>>
>> I am not sure if there exists a common name for those Fujitsu-derived SoCs.
>> I think a SoC family name will be helpful to avoid proliferating
>> arch/arm/mach-{mb86s7x,mb8ac300, ...}.
>>
>> I see some Socionext guys CC'ed in this mail,
>> somebody might have information about this.
>>
>> As I said before, I do not mind adding socionext.txt
>> and it seems reasonable enough
>> if there is no common name for those SoCs.
>>
>>
>>
>>> Also if you can tell us where the cut between Fujitsu and Socionext
>>> should be done, we can certainly adapt. NXP is still adding all their
>>> new SoCs in fsl.txt, it seems.
>>> (A similar naming issue exists for my not-yet-submitted FM4 patches,
>>> where it changed owners from Fujitsu to Spansion and then to Cypress.)
>>>
>>
>> Right, vendor names are not future-proof in some cases.
>>
>> We use "uniphier" because it is convenient to
>> make a group of SoCs with similar architecture,
>> and it will work even if UniPhier product lines are sold again in the
>> future.  :-)
>
> Summarizing: Masahiro-san only wants to maintain the UniPhier family of
> Socionext SoCs, not this MB86S71. No one from Socionext or Linaro has
> volunteered as maintainer for these F-Cue MB86S71 patches - that seems
> to indicate I'll again have to set up a new repository and start
> maintaining it myself.
>
> Naming it linux-socionext.git wouldn't quite be right due to UniPhier
> also being Socionext.
>
> It's also unclear whether and by whom there may be SC2A11 patches - I
> hear for now Linaro are maintaining a SynQuacer DT in EDK2, rebelling
> against linux.git.
>

Eh, wait, what? "Rebelling against linux.git"? What is that supposed
to mean exactly?


> So... what about naming it linux-fujitsu.git? Then we could keep the
> "fujitsu," vendor prefix and document compatibles in a fujitsu.txt for
> consistency (instead of this v1's socionext.txt), and I could later add
> non-Socionext FM4 (Spansion/Cypress) to the same tree and bindings file.
>
> That still leaves conflict potential with the upcoming Fujitsu Post-K
> chip, but we could still worry about that if it ever results in DT
> bindings patches rather than just ACPI tables.
>
> Objections, suggestions?
>
> Thanks,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
