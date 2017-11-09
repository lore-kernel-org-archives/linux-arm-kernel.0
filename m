From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 09 Nov 2017 08:35:10 +0200
Subject: [PATCH 1/4] omapdrm: fix compatible string for td028ttec1
In-Reply-To: <C999B55A-771D-44AF-8072-2F30FE6B54B7@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
 <2790033.EQlQQc1BPI@avalon>
 <C999B55A-771D-44AF-8072-2F30FE6B54B7@goldelico.com>
Message-ID: <2337862.ufPI2HCsv4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolaus,

On Thursday, 9 November 2017 08:05:15 EET H. Nikolaus Schaller wrote:
> > Am 09.11.2017 um 04:33 schrieb Laurent Pinchart:
> > On Wednesday, 8 November 2017 23:09:29 EET H. Nikolaus Schaller wrote:
> >> The vendor name was "toppoly" but other panels and the vendor list
> >> have defined it as "tpo". So let's fix it in driver and bindings.
> >> 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >> .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} | 4 ++--
> >> drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c           | 4
> >> ++--
> >> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c  | 4
> >> ++--
> >> 3 files changed, 6 insertions(+), 6 deletions(-)
> >> rename
> >> Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt
> >> =>
> >> tpo,td028ttec1.txt} (84%)
> >> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
> >> b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> >> similarity index 84%
> >> rename from
> >> Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
> >> rename to
> >> Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt index
> >> 7175dc3740ac..ed34253d9fb1 100644
> >> ---
> >> a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
> >> +++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> >> @@ -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
> >> ========================
> >> 
> >> Required properties:
> >> -- compatible: "toppoly,td028ttec1"
> >> +- compatible: "tpo,td028ttec1"
> >> 
> >> Optional properties:
> >> - label: a symbolic name for the panel
> >> @@ -14,7 +14,7 @@ Example
> >> -------
> >> 
> >> lcd-panel: td028ttec1 at 0 {
> >> -	compatible = "toppoly,td028ttec1";
> >> +	compatible = "tpo,td028ttec1";
> >> 
> >> 	reg = <0>;
> >> 	spi-max-frequency = <100000>;
> >> 	spi-cpol;
> >> 
> >> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> >> b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c index
> >> 0a38a0e8c925..2dab491478c2 100644
> >> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> >> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> >> @@ -452,7 +452,7 @@ static int td028ttec1_panel_remove(struct spi_device
> >> *spi)
> >> }
> >> 
> >> static const struct of_device_id td028ttec1_of_match[] = {
> >> -	{ .compatible = "omapdss,toppoly,td028ttec1", },
> >> +	{ .compatible = "omapdss,tpo,td028ttec1", },
> > 
> > Doesn't this break backward compatibility with existing DT ?
> 
> Yes, it does. But I am only aware of the GTA04 which uses it and
> there is a separate fix).

DT is supposed to be an ABI. In theory at least, one could boot a GTA04 with 
an existing DT and a new kernel, and no regression should be noticed. There 
could also be other devices using this panel that you are not aware of.

For how to apply the theory to real life, I'll defer to Tomi :-)

> >> 	{},
> >> };

[snip]

-- 
Regards,

Laurent Pinchart
