From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Feb 2018 15:49:36 +0000
Subject: [GIT PULL] arm64 spectre and meltdown mitigations for v4.14-stable
In-Reply-To: <20180214154033.GA2745@kroah.com>
References: <20180212113801.2552-1-ard.biesheuvel@linaro.org>
 <20180214135420.GB24189@kroah.com>
 <CAKv+Gu_uqudgFU1_+cWZtvyQmZMxjCYuUr-2L59yEfoY8EyWQA@mail.gmail.com>
 <CAKv+Gu-D6E02FE+zaqbksM_w-S_y8ueNGc=xPDAieJHjKp1=bg@mail.gmail.com>
 <20180214154033.GA2745@kroah.com>
Message-ID: <CAKv+Gu8hfhoSC9Zs75E6_NWxQZXC5pgVp3c7JT9qFxaRPAZSMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2018 at 15:40, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Feb 14, 2018 at 02:34:01PM +0000, Ard Biesheuvel wrote:
>> On 14 February 2018 at 14:24, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 14 February 2018 at 13:54, Greg KH <gregkh@linuxfoundation.org> wrote:
>> >> On Mon, Feb 12, 2018 at 11:38:01AM +0000, Ard Biesheuvel wrote:
>> >>> Hi Greg,
>> >>>
>> >>> As mentioned by Will, I have created the v4.14 counterpart of his stable
>> >>> backport of the arm64/ARM Spectre/Meltdown mitigations that have been pulled
>> >>> into v4.16-rc1.
>> >>>
>> >>> Given that this is the v4.15 version backported to v4.14, I have removed any
>> >>> mention of 'conflicts' from the commit logs as they are now ambiguous. The
>> >>> patches applied surprisingly cleanly, I only needed to drop two patches that
>> >>> are already in (the same ones Will mentioned in his PR), and drop another one
>> >>> dealing with SPE, support for which did not exist yet in v4.14. I also included
>> >>> the patch
>> >>>
>> >>>   arm64: move TASK_* definitions to <asm/processor.h>
>> >>>
>> >>> from v4.15 to make Robin's Spectre v1 patches apply more cleanly.
>> >>
>> >> I've queued these up now, but if you could pull the whole quilt tree and
>> >> verify I got things right, that would be great.  There was some
>> >> conflicts with a few previous patches I had already queued up that
>> >> touched some "Falkor" errata code.
>> >>
>> >> Specifically 932b50c7c1c65e6f23002e075b97ee083c4a9e71 "arm64: Add
>> >> software workaround for Falkor erratum 1041" is the offending patch.  I
>> >> think I resolved the merge issues properly, but verifying this would be
>> >> wonderful.
>> >>
>> >
>> > No, the build is broken now. I will investigate.
>>
>> Your patch 977c3d2cb684e143a18e1564fbf5ecf7576a1c98
>>
>> arm64: Move post_ttbr_update_workaround to C code
>>
>> removes the pre_disable_mmu_workaround macro from asm/assembler.h but
>> it should only remove post_ttbr_update_workaround
>>
>> Once I add that back, things seem to build and run as expected.
>
> Can you provide a "fixed" version of just this patch so I know to get it
> correct?
>

Sure. I will send it in a separate email, or Gmail will clobber the patch.
