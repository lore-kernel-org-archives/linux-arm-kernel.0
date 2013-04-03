From: tpiepho@gmail.com (Trent Piepho)
Date: Wed, 3 Apr 2013 02:32:01 -0700
Subject: [PATCH V2 08/12] spi/mxs: Fix race in setup method
In-Reply-To: <201304030850.31752.marex@denx.de>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <201304030427.41297.marex@denx.de>
 <CA+7tXih2r6YFE80y7z7Nj7c0Ytvh+v56-SrbS+VQ7kCW3KBRXA@mail.gmail.com>
 <201304030850.31752.marex@denx.de>
Message-ID: <CA+7tXih95vdd1dDjxx9aMwhody7J5LrfTpERz-412BaVW9TzSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 11:50 PM, Marek Vasut <marex@denx.de> wrote:
> Dear Trent Piepho,
>
>> On Apr 2, 2013 7:27 PM, "Marek Vasut" <marex@denx.de> wrote:
>> > > The only useful thing mxs_spi_setup_transfer() (which
>> > > is no longer called) did in this instance was make that check.
>> > >
>> > > > btw. I was under the impression the MXS SSP block can handle other
>> > > > word-widths than 8 bit, no ?
>> > >
>> > > In theory it can,
>> >
>> > In practice too ;-)
>> >
>> > > however the driver only supports 8-bits and will
>> > > reject anything else.
>> >
>> > Then please at least add a comment about this.
>>
>> What does that have to do with this patch?
>
> You're adding a piece of code. This change is
> a) not documented in the commit message
> b) unrelated to this fix, seems to be more fitting in 10/12 or something --
> maybe even shuffling the patches a bit might help

It's not changing the behavior and it's not new code.  It's existing
code that was in a different function, but that function does other
things which can't be done at this point.  That's in the patch
description.  It is obviously part of the this patch since not calling
mxs_spi_setup_transfer() would include continuing to have the same
behavior w.r.t. checking the spi device settings that was already in
existence.

> So add a comment to make this clearer for people who hack on this after you.
>
>> There was no comment about
>> it before.  You're insisting that changes be broken up to the extent
>> that changing one line of code takes multiple patches!  Now you want a
>> comment about existing driver behavior added to patch that doesn't
>> change that behavior?
>>
>> Documenting the driver behavior would seem to be a job for the driver
>> maintainer.  If doing this is something I need to do, then maybe I
>> should maintain it?
>
> You ain't rubbing people the right way at all, I tell you. This pushy/offensive
> behavior helps noone, calm down please. It is usually a good idea to sleep on
> your reply or take your time.

Well neither are you!  I put up with your nitpicking far more than I
should have.  Move a comment from one line to another?  Really?  You
want me to waste the time to make a new patch series just because you
think a four word comment would look nicer one line up?  That's
ridiculous!  I think you've gone beyond the point of finding flaws or
mistakes (have you found any actual bugs in any of my code?) and are
just being obstructionist.

> Ad maintainership -- there's no maintainer of the driver, there's only Fabio,
> Shawn, me and the SPI subsystem guys. And it works well. It's everybodys' code
> and everyone's welcome to contribute. What's the problem?

I've spent far more time dealing with demands to split tiny patches
into even tinier patches and tweak the exact character placement to
your personal desires than I did to find and fix the bugs in the first
place!  I think you should accept that if you didn't fix the driver
before now, then someone else is going to fix it or replace it.  So
you had your opportunity to get every last character exactly the way
you wanted it and that passed.  I fixed it.  So I get to use my
judgement and write what I think is best.  If you can find any actual
bugs, or even CodingStyle errors, or merely that a majority of
existing kernel code is stylistically different, or different way of
doing something that has an object improvement, then I'm all ears.
But there is no need for you to complain about completely irrelevant
details.  I've had people submit patches to my code that didn't do
things the way I would have done it.  But you know what, if I wanted
it done my way I should have done it myself when I had the chance.

Since I seem to know how this driver works better than anyone else who
has come forward, maybe I should maintain it?  That way I can spend my
time fixing it instead or dealing making silly changes to patches.
