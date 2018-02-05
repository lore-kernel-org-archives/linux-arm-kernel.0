From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Feb 2018 20:21:48 +0100
Subject: [PATCH v2 0/9] Fix kpti-enabled kernels for Cavium ThunderX
In-Reply-To: <20180205164153.GF10172@arm.com>
References: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu-VvsjSG7Lno9e+qm5VzA9OJhN4DbqxPw0D1+FEwrFK_A@mail.gmail.com>
 <20180205164153.GF10172@arm.com>
Message-ID: <CAKv+Gu-DKr0hgEMVwdWrTZxNezH8YZXPt8u1LxdWJ_4V1bH-cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 February 2018 at 17:41, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Sat, Feb 03, 2018 at 11:36:04AM +0000, Ard Biesheuvel wrote:
>> On 29 January 2018 at 11:59, Will Deacon <will.deacon@arm.com> wrote:
>> > Hi all,
>> >
>> > This is version two of the patches I posted on Friday:
>> >
>> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/556304.html
>> >
>> > Changes since v1 include:
>> >
>> >   * Use SCTLR_ELx_M instead of open-coded #1
>> >   * Changed section attributes for .idmap.text to reflect actual mappings
>> >   * Rejigged phys_to_pte for consistency with pte_to_phys
>> >   * Added reviewer tags
>> >
>>
>> Any chance we could base this on the arm64/kpti branch rather than
>> for-next/core? Any backports of kpti will need to include this series
>> as well, or we break ThunderX, and I'd rather have you merge it into
>> for-next/core rather than the various backporters (whose level of
>> familiarity with this code is invariably lower than yours) into the
>> stable trees.
>
> I'd prefer to have this based on for-next/core for ease of merging, but I'll
> do a version for the kpti branch too (probably at -rc1). Once mainline has
> settled down, I plan to rebuild kpti with references to upstream commits
> etc.
>

I am already doing that for v4.14. Perhaps it is simplest to merge
that branch into v4.15 as well (unless you need to rebuild the branch
for other reasons as well)
