From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Jan 2017 16:25:08 -0600
Subject: [PATCHv4 1/5] clk: mvebu: support for 98DX3236 SoC
In-Reply-To: <20170113091222.7132-2-chris.packham@alliedtelesis.co.nz>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-2-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170118222508.prn5xk63nuc3ocr7@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 10:12:16PM +1300, Chris Packham wrote:
> The 98DX3236, 98DX3336, 98DX4521 and variants have a different TCLK from
> the Armada XP (200MHz vs 250MHz). The CPU core clock is fixed at 800MHz.
> 
> The clock gating options are a subset of those on the Armada XP.
> 
> The core clock divider is different to the Armada XP also.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v2:
>     - Update devicetree binding documentation for new compatible string
>     Changes in v3:
>     - Add 98dx3236 support to mvebu/clk-corediv.c rather than creating a new
>       driver.
>     - Document mv98dx3236-corediv-clock binding
>     Changes in v4:
>     - None
> 
>  .../bindings/clock/mvebu-corediv-clock.txt         |  1 +
>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |  1 +

Please add acks when posting new versions.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/mvebu/armada-xp.c                      | 42 ++++++++++++++++++++++
>  drivers/clk/mvebu/clk-corediv.c                    | 23 ++++++++++++
>  drivers/clk/mvebu/clk-cpu.c                        | 31 ++++++++++++++--
>  5 files changed, 96 insertions(+), 2 deletions(-)
