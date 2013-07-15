From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Jul 2013 12:25:03 +0100
Subject: [PATCH] ARM: EXYNOS: remove references to non-DT SoCs
In-Reply-To: <1373807896.1370.43.camel@x61.thuisdomein>
References: <1373804812.1370.23.camel@x61.thuisdomein>
 <20130714124538.GA11538@sirena.org.uk>
 <1373807896.1370.43.camel@x61.thuisdomein>
Message-ID: <20130715112503.GB11538@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 14, 2013 at 03:18:16PM +0200, Paul Bolle wrote:
> On Sun, 2013-07-14 at 13:45 +0100, Mark Brown wrote:

> > Simply removing the dependencies is not going to give the clearly
> > intended effect here.  The dependency on the DT only machine needs to be
> > replaced with something, not just deleted, otherwise the driver can't be
> > enabled in Kconfig.

> I interpreted commit 383ffda2fa as a commit that just removed a lot of

Always provide human readable descriptions of commits in email.

> stuff: see its commit explanation and its diffstat (it adds one line and
> deletes over 900 lines). Moreover, after that commit the references to
> MACH_SMDKV310 and MACH_SMDKC210 both are nops. Deleting them can't
> possibly change anything.

This still doesn't have much to do with your commit message or indicate
much understanding of what the change is actually doing or why it might
be a problem.

> But, anyhow, what would be the symbols to use here?

Well, let's think about this for a minute - what is going on when
someone does a device tree conversion on a platform?  What is replacing
the board files?  What would an equivalent change be for the audio
driver?

> Besides, this patch was intended as a follow up to commit 383ffda2fa, to
> clean up two references it apparently forgot to remove, and therefor
> basically copied the subject line used in that commit.

That doesn't really help - putting in a completely irrelevant subject
line is a really good way to get your patch ignored.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/1ec4cc47/attachment.sig>
