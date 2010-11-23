From: joe@perches.com (Joe Perches)
Date: Tue, 23 Nov 2010 15:23:27 -0800 (PST)
Subject: About multi-line printk and the need (not) to repeat loglevel
	markers [Was: Re: [PATCH] ARM: mx3/pcm037: properly allocate memory for
	mx3-camera]
In-Reply-To: <20101123223344.GE26510@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.30.1011231520150.20819-100000@mail.perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Nov 2010, Russell King - ARM Linux wrote:

> On Wed, Nov 24, 2010 at 07:16:06AM +0900, Linus Torvalds wrote:
> > No. The KERN_WARNING in the middle of a string is always totally
> > bogus. There is no "should be". It's just wrong.
> Oh dear.
> Sounds like this is something which needs auditing as a result of your
> change, and sounds like its something that kernelnewbies people could
> do.  My own greps haven't revealed any cases though.

They used to.  I tried to fix all of the ones I could find
about a year ago.

commit ad361c9884e809340f6daca80d56a9e9c871690a
Author: Joe Perches <joe@perches.com>
Date:   Mon Jul 6 13:05:40 2009 -0700

    Remove multiple KERN_ prefixes from printk formats

    Commit 5fd29d6ccbc98884569d6f3105aeca70858b3e0f ("printk: clean up
    handling of log-levels and newlines") changed printk semantics.  printk
    lines with multiple KERN_<level> prefixes are no longer emitted as
    before the patch.

    <level> is now included in the output on each additional use.

    Remove all uses of multiple KERN_<level>s in formats.

    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
