From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 12 Jun 2015 09:27:07 +0200
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <20150609233618.GK7557@n2100.arm.linux.org.uk>
References: <4184159.j0iXe39dFB@phil> <3551826.dyCjorKhLA@diego>
 <20150609233618.GK7557@n2100.arm.linux.org.uk>
Message-ID: <4099644.agHN3RgGum@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 10. Juni 2015, 00:36:18 schrieb Russell King - ARM Linux:
> On Wed, Jun 10, 2015 at 01:29:43AM +0200, Heiko St?bner wrote:
> > Allthough from the discussion and explanations I've now also got the
> > "don't
> > make it worse" feeling, so am somehow reluctant to add supplies that also
> > might describe this inadequately.
> > 
> > The Rockchip-specific documentation only lists the two supplies as
> > AVDD_1V0, AVDD_1V8 with a description of "DC supply voltage for Analog
> > part of HDMI". The supplies aren't mentioned otherwise at all, so I guess
> > I'll ponder this a bit more at first.
> 
> Are they controllable from software at all?  If they aren't, then
> I'd suggest leaving them out until we have a distinction between
> the Tx and Phy - much as we do for iMX6.

they are supplied by the pmic the system uses (named vdd10_lcd and vdd18_lcd 
in the soc manuals/schematics)  and supply the individual output encoder 
analog parts (hdmi, edp, lvds, etc).  So if there is no output at all, they 
should be able to be turned off.
