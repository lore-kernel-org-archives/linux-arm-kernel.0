From: briannorris@chromium.org (Brian Norris)
Date: Wed, 24 Jan 2018 10:09:00 -0800
Subject: [PATCH v3] drm/bridge/synopsys: dsi: add optional pixel clock
In-Reply-To: <507552a3-c68f-d6ac-a747-b8f5168d0d41@st.com>
References: <20180123170806.5282-1-philippe.cornu@st.com>
 <20180123204939.qirvr34mlwgiwmqz@ban.mtv.corp.google.com>
 <507552a3-c68f-d6ac-a747-b8f5168d0d41@st.com>
Message-ID: <20180124180859.mr736rpzysq5vn54@ban.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 09:24:06AM +0000, Philippe CORNU wrote:
> On 01/23/2018 09:49 PM, Brian Norris wrote:
> > On Tue, Jan 23, 2018 at 06:08:06PM +0100, Philippe Cornu wrote:
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c

> >> @@ -828,6 +833,14 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
> >>   		return ERR_PTR(ret);
> >>   	}
> >>   
> >> +	dsi->px_clk = devm_clk_get(dev, "px_clk");
> > 
> > Did you write a device tree binding document update for this anywhere?
> 
> Many thanks for your review,
> 
> yes, "px_clk" is already documented, please have a look to 
> Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt

Ah, I see. Normally I expect that the binding document is sent around
when the first user of it shows up, but I guess that's not a
requirement. Sorry I missed that!

Just a note: I don't think that Rockchip systems have an equivalent
clock from which to directly derive the pixel clock rate. I believe it's
controlled through additional dividers that are not part of the common
clock framework. So this isn't particularly useful for them.

I don't think it's worth very much in this case, but:

Reviewed-by: Brian Norris <briannorris@chromium.org>
