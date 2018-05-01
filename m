From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 08:39:06 -0500
Subject: [PATCH 09/16] bus: ti-sysc: Add handling for clkctrl opt clocks
In-Reply-To: <20180423174549.57412-10-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
 <20180423174549.57412-10-tony@atomide.com>
Message-ID: <20180501133906.GA18650@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 10:45:42AM -0700, Tony Lindgren wrote:
> There can be up to eight optional device functional gate gate clocks for
> each clkctrl instance in clkctrl register bits 8 to 15. Some of them are
> only needed for module level reset while others may always be needed
> during use. Let's add support for those and update the binding doc
> accordingly.
> 
> Note that the optional clkctrl mux and divider clocks starting at bit 20
> can be directly mapped to the child devices, and ti-sysc does not need to
> manage those.
> 
> And as GPIOs need the optional clocks for reset, we can now add it with
> SYSC_QUIRK_OPT_CLKS_IN_RESET.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/bus/ti-sysc.txt       |   6 +-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/bus/ti-sysc.c                         | 140 ++++++++++++++----
>  2 files changed, 120 insertions(+), 26 deletions(-)
