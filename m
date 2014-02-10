From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Feb 2014 14:12:55 +0000
Subject: [PATCH 14/28] Remove MACH_SMDKC210
In-Reply-To: <1392039072.3585.15.camel@x220>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-15-git-send-email-richard@nod.at>
 <20140210114154.GQ1757@sirena.org.uk>
 <1392039072.3585.15.camel@x220>
Message-ID: <20140210141255.GI1757@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 02:31:12PM +0100, Paul Bolle wrote:
> On Mon, 2014-02-10 at 11:41 +0000, Mark Brown wrote:
> > On Sun, Feb 09, 2014 at 07:47:52PM +0100, Richard Weinberger wrote:

> > Please fix whatever script you're using to generate your mails, it's
> > generating corrupt headers.

> I think Richard's mail didn't end up on lkml. But it's pretty clear what
> it must have looked like.

I can see what it looked like from my inbox, but my mail client can't
understand them at all and hence didn't think the mails were sent to me
and just ignored them when hitting reply.

> > >  config SND_SOC_SAMSUNG_SMDK_WM9713
> > >  	tristate "SoC AC97 Audio support for SMDK with WM9713"
> > > -	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
> > > +	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310)
> > 
> > Like I said to Paul this isn't fixing the actual issue - think about why
> > the symbol was there in the first place and why it was removed.  There
> > is a problem here but this would make it less likely that it would be
> > properly fixed.

> Would you mind going through this one step at a time, just to make sure
> _I_ understand what it is that you'd like to see?

> If so, to be absolutely sure we start from the same point: do you agree
> that the above line now effectively reads
>     depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || false || false)

> because there's neither a Kconfig symbol MACH_SMDKV310 nor a Kconfig
> symbol MACH_SMDKC210?

Yes, that's correct.  Now, like I say think about what the symbol was
there for in the first place.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/17ff5e43/attachment.sig>
