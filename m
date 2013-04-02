From: tpiepho@gmail.com (Trent Piepho)
Date: Tue, 2 Apr 2013 05:40:48 -0700
Subject: [PATCH 1/5] spi/mxs: Fix extra CS pulses and read mode in
 multi-transfer messages
In-Reply-To: <201304021232.12736.marex@denx.de>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
 <201304020622.52429.marex@denx.de>
 <CA+7tXigvg+5k0Baa12CVwP5Ar7HUsJ8ihB19xrav4CNA6ZMFiA@mail.gmail.com>
 <201304021232.12736.marex@denx.de>
Message-ID: <CA+7tXii8xhZQeKU2dTN26LxySNXhJT9NgRXcJ21cOX64qYj1NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:32 AM, Marek Vasut <marex@denx.de> wrote:
>>
>> Don't see anything in CodingStyle that one should be preferred over
>> the other.
>
> There ain't any I'm aware of, but to paraphrase you, let's keep the format
> that's already used in the driver ;-) :
>
> 114         if (dev->mode & ~(SPI_CPOL | SPI_CPHA))

Thanks for pointing that out, as that code can be deleted.  Which
means I don't need to be consistent with it anymore and can create a
new standard, to be followed henceforth, now and forever.

But it looks like the or method is more common in the kernel code.  So
I'll change it in V2.

>> > btw. are you using MX23 or MX28 to test this?
>>
>> IMX28.
>
> Is that any mainline board?

Nope, custom hardware.

>> >> Existing code that uses the first/last flags is wrong and needs to be
>> >> changed.  Therefor code using 'first' and 'last' will be changed.
>> >>
>> >> Passing the flags as pointers is bad practice and makes no sense to
>> >> do.  Does it make any sense to re-write code fix the way it uses first
>> >> and last, then re-write those same lines a second time to not use
>> >> pointers?
>> >
>> > You can always flip it the other way -- first rework the use of flags,
>> > then apply the fix. It'd make the patch much easier to understand, don't
>> > you think?
>>
>> So I should change 'first' to not be a pointer to an integer in one
>> patch, then delete the flag entirely in another patch?
>
> I'd say make a patch (0001) that implements the transition to using your newly
> defined flags and then make a patch (0002) that "Fix extra CS pulses and read
> mode in multi-transfer messages". One patch shall do one thing, that's the usual
> rule of the thumb. Obviously keep them in a series if these patches shall go in
> together. And why doesn't squashing them all together work you might ask --
> because reviewing the result is hard.

5 patches have now been split into 12.
