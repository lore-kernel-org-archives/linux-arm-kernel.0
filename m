From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 13 Mar 2014 15:19:25 -0400
Subject: [PATCH 0/6] Armada 380 NAND support
In-Reply-To: <1394637404-7651-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394637404-7651-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140313191925.GE7811@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

On Wed, Mar 12, 2014 at 12:16:38PM -0300, Ezequiel Garcia wrote:
> This patchset adds support for the NAND on Armada 380/385 SoCs.
> 
> The first patch adds a new "armada-380-corediv-clock" compatible
> string, with its proper SoC-specific structure, adding the register
> layout for this SoC family.
> 
> The second and third patches add the devicetree changes to support
> the Core Divider clock.
> 
> After adding its clock source, the fourth and fifth patches add
> the NAND devicetree changes. The NAND controller is compatible with
> the Armada 370 controller, so we are currently support it using the
> same compatible string.
> 
> The last patch updates the binding documentation for the Core Divider
> clock, which is missing the information about the already supported
> Armada 375 compatible string.
> 
> This series is based on linux-next 20140307. I expect it will apply
> cleanly on v3.15-rc1; if that's not the case, I'll send a rebased patchset.
> 
> The clock and devicetree changes are mostly independent so they
> can be merged through the clock and mvebu tree respectively.
> 
> Ezequiel Garcia (6):
>   clk: mvebu: Support Armada 380 SoC on the core divider clock
>   ARM: mvebu: Add a 2 GHz fixed-clock on Armada 38x SoCs
>   ARM: mvebu: Add the Core Divider clock to Armada 38x SoCs
>   ARM: mvebu: Add support for NAND controller in Armada 38x SoC
>   ARM: mvebu: Enable NAND controller in Armada 385-DB
>   clk: mvebu: Update binding documentation for the core divider clock
> 
>  .../bindings/clock/mvebu-corediv-clock.txt         |  5 ++++-
>  arch/arm/boot/dts/armada-385-db.dts                | 21 ++++++++++++++++++
>  arch/arm/boot/dts/armada-38x.dtsi                  | 25 ++++++++++++++++++++++
>  drivers/clk/mvebu/clk-corediv.c                    | 23 ++++++++++++++++++++
>  4 files changed, 73 insertions(+), 1 deletion(-)

This clock changes looks really clean and simple.  Mike says he has time
for one more pull.  Can you fixup the s/nand/flash/ and resend?  I'd
like to pull this and your fix in and possibly send a pull request for
v3.15 tomorrow.

thx,

Jason.
