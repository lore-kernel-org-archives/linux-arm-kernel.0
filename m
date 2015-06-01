From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Jun 2015 11:55:56 +0200
Subject: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
In-Reply-To: <20150529203456.GC22083@amd>
References: <20150527145837.GA13223@earth> <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd> <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd> <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost> <20150529203456.GC22083@amd>
Message-ID: <20150601095556.GH17267@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 10:34:56PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > single DT, you don't even use that property in your driver, and now
> > > > that you realise you meant something else, you want the code that
> > > 
> > > not Pali, Sebastian.
> > > 
> > > > actually parse the *right* property and does the right thing, that all
> > > > other DT agree (and depend on) to be reverted?
> > > 
> > > We shouldn't revert, that I agree. But both properties should be parsed.
> > 
> > No. If the property is wrong, and nobody parsed it, I do not see any reason to
> > start now.
> 
> Agreed.
> 
> But that's not what I'm asking. See a changelog of
> 3eea8b5d68c801fec788b411582b803463834752 and compare it with what it
> actually does.
> 
> It is buggy. If fuzz is specified but maximum is not, it overwites
> maximum with zero.

If maximum is not set, you'll have other issues anyway. But it really
boils down on what the default behaviour should be.

> Plus it introduces new failure "if (!test_bit(axis, dev->absbit))".

It's not a new failure, it's testing against stupid code.

If an axis is setup in the DT but not registered in the driver,
something is wrong, most probably the DT.

> Plus it fails to distinguish between "value not specified in the dt"
> and "zero is specified in the dt".

Again, default behaviour.

> The 3eea8b5d68c801fec788b411582b803463834752 is just bad.

You were very welcome to review this patch at the time and/or suggest
a fix that pleases everyone.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/a21a0745/attachment-0001.sig>
