From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 13:10:44 +0000
Subject: [PATCH] clocksource: Fix build in non-OF case
In-Reply-To: <201303281308.22738.arnd@arndb.de>
References: <1364473805-773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201303281239.46639.arnd@arndb.de>
 <20130328125513.GY18316@opensource.wolfsonmicro.com>
 <201303281308.22738.arnd@arndb.de>
Message-ID: <20130328131044.GA18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 01:08:22PM +0000, Arnd Bergmann wrote:
> On Thursday 28 March 2013, Mark Brown wrote:

> > That still looks like it'll reference the function?

> Yes, that is intentional. The idea is to create a reference to the
> function so gcc doesn't complain about unused symbols if the function
> gets marked static, but at the same time mark the data structure we
> define as unused so gcc can drop the structure as well as the function
> if they are not referenced from anywhere else.  This should let us
> get away with fewer #ifdef hacks in the code, better build-time coverage
> but without producing larger object code.

So GCC is supposed to be smart enough to figure this out and users need
to not do the ifdefs?  I have to say this does seem a bit surprising
from a user point of view but it does make sense from a general niceness
point of view.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/b570317d/attachment.sig>
