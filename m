From: palmer@dabbelt.com (Palmer Dabbelt)
Date: Tue, 20 Jun 2017 14:14:53 -0700 (PDT)
Subject: [PATCH 03/20] asm-generic: Drop getrlimit and setrlimit syscalls
 from default list
In-Reply-To: <CAK8P3a1rXfrXotJa=mZf3cJu+WVWHKWjTMk8FA16xnkGvU0MmQ@mail.gmail.com>
Message-ID: <mhng-d074cb45-69b3-40d5-bfb3-9de82ba0dab7@palmer-si-x1c4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jun 2017 08:27:36 PDT (-0700), Arnd Bergmann wrote:
> On Tue, Jun 20, 2017 at 4:54 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>> On Tue, Jun 20, 2017 at 04:20:43PM +0200, Arnd Bergmann wrote:
>>> On Tue, Jun 20, 2017 at 3:37 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>>> > On Mon, Jun 19, 2017 at 11:10:23PM +0100, James Hogan wrote:
>>> >> On Mon, Jun 19, 2017 at 11:58:41PM +0200, Arnd Bergmann wrote:
>
>>> > I would also notice riscv people and welcome to the discussion.
>>> >
>>> > As there is more than 1 arch that goes to be added to linux soon,
>>> > maybe it's better to upstream my ans James' patches separately
>>> > from other ilp32 patches? Arnd?
>>>
>>> Do you mean upstream those two patches slightly later? That's
>>> fine with me, I don't care much whether the old new stat is part
>>> of the syscall table for arm64-ilp32 or not, I'd leave that up to
>>> you, depending on whether you want to do the rework or not.
>>
>> I mean that if we want to deprecate rlimit and stat syscalls for
>> architectures that are under development now, it's better to upstream
>> patches that actually deprecate it as early as possible.
>
> Makes sense.
>
>>> I suppose the arm64-ilp32 could benefit from not having to support
>>> the old arm32 stat structure, but doing the new syscalls based on
>>> statx could delay the glibc port some more, as there are some open
>>> questions about how that would best be integrated.
>>
>> OK. Let's leave things as is. But then I don't see any reason to
>> add unxstat patch to ilp32 series if ilp32 will not disable it.
>
> Right, that's what I meant: let's leave the rlimit patch in your series
> as it matches the work you have already done, and is the right
> thing to do, and let's do the unxstat patch separately so it doesn't
> cause you extra work.

Thanks for the heads up.  We're in the process of submitting glibc now with the
goal of getting into 2.26, so I think that means we'll be stuck with stat.  I'm
perfectly happy to deprecate whatever is feasible, though.
