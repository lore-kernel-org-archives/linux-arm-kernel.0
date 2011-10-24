From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 24 Oct 2011 11:39:27 +0200
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111024092411.GE8708@ponder.secretlab.ca>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111018132032.GD30703@S2100-06.ap.freescale.net>
	<4E9EB61C.1040207@ti.com>
	<20111019144215.GA32007@S2100-06.ap.freescale.net>
	<4E9FAF42.5060200@ti.com>
	<20111020061408.GE32007@S2100-06.ap.freescale.net>
	<4EA00F7C.1080005@ti.com>
	<20111021082309.GA337@S2100-06.ap.freescale.net>
	<20111024092411.GE8708@ponder.secretlab.ca>
Message-ID: <20111024093925.GB6148@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 11:24:11AM +0200, Grant Likely wrote:

> To follow up from my earlier comment, this .dts structure looks fine
> and reasonable to me, and it would also be fine for the mc13892 driver
> to use for_each_child_of_node() to find all the children of the
> regulators node.  Even finding the 'regulators' node by name from the
> mc13892 driver is perfectly fine provided for_each_child_of_node is
> used to find it.  All of this is okay because it is under the umbrella
> of the "fsl,mc13892" binding.

Yes, a search of children of the device node that the driver is probing
off seems like a sensible approach.
