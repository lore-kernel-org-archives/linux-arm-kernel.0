From: joe@perches.com (Joe Perches)
Date: Wed, 05 Feb 2014 06:03:13 -0800
Subject: [ath9k-devel] [PATCH 1/3] ath9k: Fix build error on ARM
In-Reply-To: <20140205133956.GQ26684@n2100.arm.linux.org.uk>
References: <1391483274-20331-1-git-send-email-sujith@msujith.org>
 <1391483274-20331-2-git-send-email-sujith@msujith.org>
 <1391484878.2538.11.camel@joe-AO722>
 <21232.24855.201543.400943@gargle.gargle.HOWL>
 <CAOpc7mFQZ3efZda0cC28BLATqRDJ99BRNu=ezQq8wa+dyFyOvA@mail.gmail.com>
 <1391531796.2538.21.camel@joe-AO722>
 <20140205115035.GO26684@n2100.arm.linux.org.uk>
 <1391603566.2538.63.camel@joe-AO722>
 <20140205124127.GP26684@n2100.arm.linux.org.uk>
 <1391605494.2538.68.camel@joe-AO722>
 <20140205133956.GQ26684@n2100.arm.linux.org.uk>
Message-ID: <1391608993.2538.74.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-05 at 13:39 +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 05, 2014 at 05:04:54AM -0800, Joe Perches wrote:
> > On Wed, 2014-02-05 at 12:41 +0000, Russell King - ARM Linux wrote:
> > > On Wed, Feb 05, 2014 at 04:32:46AM -0800, Joe Perches wrote:
> > > > Apparently, people just convert stupidly large udelay()s
> > > > to mdelay and not be bothered.
> > > 
> > > And that's the correct answer.  Having udelay(10000) rather than mdelay(10)
> > > is a sign that they weren't paying that much attention when writing the
> > > code.
> > 
> > Not really.
[]
> > It's not so much not paying attention as not
> > knowing ARM is broken for large udelay().
> 
> And now read my suggestion about how to avoid the "not knowing" problem. :)

I'd read it already.  I didn't and don't disagree.

I still think adding a #warning on large static udelay()s
would be sensible.  Maybe adding another option like
#define UDELAY_TOO_BIG_I_KNOW_ALREADY_DONT_BOTHER_ME
guard to avoid seeing the #warning when there's no other
option.
