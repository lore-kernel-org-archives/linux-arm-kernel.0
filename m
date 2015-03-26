From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Mar 2015 14:05:09 +0100
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <20150326125334.GA27016@e103592.cambridge.arm.com>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <20150324135439.GC3579@e103592.cambridge.arm.com>
 <CAKv+Gu9NeqOTjUux9S7p5o89T1tc9ACraC0D53Y=CCTNzZXKMg@mail.gmail.com>
 <20150325104603.GA3560@e103592.cambridge.arm.com>
 <20150326113648.GC8656@n2100.arm.linux.org.uk>
 <CAKv+Gu8ktOUcQrGOwMfbt8s2QG+RFdnKBykVfhXPTLSUFtWQyA@mail.gmail.com>
 <20150326122203.GG8656@n2100.arm.linux.org.uk>
 <CAKv+Gu-ctXuiM2mcgbqfkBkP_96tivjac0jv+XJ48XSpqRf=Yg@mail.gmail.com>
 <20150326125334.GA27016@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu9CDnFSiRrntzTDZDFhb3Cq1M-Dt_xKxvNUszZJpSrzpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2015 at 13:53, Dave P Martin <Dave.Martin@arm.com> wrote:
> On Thu, Mar 26, 2015 at 12:24:01PM +0000, Ard Biesheuvel wrote:
>> On 26 March 2015 at 13:22, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Mar 26, 2015 at 01:20:16PM +0100, Ard Biesheuvel wrote:
>
> [...]
>
>> >> Any specific concerns? The --pic-veneer switch dates back to 2009, so
>> >> it's been around for a while
>> >
>> > BX.  Not every CPU supports BX.
>> >
>>
>> The bx is used for the Thumb -> ARM switch inside the veneer only, so
>> if you build for ARM these won't appear in the output
>
> Agreed that's what's _supposed_ to happen.
>
> Note that --use-blx is an override and might introduce BXs into a kernel
> that otherwise doesn't have them.  But in any case, this option doesn't
> show a benefit for the scenario under discussion, hence my dropping the
> request (conditional on THUMB2_KERNEL in any case).
>

Actually, i am not quite sure. I hadn't realised that there is no
branch-without-link counterpart of 'blx <label>' so even if I still
potted a number of bx pc/nop sequences, I can't really say if there
were quite as many as before.

> Ard, can you should build a couple of !THUMB2_KERNEL/pre-v5
> configurations with your change and check, just to be sure?
>

Will do.
