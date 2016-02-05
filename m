From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 Feb 2016 15:33:28 +0100
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20160121162802.GL6588@sirena.org.uk>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
 <20160115085734.GG4581@lukather>
 <20160117000434.GB7774@rob-hp-laptop>
 <20160118162538.GH6588@sirena.org.uk>
 <20160121154649.GE3997@lukather>
 <20160121162802.GL6588@sirena.org.uk>
Message-ID: <20160205143328.GD31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Jan 21, 2016 at 04:28:02PM +0000, Mark Brown wrote:
> On Thu, Jan 21, 2016 at 04:46:49PM +0100, Maxime Ripard wrote:
> 
> > I guess a separate driver would make it easier to deal with cases like
> > the one you suggested (shutting down when the load is going to be
> > lower). I don't see how we could have a good DT representation of that
> > if we're going to use lists.
> 
> We can have a driver regardless of what the DT looks like, it's a
> question of how things get instantiated.
> 
> > Anyway, I'm fine with both approaches, just let me know what you
> > prefer.
> 
> Without seeing an implementation of the lists it's hard to say.

Just to make sure we're on the same page: you want to keep the
regulator, but instead of giving the parent through vinX-supplies
properties, you want to have a single *-supply property, with a list
of regulators, right?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160205/72f96a81/attachment.sig>
