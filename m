From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Aug 2013 12:09:31 +0100
Subject: Proposal: I2C device power (Was: hwmon: (lm90) Add power control)
In-Reply-To: <1376045411.585130456@f141.i.mail.ru>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1376027820.695103970@f416.i.mail.ru>
 <20130809102757.GT6427@sirena.org.uk>
 <1376045411.585130456@f141.i.mail.ru>
Message-ID: <20130809110931.GX6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 02:50:11PM +0400, Alexander Shiyan wrote:

> > This would need to be an array of supplies, relatively few devices need
> > only a single power supply.  This is also not something that should be
> > handled in I2C, power is not something that's uniquely needed by devices
> > on an I2C bus.

> Additional regulators can be handled in the driver, or "parent"-scheme can
> be used. Is not it?

Given how common it is to have multiple supplies it seems sensible to
just handle that in the core - it's common to have a digital supply and
an analogue supply for example.  The regulator framework already has
APIs for working with multiple regulators in a single call so it's not
going to be much more effort on the framework side.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/cc925490/attachment.sig>
