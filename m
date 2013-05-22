From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 May 2013 12:45:16 -0500
Subject: [PATCH] regulator: ab8500-ext: Don't register without
 initialisation data
In-Reply-To: <20130522165353.GB18714@gmail.com>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
 <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
 <20130522155347.GJ1627@sirena.org.uk>
 <20130522165353.GB18714@gmail.com>
Message-ID: <20130522174516.GT1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 05:53:53PM +0100, Lee Jones wrote:
> On Wed, 22 May 2013, Mark Brown wrote:

> > running or not, the worst that should happen is that the state can be
> > read back.  I'd therefore expect the fix here to be in the board side
> > code that enables the regulators.

> It's both.

> From the platform side we have stopped passing the external regulator
> driver's constraints for Snowball:

> https://lkml.org/lkml/2013/5/22/280

> All I've done here is stop the ext driver from crapping out with the
> misleading error "Configuration error: size mismatch", because a)
> it's not an error, it's expected and b) It's not a size mismatch,
> instead we have chosen to keep the constraints back in the Snowball
> (and u8505) case.

OK, so the regulator driver is buggy and insisting on having constraints
passed in for every regulator then?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130522/7ecf3ecc/attachment.sig>
