From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 12:12:07 +0200
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l,
 ldr_l and str_l macros
In-Reply-To: <20160804093851.GD7147@e103592.cambridge.arm.com>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803180934.GK1041@n2100.armlinux.org.uk>
 <CAKv+Gu9Wyiu38J=K00WKXSeFoDF2vS-3TJAvbz9Yo616GBXSwQ@mail.gmail.com>
 <20160804093851.GD7147@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu8_5-VcBxnjLrJxgKcJfVFb785qvVzbB6kryqhhkCfQbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 August 2016 at 11:38, Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, Aug 04, 2016 at 09:40:50AM +0200, Ard Biesheuvel wrote:
>> On 3 August 2016 at 20:09, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> > On Wed, Aug 03, 2016 at 05:38:43PM +0200, Ard Biesheuvel wrote:
>> >> +     add     \dst, pc, #:pc_g0_nc:(\sym) - 8
>> >> +     add     \dst, \dst, #:pc_g1_nc:(\sym) - 4
>> >> +     add     \dst, \dst, #:pc_g2:(\sym)
>> >
>> > What's this :pc_g0_nc: stuff?  What binutils versions is it supported
>> > in?  It doesn't appear documented in gas 2.23.91, so I don't think we
>> > can use it.
>> >
>>
>> binutils 2.18 and up
>
> I think this was contemporary with GCC 4.<some middling version>, which
> may be newer than the minimimum compiler we require for the kernel,
> particular for earlier arch versions.
>
> Using .reloc probably allows the same thing to be done in a more
> backwards-compatible way.
>

I don't see how LD would know how to handle these relocations if we do
manage to emit them from GAS in this way.
