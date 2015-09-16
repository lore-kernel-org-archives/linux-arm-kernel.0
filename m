From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Sep 2015 16:57:28 -0700
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Update Phy supplies
In-Reply-To: <55F98690.6070601@ti.com>
References: <1441308226-26690-1-git-send-email-nm@ti.com>
 <55F98690.6070601@ti.com>
Message-ID: <20150916235727.GC4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150916 08:15]:
> Hi Tony,
> 
> On 09/03/2015 02:23 PM, Nishanth Menon wrote:
> > Originally, all the SoC PHY rails were supplied by LDO3. However, as a
> > result of characterization, it was determined that this posed a risk in
> > extreme load  conditions. Hence the PHY rails are split between two
> > different LDOs. Update the related node as a result
> > 
> > LDO3/VDDA_1V8_PHYA supplies vdda_usb1, vdda_usb2, vdda_sata, vdda_usb3
> > LDO4/VDDA_1V8_PHYB supplies vdda_pcie1, vdda_pcie0, vdda_hdmi, vdda_pcie
> > 
> > NOTE: We break compatibility with pre-production boards with this change
> > since, the PMIC LDO4 is disabled at OTP level.
> > 
> > The new configuration is the plan of record and all pre-production
> > boards are supposed to be replaced with the latest boards matching the
> > mentioned configuration.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> 
> Gentle ping. Some very few 10 something boards have been created and
> stopped production till the latest modifications were done (PMIC USB
> interrupt, LDO4 etc) - and all of those boards are now getting
> scrapped.. If there are any (as per tracking information, there should
> not be any), TI should be contacted to have them replaced.

Sounds OK to me as they are TI internal protos.
 
> Is it possible for us to consider this patch in 4.3 cycle - given that
> we are this close, might have been great to see 4.3 vanilla function on
> the production platform.

Applying into omap-for-v4.3/fixes thanks.

Tony
