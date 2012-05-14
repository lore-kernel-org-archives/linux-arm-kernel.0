From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 May 2012 18:01:43 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <4FB12981.8050603@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FB12981.8050603@linaro.org>
Message-ID: <20120514170143.GF25668@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 04:49:21PM +0100, Lee Jones wrote:

> >You should be using of_regulator_match() for this (I think it's supposed
> >to do an equivalent job...) rather than open coding.

> I've ripped this out completely and the code appears to continue be
> fully functional. Happy days! :)

Great!

> The original driver places each of the registers inside a structure
> within the driver itself and recursively registers them from there.
> The constraints are united with the correct element using #defines.

> Can't we just assume that all of the regulators will be put into the
> Device Tree? As this is what I'll be doing.

Part of the idea here is to help with diagnostics, especially during
board bringup, so we really shouldn't be relying on the user to have set
things up reliably.  This is also used to enabled features like powering
off any unused regulators that were left enabled in late init so things
that weren't set up turn out to be moderately important.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/cccade9e/attachment.sig>
