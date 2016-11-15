From: rabin.vincent@axis.com (Rabin Vincent)
Date: Tue, 15 Nov 2016 16:18:27 +0100
Subject: [PATCH] ARM: ftrace: fix syscall name matching
In-Reply-To: <20161114104008.36e9c40d@gandalf.local.home>
References: <1479128625-20948-1-git-send-email-rabin.vincent@axis.com>
 <20161114134017.GJ1041@n2100.armlinux.org.uk>
 <20161114104008.36e9c40d@gandalf.local.home>
Message-ID: <20161115151826.GA14085@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 10:40:08AM -0500, Steven Rostedt wrote:
> On Mon, 14 Nov 2016 13:40:17 +0000
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> > On Mon, Nov 14, 2016 at 02:03:45PM +0100, Rabin Vincent wrote:
> > > +static inline bool arch_syscall_match_sym_name(const char *sym,
> > > +					       const char *name)
> > > +{
> > > +	/* Skip sys_ */
> > > +	sym += 4;
> > > +	name += 4;  
> > 
> > Is this really safe?  What guarantees that we can wind forward four
> > bytes here?  If it's always safe, it needs a better comment than just
> > two words.
> 
> I believe it is, but a comment would do well.

I ended up just getting rid of the skip and comparing the whole name
instead.  I've sent a v2.
