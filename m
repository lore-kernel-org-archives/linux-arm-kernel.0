From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Mar 2018 15:41:27 -0600
Subject: [PATCH v7 01/42] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <1519071723-31790-2-git-send-email-david@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-2-git-send-email-david@lechnology.com>
Message-ID: <20180301214127.7fk3p66w6ikfj6kk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 02:21:22PM -0600, David Lechner wrote:
> This adds a new binding for the PLL IP blocks in the mach-davinci
> family of processors. Currently, only da850 has device tree support
> but these bindings can also work for other SoCs in this family just
> by adding new compatible strings.
> 
> Note: Although these PLL controllers are very similar to the TI Keystone
> SoCs, we are not re-using those bindings. The Keystone bindings use a
> legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs
> have a slightly different PLL register layout and a number of quirks
> that can't be handled by the existing bindings, so the keystone bindings
> could not be used as-is anyway.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v7 changes:
> - None (there was some debate about having child nodes, but the consensus was
>   that this is "good enough" as it is)
> 
> v6 changes:
> - Added clock-names property
> - Added ti,clkmode-square-wave property
> - Added pllout child node
> - Added obsclk child node
> - Expanded examples
> 
> 
>  .../devicetree/bindings/clock/ti/davinci/pll.txt   | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt

Reviewed-by: Rob Herring <robh@kernel.org>
