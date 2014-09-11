From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Sep 2014 17:16:23 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <20140911090608.598CFC40862@trevor.secretlab.ca>
References: <540C7F5B.6070307@gmail.com> <540C83DE.10505@collabora.co.uk>
 <540C8577.2070907@gmail.com> <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
 <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
 <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
 <20140910143144.GF7960@sirena.org.uk>
 <20140911090608.598CFC40862@trevor.secretlab.ca>
Message-ID: <20140911161623.GN4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 10:06:08AM +0100, Grant Likely wrote:
> On Wed, 10 Sep 2014 15:31:44 +0100, Mark Brown <broonie@kernel.org> wrote:

> > As well as the regulators we'll also need to fix the clocks.  If we're
> > going to start adding these fixups perhaps we want to consider having a
> > wrapper stage that deals with rewriting DTs prior to trying to use them?
> > I'm not sure if it makes much difference but there's overlap with other
> > tools like the ATAGs conversion wrapper and building separately would
> > let the fixup code run early without directly going into the early init
> > code (which seems a bit scary).

> We've already got a dt fixup hook in the machine struct, created for
> exactly this reason. Fixing an incorrect DT provided by firmware:

> arch/arm/include/asm/mach/arch.h:
> struct machine_desc {
> 	...
> 	void (*dt_fixup)(void);
> 	...

Hrm, that's in the machine descriptor which doesn't seem the ideal
place - something keying off machine ID would be nicer.  But that's
relatively speaking just detail.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/e7db3824/attachment.sig>
