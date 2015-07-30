From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Jul 2015 14:06:12 +0200
Subject: [PATCH v5 0/2] arm64: Add basic support for Marvell Berlin4CT SoC
In-Reply-To: <20150730191304.752db88c@xhacker>
References: <1438248922-2919-1-git-send-email-jszhang@marvell.com>
 <55B9F507.8090706@gmail.com> <20150730191304.752db88c@xhacker>
Message-ID: <55BA1334.3010000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2015 01:13 PM, Jisheng Zhang wrote:
> On Thu, 30 Jul 2015 11:57:27 +0200
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>
>> On 07/30/2015 11:35 AM, Jisheng Zhang wrote:
>>> Marvell Berlin4CT is a SoC based on 64bit ARMv8 architecture. It contains
>>> quad CA53 cores.
>>>
>>> This SoC shares many HW IP with BG2Q and other berlin series. This patchset
>>> was tested on Berlin4CT DMP board, and boot to shell ok.
>>>
>>> Since v4:
>>>    - rebased on the latest next tree
>>
>> Jisheng,
>>
>> some git basics, so you get a better idea of the merge process:
>>
>> Please do not base your patches on linux-next. It is not a stable branch
>> I can refer to. Also, if there was any dependency with another feature
>> that your patches require, you should mention that dependency by
>> pointing out either a floating patch set or even better a _stable_
>> topic branch of the feature that will be added in the same cycle you
>> expect your patches to be merged.
>
> Got it. Thanks for the kindly remind. There's only one dependency:
> "arm64: Split out platform options to separate Kconfig" from Olof.

AFAIKS, the patch in question has been applied by Olof for the next
cycle and after 4.2-rc2. You just name the patch, while Olof and I
will have to work it out:

@Olof: Any specific branch you want me to base a potential PR for
the initial Berlin4CT patches on? If you prefer to pick up the
two patches directly, feel free to add my

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

>> AFAIKS, there is no dependency at all so please just base them on -rc1
>
> I'd like to learn more to avoid future inconvenience. This means it's better
> to rebase on 4.2-rc, right?

You can rebase on anything that is considered stable, i.e. my
berlin/foo-for-4.x-n branches become stable as soon as I send out a PR
to arm-soc. Before stable I can reorder/squash/fixup any patches
in there (or anything that will change the commit hash). Once I
declare it stable and anything needs to be changed, I'll have to
apply proper patches or even apply revert patches.

> Another question is: could patches be based on arm-soc tree if necessary?
> for example: if I need the "arm64: Split out platform options to separate
> Kconfig" commit.

Not directly, arm-soc by itself has no stable branches I know of. But
there may be stable topic branches that can be referred to but that
will be worked out on single topics by arm-soc/subsystem maintainers
and patch authors. Likely cross-subsystem patch sets or large patch
sets will end up in topic branches.

Sebastian
