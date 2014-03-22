From: broonie@kernel.org (Mark Brown)
Date: Sat, 22 Mar 2014 19:29:06 +0000
Subject: [linux-sunxi] Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
In-Reply-To: <20140322190803.GA20987@localhost.fastwebnet.it>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
 <20140322165132.GC20668@localhost.fastwebnet.it>
 <20140322173313.GU552@sirena.org.uk>
 <CAOQ7t2Yg5pp_rXYfsdnHpy-zGFGimzT3EW15P_0ugYMtgPtOrw@mail.gmail.com>
 <20140322184201.GA27611@core.coreip.homeip.net>
 <20140322190803.GA20987@localhost.fastwebnet.it>
Message-ID: <20140322192906.GA2269@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 08:08:03PM +0100, Carlo Caione wrote:
> On Sat, Mar 22, 2014 at 11:42:01AM -0700, Dmitry Torokhov wrote:

> > > drivers/mfd/axp20x.c:172:18: warning: assignment makes integer
> > > frompointer without a cast [enabled by default]

> > You need to cast to long, otherwise you will get warnings when compiling
> > on 64 bit arches.

> Actually no warning also with (int) cast.

That's because you squashed it to something smaller than a long using
the cast.  The other option is to make the variable you're assigning to
suitable to hold the value - intptr_t or a long.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140322/736dbead/attachment.sig>
