From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Aug 2013 14:32:06 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130805233015.GY23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
Message-ID: <20130806133206.GA6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 12:30:15AM +0100, Russell King - ARM Linux wrote:

> I put it to you that DPCM in mainline is incomplete and nonfunctional
> as it currently stands.  Moreover, it requires either those who know
> that code to continue to develop it, or someone else who understands
> the direction that this code is supposed to go picks up to complete it.

I'd be most distressed if it were far off working; it's close enough to
the out of tree code I've worked with and I know there were drivers in
progress when it was submitted.  We've certainly had at least one bug
fix from the out of tree users, I'd be surprised if we had anything more
substantial than bitrot in the current code.

> Add to that that you say that this was being developed with TI and
> the TI situation happened, it seems unlikely to me that there's any
> significant chance of movement on that.

TI isn't going to be a big problem here.  As you've seen Intel are
currently using it for Haswell and they are generally keen on
upstreaming, Qualcomm are also relying very heavily on this and the
OMAP4s are still out there albeit with a reduced development team.
There's a few others including one I expect to get round to when I'm not
spending my time writing mails like this but those the the big systems
with active use.

> So, insisting that DPCM is used for this driver is grossly unfair.

The framework can't cope with simultaneous use of both interfaces unless
DPCM is used or the framework is otherwise extended.  This is not an
unusual situation and given that there is already framework there it
would seem to be the most sensible starting point.  As is normal any
driver local approach is going to need to not get in the way of
framework development.

> Let's not forget: Liam may be working on this stuff, and may have his own
> set of patches to sort out DPCM, so having patches from me messing around
> with the DPCM code apparantly "fixing" problems with it may very well be
> counter-productive.  Again - Liam needs to provide some input on this.

Liam is on vacation this week, he'll be back next week.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130806/c9f532aa/attachment.sig>
