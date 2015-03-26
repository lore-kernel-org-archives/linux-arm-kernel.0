From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Mar 2015 13:24:01 +0100
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <20150326122203.GG8656@n2100.arm.linux.org.uk>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <20150324135439.GC3579@e103592.cambridge.arm.com>
 <CAKv+Gu9NeqOTjUux9S7p5o89T1tc9ACraC0D53Y=CCTNzZXKMg@mail.gmail.com>
 <20150325104603.GA3560@e103592.cambridge.arm.com>
 <20150326113648.GC8656@n2100.arm.linux.org.uk>
 <CAKv+Gu8ktOUcQrGOwMfbt8s2QG+RFdnKBykVfhXPTLSUFtWQyA@mail.gmail.com>
 <20150326122203.GG8656@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-ctXuiM2mcgbqfkBkP_96tivjac0jv+XJ48XSpqRf=Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2015 at 13:22, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Mar 26, 2015 at 01:20:16PM +0100, Ard Biesheuvel wrote:
>> On 26 March 2015 at 12:36, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Wed, Mar 25, 2015 at 10:46:14AM +0000, Dave Martin wrote:
>> >> Hmmm, you seem to be right.
>> >>
>> >> Thumb has no bx <label> instruction, and veneers introduced by ld are
>> >> always ARM code, so this looks tricky to avoid without patching ld.
>> >>
>> >> As you observe, this only impacts large kernels anyway.
>> >>
>> >> So,
>> >>
>> >> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>> >
>> > Someone needs to check what the result is like for older CPUs too.
>> >
>>
>> Any specific concerns? The --pic-veneer switch dates back to 2009, so
>> it's been around for a while
>
> BX.  Not every CPU supports BX.
>

The bx is used for the Thumb -> ARM switch inside the veneer only, so
if you build for ARM these won't appear in the output
