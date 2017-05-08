From: thgarnie@google.com (Thomas Garnier)
Date: Mon, 8 May 2017 12:51:34 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAGXu5jL61K0bRSEg9a_LswNyrt3K1J57REbWVcvAXT54zWwtMA@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508075209.7aluvpwildw325rf@gmail.com>
 <1494256932.1167.1.camel@gmail.com>
 <CAGXu5jL61K0bRSEg9a_LswNyrt3K1J57REbWVcvAXT54zWwtMA@mail.gmail.com>
Message-ID: <CAJcbSZGhE0ecpqS4jmezqwGXf_o4cakTVkE+m67kJJvhao1ENA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 8:26 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, May 8, 2017 at 8:22 AM, Daniel Micay <danielmicay@gmail.com> wrote:
>> On Mon, 2017-05-08 at 09:52 +0200, Ingo Molnar wrote:
>>>
>>> ... it's just not usable in that form for a regular maintenance flow.
>>>
>>> So what would be more useful is to add a specific Sparse check that
>>> only checks
>>> KERNEL_DS, to add it as a regular (.config driven) build option and
>>> make sure the
>>> kernel build has zero warnings.
>>>
>>> From that point on we can declare that this kind of bug won't occur
>>> anymore, if
>>> the Sparse implementation of the check is correct.
>>>
>>> But there's a (big) problem with that development model: Sparse is not
>>> part of the
>>> kernel tree and adding a feature to it while making the kernel depend
>>> on that
>>> brand new feature is a logistical nightmare. The overhead is quite
>>> similar to
>>> adding new features to a compiler - it happens at a glacial pace and
>>> is only done
>>> for major features really, at considerable expense. I don't think this
>>> is an
>>> adequate model for 'extended syntax checking' of the kernel,
>>> especially when it
>>> comes to correctness that has such obvious security impact.
>>>
>>> Thanks,
>>>
>>>       Ingo
>>
>> There's the option of using GCC plugins now that the infrastructure was
>> upstreamed from grsecurity. It can be used as part of the regular build
>> process and as long as the analysis is pretty simple it shouldn't hurt
>> compile time much.
>
> Well, and that the situation may arise due to memory corruption, not
> from poorly-matched set_fs() calls, which static analysis won't help
> solve. We need to catch this bad kernel state because it is a very bad
> state to run in.

Of course, I agree with Kees points on this and previous emails.

A static analysis solution is hard to scale across functions and build
time can suffer. I don't think the coverage will be good enough to
consider this change and static analysis as similar.

>
> -Kees
>
> --
> Kees Cook
> Pixel Security



-- 
Thomas
