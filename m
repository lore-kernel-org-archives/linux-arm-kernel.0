From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Feb 2014 21:26:44 +0900
Subject: [PATCH 2/2] regulator: core: Error on not always_on dummy
 regulators
In-Reply-To: <1393322627-26543-3-git-send-email-mpa@pengutronix.de>
References: <1393322627-26543-1-git-send-email-mpa@pengutronix.de>
 <1393322627-26543-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20140225122644.GC25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:03:47AM +0100, Markus Pargmann wrote:
> It does not make sense to have dummy/fixed regulators that are not
> always_on. This patch adds a check in the set_machine_constraints
> function for this case and returns -EINVAL if such a regulator is
> registered.

Such a regulator isn't going to be useful in a system but that doesn't
mean that they shouldn't be registerable since that allows people to
look at their state.  For example a device might have some GPIO managed
regulators where the GPIO is tied low if the regulator isn't in use in
the system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/d7f50849/attachment.sig>
