From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 3 Aug 2016 01:42:26 +0100
Subject: Please don't replace numeric parameter like 0444 with macro
In-Reply-To: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
Message-ID: <20160803004226.GF2356@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 04:58:29PM -0400, Linus Torvalds wrote:
> [ So I answered similarly to another patch, but I'll just re-iterate
> and change the subject line so that it stands out a bit from the
> millions of actual patches ]
> 
> On Tue, Aug 2, 2016 at 1:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
> > S_IRCRP | S_IROTH (*). Please don't do this.
> 
> Absolutely. It's *much* easier to parse and understand the octal
> numbers, while the symbolic macro names are just random line noise and
> hard as hell to understand. You really have to think about it.
> 
> So we should rather go the other way: convert existing bad symbolic
> permission bit macro use to just use the octal numbers.
> 
> The symbolic names are good for the *other* bits (ie sticky bit, and
> the inode mode _type_ numbers etc), but for the permission bits, the
> symbolic names are just insane crap. Nobody sane should ever use them.
> Not in the kernel, not in user space.

Except that you are inviting the mixes like S_IFDIR | 17 /* oops, should've
been 017, or do we spell it 0017? */ that way.  I certainly agree that this
patch series had been a huge pile of manure, but "let's convert it in other
direction" is inviting pretty much the same thing, with lovely potential for
typos, etc.
