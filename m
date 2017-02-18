From: adanhawthorn@gmail.com (Adan Hawthorn)
Date: Fri, 17 Feb 2017 21:08:46 -0500
Subject: [PATCH 5/5] staging: bcm2835-audio: bcm2835.h: fix line length
 coding style issue
In-Reply-To: <1487381908.2198.14.camel@perches.com>
References: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
 <1487362603-15967-5-git-send-email-adanhawthorn@gmail.com>
 <1487380676.2198.11.camel@perches.com>
 <CADRb1HaEAFv-gswjvtf4=gr8H9r6bh_Q_jcp8pN6FEaJBo8QQg@mail.gmail.com>
 <1487381908.2198.14.camel@perches.com>
Message-ID: <CADRb1Hb19kT+RmSvgiP1nGhHuENKk3PZre3BQOpq88cZ41wgDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, I personally like that better anyhow.  Also, there was mention of
the line limit even exceeding 100 characters (130ish?) and that was
being tossed around at one point (if I remember correctly).

On Fri, Feb 17, 2017 at 8:38 PM, Joe Perches <joe@perches.com> wrote:
> On Fri, 2017-02-17 at 20:32 -0500, Adan Hawthorn wrote:
>> Thanks, Joe.
>>
>> Is this to say that scripts/checkpatch.pl should be updated to some
>> higher column limit?  I have made these cleanup changes before in a
>> like manner.
>
> Hard to say.
>
> There could be some sensitivity to long identifier
> name lengths added to checkpatch, but < 80 column
> line length is still currently "strongly preferred".
>
> I don't care much one way or another if it's 80
> or 100 or something else as long as it's context
> appropriate.
>
> Awhile ago, Linus Torvalds wrote:
>
> On Thu, 2016-12-15 at 18:10 -0800, Linus Torvalds wrote:
>> On Thu, Dec 15, 2016 at 5:57 PM, Joe Perches <joe@perches.com> wrote:
>> > >
>> > > In fact, I thought we already upped the check-patch limit to 100?
>> >
>> > Nope, CodingStyle neither.
>> >
>> > Last time I tried was awhile ago.
>>
>> Ok, it must have been just talked about, and with the exceptions for
>> strings etc I may not have seen as many of the really annoying line
>> breaks lately.
>>
>> I don't mind a 80-column "soft limit" per se: if some code
>> consistently goes over 80 columns, there really is something seriously
>> wrong there. So 80 columns may well be the right limit for that kind
>> of check (or even less).
>>
>> But if we have just a couple of lines that are longer (in a file that
>> is 3k+ lines), I'd rather not break those.
>>
>> I tend use "git grep" a lot, and it's much easier to see function
>> argument use if it's all on one line.
>>
>> Of course, some function calls really are *so* long that they have to
>> be broken up, but that's where the "if it's a couple of lines that go
>> a bit over the 80 column limit..." exception basically comes in.
>>
>> Put another way: long lines definitely aren't good. But breaking long
>> lines has some downsides too, so there should be a balance between the
>> two, rather than some black-and-white limit.
>>
>> In fact, we've seldom had cases where black-and-white limits work well.
>>
