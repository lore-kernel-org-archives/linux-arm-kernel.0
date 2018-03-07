From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 7 Mar 2018 18:24:09 +0000
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <20180302165415.GB8704@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
Message-ID: <CAKv+Gu-HdLkjYeNBQOW=JuWt3GjdZJFjyXCHCbGU01hkO81BNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 March 2018 at 16:54, Greg KH <greg@kroah.com> wrote:
> On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
>>
>>
>> On 03/01/2018 11:24 PM, Greg KH wrote:
>> > On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
>> >> Hi All,
>> >>
>> >> This backport patchset fixed the meltdown issue, it's original branch:
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>> >> A few dependency or fixingpatches are also picked up, if they are necessary
>> >>  and no functional changes.
>> >>
>> >> The patchset also on repository:
>> >>    git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2
>> >>
>> >> No bug found yet from kernelci.org and lkft testing.
>> >
>> > No bugs is good, but does it actually fix the meltdown problem?  What
>> > did you test it on?
>>
>> Oh, I have no A73/A75 cpu, so I can not reproduce meltdown bug.
>
> Then why should I trust this backport at all?
>
> Please test on the hardware that is affected, otherwise you do not know
> if your patches do anything or not.
>

I don't think it is feasible to test these backports by confirming
that they make the fundamental issue go away. We simply don't have the
code to reproduce all the variants, and we have to rely on the
information provided by ARM Ltd. regarding which cores are affected
and which aren't.

What we can do (and what I did for the v4.14 backport) is ensure that
the mitigations take effect when they are expected to, i.e., confirm
that the trampoline vector table and page tables are being used (which
can be done using the exploit code for variant 3a btw), and to check
that the branch predictor maintenance code is called as expected. For
variant 1, we just have to have faith ...

Note that I haven't done so for *this* backport, and I currently don't
have any time to spend on this.
