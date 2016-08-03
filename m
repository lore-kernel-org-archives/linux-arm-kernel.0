From: w@1wt.eu (Willy Tarreau)
Date: Wed, 3 Aug 2016 11:21:52 +0200
Subject: [PATCH] Add file permission mode helpers
In-Reply-To: <20160803083902.GA3643@gmail.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
 <20160803081140.GA7833@gmail.com>
 <20160803082855.GA32280@kroah.com>
 <20160803083902.GA3643@gmail.com>
Message-ID: <20160803092152.GD500@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 10:39:03AM +0200, Ingo Molnar wrote:
> > > While the weird permissions in this:
> > > 
> > > +		__ATTR(l1, PERM_r__r__r__,  driver_show_l4, NULL);
> > > +		__ATTR(l3, PERM_r__r__rw_,  driver_show_l4, NULL);
> > > +		__ATTR(l2, PERM_sr__r__r__, driver_show_l4, NULL);
> > > +		__ATTR(l4, PERM_r__r__r__,  driver_show_l4, NULL);
> > > 
> > > Wouln't even build, because the dangerous patterns of PERM_r__r__rw_ or 
> > > PERM_sr__r__r__ are not defined to begin with.
> > 
> > Because of that, odds are people will just stick to the octal numbers,
> > because they think they want something other than the ones you defined
> > for foolish reasons :)
> 
> For code I maintain I'd insist on contributors using the human readable versions, 
> because in the past I've mixed up octals (and the symbolic helpers we have today) 
> myself and I find the 'ls -l' format much easier to read because that's the 
> primary file permission format I see every day working on code.

FWIW, the only "human readable" ones for me are the octal ones, which are
also the same as those I'm using every day with "chmod" or "find" and that
I find hard to get wrong. But I agree that the PERM_* idea above are a nice
alternative since they match the "ls -l" output, and you can even add the
directory flag there with "d" like "ls" does. You could also have PERM_0444
and similar for those who are more at ease with the octal numers without
defining the few ones that are definitely wrong, as a safety belt.

> > That being said, I do like them much better than the macros we have today, which 
> > I always have to go and look up every time I see them...
> 
> Same here!

Same for me. I never use S_I* and never know where to look for their
definitions when I see them.

Willy
