From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 May 2012 21:07:00 +0100
Subject: Handling of modular boards
In-Reply-To: <201205041934.08830.arnd@arndb.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
Message-ID: <20120504200659.GQ14230@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 07:34:08PM +0000, Arnd Bergmann wrote:

> One idea that I've heard before is to put device tree fragments into the
> kernel and dynamically add them to the device tree that was passed by the
> boot loader whenever we detect the presence of a specific device.
> This obviously means it works only for boards using DT for booting, but
> it allows us to use some infrastructure that we already have.

I think anything that relies on bootloaders (or DT for that matter) is a
bit of a non-starter for my personal use cases.  Even where we're using
DT relying on a sane bootloader seems a bit scary - my personal use
cases would rely on updating this stuff in the field for non-technical
users who would have trouble recovering from issues.

> An intermediate solution that I really like is the ability to
> stuff device tree fragments on extension board themselves, but that
> can only work for new designs and causes problems when that information
> is not actually correct.

I can see the theory, but I can also see some practical concerns.  And
with the boards I'm working with we currently have 8 bits of data so...
