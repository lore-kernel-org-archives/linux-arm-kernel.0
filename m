From: joe@perches.com (Joe Perches)
Date: Fri, 17 Feb 2017 17:38:28 -0800
Subject: [PATCH 5/5] staging: bcm2835-audio: bcm2835.h: fix line length
 coding style issue
In-Reply-To: <CADRb1HaEAFv-gswjvtf4=gr8H9r6bh_Q_jcp8pN6FEaJBo8QQg@mail.gmail.com>
References: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
 <1487362603-15967-5-git-send-email-adanhawthorn@gmail.com>
 <1487380676.2198.11.camel@perches.com>
 <CADRb1HaEAFv-gswjvtf4=gr8H9r6bh_Q_jcp8pN6FEaJBo8QQg@mail.gmail.com>
Message-ID: <1487381908.2198.14.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-02-17 at 20:32 -0500, Adan Hawthorn wrote:
> Thanks, Joe.
> 
> Is this to say that scripts/checkpatch.pl should be updated to some
> higher column limit?  I have made these cleanup changes before in a
> like manner.

Hard to say.

There could be some sensitivity to long identifier
name lengths added to checkpatch, but < 80 column
line length is still currently "strongly preferred".

I don't care much one way or another if it's 80
or 100 or something else as long as it's context
appropriate.

Awhile ago, Linus Torvalds wrote:

On Thu, 2016-12-15@18:10 -0800, Linus Torvalds wrote:
> On Thu, Dec 15, 2016 at 5:57 PM, Joe Perches <joe@perches.com> wrote:
> > > 
> > > In fact, I thought we already upped the check-patch limit to 100?
> > 
> > Nope, CodingStyle neither.
> > 
> > Last time I tried was awhile ago.
> 
> Ok, it must have been just talked about, and with the exceptions for
> strings etc I may not have seen as many of the really annoying line
> breaks lately.
> 
> I don't mind a 80-column "soft limit" per se: if some code
> consistently goes over 80 columns, there really is something seriously
> wrong there. So 80 columns may well be the right limit for that kind
> of check (or even less).
> 
> But if we have just a couple of lines that are longer (in a file that
> is 3k+ lines), I'd rather not break those.
> 
> I tend use "git grep" a lot, and it's much easier to see function
> argument use if it's all on one line.
> 
> Of course, some function calls really are *so* long that they have to
> be broken up, but that's where the "if it's a couple of lines that go
> a bit over the 80 column limit..." exception basically comes in.
> 
> Put another way: long lines definitely aren't good. But breaking long
> lines has some downsides too, so there should be a balance between the
> two, rather than some black-and-white limit.
> 
> In fact, we've seldom had cases where black-and-white limits work well.
> 
