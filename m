From: broonie@kernel.org (Mark Brown)
Date: Sat, 6 Sep 2014 13:54:48 +0100
Subject: [PATCH] irqchip: gic-v3: Only define gic_peek_irq() when
 building SMP
In-Reply-To: <20140817165736.GD12769@titan.lakedaemon.net>
References: <1406480224-24628-1-git-send-email-broonie@kernel.org>
 <20140817165736.GD12769@titan.lakedaemon.net>
Message-ID: <20140906125448.GB32429@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 12:57:36PM -0400, Jason Cooper wrote:
> On Sun, Jul 27, 2014 at 05:57:04PM +0100, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > If building with CONFIG_SMP disbled (for example, with allnoconfig) then
> > GCC complains that the static function gic_peek_irq() is defined but not
> > used since the only reference is in the SMP initialisation code. Fix this
> > by moving the function definition inside the ifdef.

> Applied to irqchip/urgent with Mark's Ack.

This also appears to have disappeared from -next and again the warning
is back.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140906/17ba6c0f/attachment.sig>
