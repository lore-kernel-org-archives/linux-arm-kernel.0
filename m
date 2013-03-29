From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 29 Mar 2013 18:30:01 +0000
Subject: [PATCH] clocksource: Fix build in non-OF case
In-Reply-To: <201303281447.51532.arnd@arndb.de>
References: <1364473805-773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201303281308.22738.arnd@arndb.de>
 <20130328131044.GA18316@opensource.wolfsonmicro.com>
 <201303281447.51532.arnd@arndb.de>
Message-ID: <20130329183001.GK18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 02:47:51PM +0000, Arnd Bergmann wrote:

> Since we recently introduced the IS_ENABLED() macro to test for preprocessor
> symbols, I think there is a general trend away from any #ifdefs in driver
> code.

I have to say I'm not seeing any evidence of this in the patches I'm
seeing, and I'm not sure what the connection with IS_ENABLED() is?  It's
a reasonable idea, just likely to surprise people given the amount of
boilerplate we've got for things like PM - I guess we'd need to make
sure those macros do references as well, they're the main users of
ifdefs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130329/fa5af154/attachment.sig>
