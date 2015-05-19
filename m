From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 15:58:51 +0800
Subject: [PATCH 1/9] ARM: imx: move timer resources into a structure
In-Reply-To: <5559C23E.5070100@linaro.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
 <1431677507-27420-2-git-send-email-shawnguo@kernel.org>
 <5559C23E.5070100@linaro.org>
Message-ID: <20150519075851.GV1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 12:43:10PM +0200, Daniel Lezcano wrote:
> On 05/15/2015 10:11 AM, shawnguo at kernel.org wrote:
> >From: Shawn Guo <shawn.guo@linaro.org>
> >
> >Instead of passing around as argument, let's move timer resources like
> >irq and clocks together with base address into a data structure, and
> >reference the resources from the struct variable directly to simplify
> >the function call interface.
> >
> >Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I would be nice to embed the clockevent_mxc variable in the
> structure as well and use container_of to retrieve the structure
> from the struct clockevent.
> 
> The struct clockevent can be the unified parameter across the
> different functions.
> 
> Refer to drivers/clocksource/rockchip_timer.c as an example.

Okay, thanks for the example.  I will add a patch to do that.

Shawn
