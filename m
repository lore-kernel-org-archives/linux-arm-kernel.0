From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 9 Feb 2016 14:10:27 -0800
Subject: [PATCH 3/3] thermal: allow u8500-thermal driver to be a module
In-Reply-To: <20160127073300.GJ3368@x1>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
 <1453740264-1972562-4-git-send-email-arnd@arndb.de>
 <20160127073300.GJ3368@x1>
Message-ID: <20160209221026.GD28102@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 07:33:00AM +0000, Lee Jones wrote:
> On Mon, 25 Jan 2016, Arnd Bergmann wrote:
> 
> > When the thermal subsystem is a loadable module, the u8500 driver
> > fails to build:
> > 
> > drivers/thermal/built-in.o: In function `db8500_thermal_probe':
> > db8500_thermal.c:(.text+0x96c): undefined reference to `thermal_zone_device_register'
> > drivers/thermal/built-in.o: In function `db8500_thermal_work':
> > db8500_thermal.c:(.text+0xab4): undefined reference to `thermal_zone_device_update'
> > 
> > This changes the symbol to a tristate, so Kconfig can track the
> > dependency correctly.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/mfd/db8500-prcmu.c | 3 +++
> >  drivers/thermal/Kconfig    | 4 ++--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> As this touches a core Thermal file, I think it's better off going in
> via that tree.  If that's a problem, I can take it with the relevant
> Acks.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>


Thanks, I am adding to linux-next to see how it goes.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/3f8a8e06/attachment.sig>
