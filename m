From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Mar 2013 22:50:01 +0800
Subject: [PATCH v2 11/11] ARM i.MX6q: Add LDB device to device tree
In-Reply-To: <1364464687.4018.31.camel@pizza.hi.pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-12-git-send-email-p.zabel@pengutronix.de>
 <20130328075148.GD2756@S2101-09.ap.freescale.net>
 <1364464687.4018.31.camel@pizza.hi.pengutronix.de>
Message-ID: <20130328144959.GC699@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 10:58:07AM +0100, Philipp Zabel wrote:
> The ldb node in imx6qdl.dtsi doesn't have the di[23]_sel clocks, because
> i.MX6dl doesn't have the second IPU.
> On i.MX6q, di[23]_sel should point to the ipu2_di0_sel and ipu2_di1_sel
> mux clocks. On i.MX6dl, di2_sel should point to lcdif_sel, eventually,
> and di3_sel shouldn't be given.
> 
Ah, sorry, I overlooked the difference.

> Should I remove the clocks from imx6qdl.dtsi altogether, to avoid
> confusion?
> 
Yea, I think it's less confusing to just have clocks and clock-names
defined in imx6q and imx6dl dts respectively.

> I originally intended to split the input multiplexer from the LDB
> driver, as we have the same for HDMI and MIPI on i.MX6 (minus the clock
> multiplexing requirements), because apart from that, the LDB blocks are
> identical. Shouldn't this be documented in the device tree?
> 
Ok, that's fine then.  I had the question because I saw imx6q compatible
already in the matching table.

Shawn
