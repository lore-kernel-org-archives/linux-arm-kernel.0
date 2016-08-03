From: joe@perches.com (Joe Perches)
Date: Wed, 03 Aug 2016 08:49:26 -0700
Subject: [PATCH] Add file permission mode helpers
In-Reply-To: <20160803081140.GA7833@gmail.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
 <20160803081140.GA7833@gmail.com>
Message-ID: <1470239366.3998.227.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-03 at 10:11 +0200, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > [ So I answered similarly to another patch, but I'll just re-iterate
> > and change the subject line so that it stands out a bit from the
> > millions of actual patches ]
> > 
> > On Tue, Aug 2, 2016 at 1:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > > Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
> > > S_IRCRP | S_IROTH (*). Please don't do this.
> > Absolutely. It's *much* easier to parse and understand the octal
> > numbers, while the symbolic macro names are just random line noise and
> > hard as hell to understand. You really have to think about it.
> > 
> > So we should rather go the other way: convert existing bad symbolic
> > permission bit macro use to just use the octal numbers.
> In addition to that I'd love to have something even easier to read, a few common?
> variants of the permissions field of 'ls -l' pre-defined. I did some quick?
> grepping, and collected the main variants that are in use:
> 
> 		PERM_r________	0400
> 		PERM_r__r_____	0440
> 		PERM_r__r__r__	0444

[etc]

While the proposed PERM_ variants are easily read,
using a single style instead of 2+ incompatible
symbolic styles makes treewide misuse identification
via grep style tools easier.
