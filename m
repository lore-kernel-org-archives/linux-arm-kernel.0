From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Dec 2011 17:01:14 -0600
Subject: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF
 and DDR
In-Reply-To: <1324303533-17458-1-git-send-email-aneesh@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Message-ID: <4EEFC23A.30201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2011 08:05 AM, Aneesh V wrote:
> This is an RFC to add new device tree bindings for DDR memories and
> EMIF - TI's DDR SDRAM controller. 
> 
> The first patch adds bindings for DDR memories. Currently,
> we have added properties for only DDR3 and LPDDR2 memories.
> However, the binding can be easily extended to describe
> other types such as DDR2 in the future.
> 
> The second patch provides the bindings for the EMIF controller.
> 
> The final patch provides DT data for EMIF controller instances
> in OMAP4 and LPDDR2 memories attached to them on various boards.
> 
> Thanks to Rajendra for answering my numerous queries on device tree.
> 
> This is a re-post of the RFC that was posted to devicetree-discuss ml,
> now sent to a larger audience and looping out an internal list.
> Please ignore the previous version.

There's already a standard way (i.e. JEDEC standard) to define DDR chip
configuration that's called SPD. Why invent something new? While this is
normally an i2c eeprom on a DIMM, there's no reason you couldn't get it
from somewhere else including perhaps the DT. There's already code in
u-boot that can parse SPD data.

In general, is it really feasible to parse the DTB before DDR is
initialized?

Rob
