From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 15:35:59 -0800
Subject: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF
 and DDR
In-Reply-To: <4EEFC23A.30201@gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
 <4EEFC23A.30201@gmail.com>
Message-ID: <20111219233559.GW6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [111219 14:29]:
> On 12/19/2011 08:05 AM, Aneesh V wrote:
> > This is an RFC to add new device tree bindings for DDR memories and
> > EMIF - TI's DDR SDRAM controller. 
> > 
> > The first patch adds bindings for DDR memories. Currently,
> > we have added properties for only DDR3 and LPDDR2 memories.
> > However, the binding can be easily extended to describe
> > other types such as DDR2 in the future.
> > 
> > The second patch provides the bindings for the EMIF controller.
> > 
> > The final patch provides DT data for EMIF controller instances
> > in OMAP4 and LPDDR2 memories attached to them on various boards.
> > 
> > Thanks to Rajendra for answering my numerous queries on device tree.
> > 
> > This is a re-post of the RFC that was posted to devicetree-discuss ml,
> > now sent to a larger audience and looping out an internal list.
> > Please ignore the previous version.
> 
> There's already a standard way (i.e. JEDEC standard) to define DDR chip
> configuration that's called SPD. Why invent something new? While this is
> normally an i2c eeprom on a DIMM, there's no reason you couldn't get it
> from somewhere else including perhaps the DT. There's already code in
> u-boot that can parse SPD data.

I agree generic JEDEC standard would be good for the DT.
 
> In general, is it really feasible to parse the DTB before DDR is
> initialized?

Changing timings is still needed for DVFS during runtime.

But we can boot to userspace with bootloader set timings, so I'm
thinking that maybe these timings should be just set by loadable
modules. Just the configuration of which timings to select should
be passed via DT. Something in compatible like:

	.compatible = "ti,omap3630", "sdram-micron-mt46h32m32lf-6";

And that should allow the SDRC driver to only accept timings for
"sdram-micron-mt46h32m32lf-6".

Regards,

Tony
