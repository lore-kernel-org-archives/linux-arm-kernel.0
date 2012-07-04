From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 4 Jul 2012 15:27:45 +0100
Subject: How to handle parameter variation across different boards but
 same platform
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA35B10@DBDE01.ent.ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
 <20120704131749.GZ4111@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
 <20120704140118.GA4111@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EA35B10@DBDE01.ent.ti.com>
Message-ID: <20120704142745.GC4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 02:17:48PM +0000, Hebbar, Gururaja wrote:
> On Wed, Jul 04, 2012 at 19:31:18, Mark Brown wrote:

> > If these are totally different boards they should have different machine
> > IDs set so machine_is_() should identify.  If that isn't there then you
> > need to do something custom to your products to identify the boards
> > further.

> They are different boards with same SoC (AM33xx). So they both are true for
> machine_is_am33xx().

That's not how this stuff is supposed to work - machine is the board,
you should have cpu_is_() for identifying the SoC.

> We have a means to detect the type of board but in arch/arm/mach-omap2/ 
> board file. However, I believe it is not recommended to call boards api
> inside drivers.

Only for generic drivers, board specific drivers are obviously board
specific.  The point is that you shouldn't make something that could run
on many boards depend on an API specific to a particular board.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120704/1c0b65e9/attachment-0001.sig>
