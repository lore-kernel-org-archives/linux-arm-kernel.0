From: broonie@kernel.org (Mark Brown)
Date: Tue, 8 Dec 2015 16:54:56 +0000
Subject: [PATCH] regulator: add regulator_sync_voltage inline dummy
In-Reply-To: <18141514.YrJxqxh5jL@wuerfel>
References: <1983152.2iYiBkp4xd@wuerfel> <20151208163739.GS5727@sirena.org.uk>
 <18141514.YrJxqxh5jL@wuerfel>
Message-ID: <20151208165456.GT5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 05:49:20PM +0100, Arnd Bergmann wrote:
> On Tuesday 08 December 2015 16:37:39 Mark Brown wrote:
> > On Tue, Dec 08, 2015 at 04:43:35PM +0100, Arnd Bergmann wrote:

> > We don't do this for *all* regulator API functions - there's some where
> > using them strongly suggests that there is actually a dependency on the
> > regulator API.  This does seem like it might be falling into the
> > specialist category...

> Ok, got it.

> I guess we'll want something like the patch below in the cpufreq git, right?

Yes, exactly - though looking at the code I'm pretty unclear on what the
authors think the use of _sync_voltage() is doing in the first place so
it may be even better to just remove the call.  It seems to have been
included in the first commit so there's not changelog explaining things
and there's no comment either.  I'd *expect* it to be a noop as far as I
can see.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/ee54981d/attachment.sig>
