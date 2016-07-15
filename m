From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 14 Jul 2016 20:58:19 -0400 (EDT)
Subject: [PATCH] usb: ehci-platform: use helper variables in probe function
In-Reply-To: <CACna6rzdhCjHvTJSC-TCag7eCMPso-tGRRu3ajhs5jc7A6r2gQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1607142054450.28629-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Jul 2016, Rafa? Mi?ecki wrote:

> > Okay except for...
> >
> >> -             priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
> >> -                             "phys", "#phy-cells");
> >> +             priv->num_phys = of_count_phandle_with_args(np, "phys",
> >> +                                                         "#phy-cells");
> >
> > Please indent continuation lines two tab stops beyond the original
> > line, to match the style in the rest of the source file.
> 
> I'm afraid this file doesn't have any consistent coding style for line breaks.
> 
> 1) dma_coerce_mask_and_coherent
> One extra tab after line break.
> 
> 2) devm_kcalloc
> Two extra tabs and 4 spaces. No real alignment noticed.
> 
> 3) devm_of_phy_get_by_index
> Two extra tabs
> 
> 4) devm_reset_control_get_shared_by_index
> Three extra tabs
> 
> With these pointed, do you still think I should use two extra tabs? If
> so, I'll send V2 as you suggested. Just let me know.

You're right, it's a mess.  If you send in an updated patch with two 
extra tabs, I'll create a style-only patch that fixes the other 
alignment issues.

Alan

PS: The probe routine in ohci-platform.c could use the same kind of 
local variables.  Would you like to send in patch for that routine too?
