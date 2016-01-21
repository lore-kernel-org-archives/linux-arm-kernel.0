From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jan 2016 16:46:49 +0100
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20160118162538.GH6588@sirena.org.uk>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
 <20160115085734.GG4581@lukather>
 <20160117000434.GB7774@rob-hp-laptop>
 <20160118162538.GH6588@sirena.org.uk>
Message-ID: <20160121154649.GE3997@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 18, 2016 at 04:25:38PM +0000, Mark Brown wrote:
> > >   - When you come to consider it from an hardware point of view, the
> > >     device usually have a single pin that powers it. It's the board
> > >     designer that chose to route that pin to multiple regulators, so
> > >     it's really the board that is wired that way, and putting that
> > >     code in the consumer drivers would be an abstraction leak imho.
> 
> > That's a good point. Perhaps the regulator core needs to be able to 
> > parse the list and return the single ptr to the virtual regulator.
> 
> Exactly, if we don't want to represent the combination directly.  For
> most uses it's probably OK but I can see us in a situation where we
> might want to do things like only use one of the regulators in low load
> situations where we might want to attach properties to the merge of the
> two regulators rather than just referencing them both.  I'm not sure
> that's realistic though or that we wouldn't just be working that use
> case out dynamically at runtime.
> 
> I'm ambivalent on which way is better, it does complicate the
> implementation to support doing this as lists and while it makes the DT
> more elegant I'm not clear that it's worth the effort especially when it
> comes to constraint combining.  But perhaps the implementation turns out
> to be simpler than I would anticiapte.

I guess a separate driver would make it easier to deal with cases like
the one you suggested (shutting down when the load is going to be
lower). I don't see how we could have a good DT representation of that
if we're going to use lists.

Anyway, I'm fine with both approaches, just let me know what you
prefer.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/4c321625/attachment.sig>
