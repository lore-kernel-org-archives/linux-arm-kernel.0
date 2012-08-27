From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 27 Aug 2012 14:01:00 +0000
Subject: [PATCH v6 00/10] OMAP-GPMC: generic time calc, prepare for driver
In-Reply-To: <503B7678.90308@gmail.com>
References: <cover.1345524670.git.afzal@ti.com> <503B6511.4050909@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA713@DBDE01.ent.ti.com>
 <503B7678.90308@gmail.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9BA7DA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Mon, Aug 27, 2012 at 19:00:32, Daniel Mack wrote:

> So the GPMC driver is the one that is matched from DT, and the NAND
> driver will the be instanciated from the (generic) GPMC driver?

I think you were referring to nand device being instantiated from
gpmc driver?, hence resulting in nand driver getting probed. What I
have in mind is to represent peripherals connected to gpmc as childs
of gpmc node. For devices like smsc911x, as they already have DT
bindings, creating an of device for childs by parsing DT hopefully
should relieve task of handling their platform data.

Similarly for nand, creating an of device is to be done by gpmc
driver.

Once the bigger issue of timing is resolved, I am planning to
implement DT as said above

Also for the existing boards on non-DT boot, plan is to keep the
existing interface as such, with no change needed in board files.

> 
> > No change would be needed for client drivers like smc91x ethernet drivers,
> > but NAND driver may need some change to live with DT as it is tightly
> > coupled with GPMC.
> 
> NAND drivers also typically parse partition entries that are children of
> the DT node the are owning.

Yes, in addition to the above, omap nand driver would need to determine a
few gpmc specific like transfer mode.

> I do have a beaglboard xM, but the board I'm currently working with is a
> custom one based on an AM33xx.

I was in need of a board like rx51, n800 that currently calculate gpmc
timings at runtime to test the generic timing function, np, thanks again

Regards
Afzal
