From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 May 2016 12:28:56 +0100
Subject: [PATCH v2 1/3] regulator: DT: Add DT property for operation mode
 configuration
In-Reply-To: <20160523104703.GB26992@leverpostej>
References: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
 <1463987611-32139-2-git-send-email-henryc.chen@mediatek.com>
 <20160523104703.GB26992@leverpostej>
Message-ID: <20160523112856.GR8206@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 11:47:04AM +0100, Mark Rutland wrote:

> > +/* Regulator operating modes */
> > +#define REGULATOR_OPERATION_MODE_FAST			0x0
> > +#define REGULATOR_OPERATION_MODE_NORMAL			0x1
> > +#define REGULATOR_OPERATION_MODE_IDLE			0x2
> > +#define REGULATOR_OPERATION_MODE_STANDBY		0x3

> These sound like they're tied to linux internal details (e.g. the
> implementation of idle and/or suspend).

> What do each of these actually mean?

They are not really at all general and I'm fairly sure I've provided the
same feedback repeatedly on earlier versions of the patch set.  They are
not entirely based on Linux internal details (or at least the Linux
internal details tend to flow from the hardware) - broadly fast is
forced PWM, normal is default, idle is LDO mode and standby is a lower
quality LDO mode - but how this translates into anything that a consumer
could actually use is unclear since the supported output loads and
quality of regulation can vary wildy.  It's also somewhat implementation
dependent what a given regulator does (and it's always possible that
some regulators may have more modes to control or differing definitions
in the hardware).

Henry, *please* look at how the existing mode support in the bindings is
done and consider how a consumer would use this given that it doesn't
know anything about the regulator...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160523/45c856a7/attachment.sig>
