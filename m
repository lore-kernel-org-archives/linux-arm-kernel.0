From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 30 Jan 2017 16:38:15 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <CAKv+Gu98i4=COqr_Eikwja28U5MAL83rxe-_QBXWFhJ7v1E6yA@mail.gmail.com>
 (Ard Biesheuvel's message of "Mon, 30 Jan 2017 14:50:23 +0000")
References: <1485072424.14066.2.camel@crowfest.net>
 <1485075528.14345.1.camel@crowfest.net>
 <CAKv+Gu8LU3QjrUa6wMJF3WBNrhx34Pi_0ZUQVfrZy7w7y7237w@mail.gmail.com>
 <22169925.OhJ0QcnbHM@localhost> <1485087662.1518.1.camel@crowfest.net>
 <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
 <20170130141308.GV27312@n2100.armlinux.org.uk>
 <CAKv+Gu98i4=COqr_Eikwja28U5MAL83rxe-_QBXWFhJ7v1E6yA@mail.gmail.com>
Message-ID: <yw1xwpdcfqq0.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:

> On 30 January 2017 at 14:13, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Sun, Jan 22, 2017 at 01:01:53PM +0000, Ard Biesheuvel wrote:
>>> Emulating unaligned access in the ARM kernel was a mistake: it even
>>> emulates unaligned accesses for instructions like ldm and ldrd, which
>>> require word alignment at the hardware level even in the latest v8
>>> version of the architecture. In contrast, the v8 deprecation warnings
>>> are about enforcing compliance.
>>
>> Ard, you're totally wrong on the unaligned access thing.  Unaligned
>> accesses are a fundamental requirement of the kernel's networking
>> stack.  If you don't have support for unaligned accesses, then you
>> don't have network support - it's as simple as that.
>>
>> So, in order for ARMv5 and earlier to have network support, there
>> was no option to add support for emulating those accesses.
>>
>
> I wasn't aware of that.

Not even David Miller is "aware" of that.  Then again, we're living in a
world of "alternative facts" now.

-- 
M?ns Rullg?rd
