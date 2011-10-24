From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 24 Oct 2011 21:47:28 +0800
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <4EA52C56.3080908@ti.com>
References: <4EA00F7C.1080005@ti.com>
	<20111021082309.GA337@S2100-06.ap.freescale.net>
	<4EA13053.7080306@ti.com>
	<20111021115809.GB337@S2100-06.ap.freescale.net>
	<4EA4FF6B.2080906@ti.com>
	<20111024081706.GC8708@ponder.secretlab.ca>
	<20111024090228.GA1755@S2100-06.ap.freescale.net>
	<4EA52851.8000203@ti.com>
	<20111024091158.GB1755@S2100-06.ap.freescale.net>
	<4EA52C56.3080908@ti.com>
Message-ID: <20111024134727.GF1755@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 02:43:58PM +0530, Rajendra Nayak wrote:
> Case 2:
> One device for all regulators:
> 
> DT nodes look something like this
> 
> regulators {
> 	reg1: reg at 1 {
> 			...
> 			...
> 	};
> 
> 	reg2: reg at 2 {
> 			...
> 			...
> 	};
> };
> 
> The regulator driver probes only one device and the dev->of_node
> points to the "regulators" node above.

The mc13892 example I put in the reply to Grant demonstrates that
for some case, dev->of_node is NULL (devices are created by mfd core).

> The regulator driver then based on compatible property extracts
> and registers all the child nodes of "regulators" (for ex: reg1, reg2
> above) with each call to regulator_register and passes the child nodes
> as of_node to be associated with the regulator device.
> 
I still think the discovery of all the child nodes of "regulators" does
not necessarily need to be done in regulator driver.  Instead, it can
be done in regulator core.

-- 
Regards,
Shawn
