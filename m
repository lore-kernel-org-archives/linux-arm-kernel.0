From: keescook@chromium.org (Kees Cook)
Date: Mon, 9 Mar 2015 11:06:00 -0700
Subject: [PATCH v3 0/10] split ET_DYN ASLR from mmap ASLR
In-Reply-To: <20150309161912.GW8656@n2100.arm.linux.org.uk>
References: <1425435025-30284-1-git-send-email-keescook@chromium.org>
 <20150309161912.GW8656@n2100.arm.linux.org.uk>
Message-ID: <CAGXu5jK=bEQDao+QZN7AZuVi0FB_+AsT4LAPodVZg3VTK=Pi-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 9, 2015 at 9:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Mar 03, 2015 at 06:10:15PM -0800, Kees Cook wrote:
>> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
>> ASLR from mmap ASLR, as already done on s390. The architectures
>> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
>> and x86), have their various forms of arch_mmap_rnd() made available
>> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
>> arch_randomize_brk() is collapsed as well.
>>
>> This is an alternative to the solutions in:
>> https://lkml.org/lkml/2015/2/23/442
>>
>> I've been able to test x86 and arm, and the buildbot (so far) seems
>> happy with building the rest.
>
> Hmm, do you want to wrap my acks up to your previous one into this set?
> What about my tested-by?
>
> I'd rather not waste time testing this version if my previous test is
> still valid (or if there's yet another version of this patch set which
> is later than this set.)
>
> Unless I hear anything, I'll assume that it's broadly the same as the
> previous patch set and requires no action.

Yeah, it's broadly the same. I tweaked a few minor things, so I'm
comfortable retaining the acks and tested-bys. Thank you for the
reviews and tests!

-Kees

-- 
Kees Cook
Chrome OS Security
