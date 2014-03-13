From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 13 Mar 2014 19:44:48 -0400
Subject: [PATCH v3 0/6] Armada 380 NAND support
In-Reply-To: <1394742273-5113-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394742273-5113-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140313234448.GB15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 05:24:27PM -0300, Ezequiel Garcia wrote:
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
> Changes from v2:
> 
>   * Removed the unneeded 'nand' label from the flash at d0000 node.
> 
>   * Renamed 'coredivclk at e4250' to 'clock at e4250' according to
>     ePAPR recomendation, below.
> 
> Changes from v1:
> 
>   * Changed nand at d0000 with flash at d0000 in the devicetree. The
>     latter is compliant with ePAPR recomendation (see ePAPR v1.1,
>     section 2.2.2, Generic Names Recommendation).
> 
> Ezequiel Garcia (6):
>   clk: mvebu: Support Armada 380 SoC on the core divider clock

Applied to mvebu/clk-3xx

>   ARM: mvebu: Add a 2 GHz fixed-clock on Armada 38x SoCs
>   ARM: mvebu: Add the Core Divider clock to Armada 38x SoCs
>   ARM: mvebu: Add support for NAND controller in Armada 38x SoC
>   ARM: mvebu: Enable NAND controller in Armada 385-DB

Applied to mvebu/dt

>   clk: mvebu: Update binding documentation for the core divider clock

Applied to mvebu/clk-3xx

I'll push for-next with tonight's additions in an hour or so.

thx,

Jason.
