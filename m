From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 13 May 2014 10:53:35 -0400 (EDT)
Subject: [PATCH v4 0/8] Add Allwinner A31 USB support
In-Reply-To: <1399969145-11642-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <Pine.LNX.4.44L0.1405131053050.1098-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 May 2014, Maxime Ripard wrote:

> Hi everyone,
> 
> This patchset adds support for the USB controllers found in the
> Allwinner A31.
> 
> While the design is similar to the earlier Allwinner SoCs that are
> already supported, a few details here and there change, like the fact
> that the PHYs now have one clock per phy, while it used to be only one
> for all the PHYs.
> 
> Thanks,
> Maxime
> 
> Changes from v3:
>   - Asserted back the ECHI/OHCI in reset if probe fails
>   - Drop of the redundant NULL assignent for the PMU in the PHY rework
> 
> Changes from v2:
>   - Fixed indentation and used the reset framework in all case and not
>     just in DT case
>   - Added a default value to the dedicated_clocks variable. Setting it
>     actually started triggering a gcc warning for no reason. Ended up
>     reworking a bit the code to avoid it.
> 
> Changes from v1:
>   - Moved the reset assertion/deassertion to probe/remove
>   - Moved the dedicated_clocks to the probe function instead of the
>     private structure since it was the only user
> 
> Boris BREZILLON (2):
>   usb: ehci-platform: add optional reset controller retrieval
>   ARM: sunxi: dt: add APP4-EVB1 board support
> 
> Maxime Ripard (6):
>   clk: sunxi: Implement A31 USB clock
>   ARM: sun6i: Add the USB clocks to the DTSI
>   phy: sunxi: Rework phy initialization
>   phy: usb: sunxi: Introduce Allwinner A31 USB PHY support
>   usb: ohci-platform: Enable optional use of reset controller
>   ARM: sun6i: dt: Add support for the USB controllers

For the changes to ehci-platform and ohci-platform:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
