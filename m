From: mohun106@gmail.com (Radha Mohan)
Date: Wed, 26 Feb 2014 19:57:12 +0530
Subject: [RFC PATCH 1/1] arm64: Add support for 48-bit Physical Address
In-Reply-To: <20140226140821.GD7409@arm.com>
References: <1393394310-6138-1-git-send-email-mohun106@gmail.com>
 <1393394310-6138-2-git-send-email-mohun106@gmail.com>
 <530DF0FE.3050602@codeaurora.org> <20140226140821.GD7409@arm.com>
Message-ID: <CAC8NTUVWiAUJFda95dQdyaS39jykARggoPy0ggmuxUp=0orUsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 7:38 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, Feb 26, 2014 at 01:49:50PM +0000, Christopher Covington wrote:
>> On 02/26/2014 12:58 AM, mohun106 at gmail.com wrote:
>> > From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>> >
>> > Added support for ARMv8 platforms that have 48-bit physical address
>> > implemented. There is no change in the VA bits and levels of
>> > translation.
>>
>> Is there benefit to using build-time constants for this information? Why not
>> look up the physical address range at run time, so that a single kernel binary
>> could run on any system?
>
> I agree, we don't need a Kconfig option for this, just check the
> available (intermediate) physical address bits at boot-time
> (ID_AA64MMFR0_EL1) and program the TCR_ELx registers accordingly.
>

OK, I will redo with the proposed changes.

> (for whatever reason, I got the same patches in private and I replied
> with the same but they haven't been changed before appearing on the
> list)
>
Oops, I did miss that mail.

regards,
Radha

> --
> Catalin
