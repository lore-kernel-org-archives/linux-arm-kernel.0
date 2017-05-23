From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 10:22:33 -0500
Subject: [PATCH 4/7] clk: mvebu: cp110: introduce a new binding
In-Reply-To: <a9ba62b9d6432af430e2f9cf7212c3ba8e1c5f03.1495208533.git-series.gregory.clement@free-electrons.com>
References: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
 <a9ba62b9d6432af430e2f9cf7212c3ba8e1c5f03.1495208533.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170523152233.5jxya2rgluric2pd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 05:55:22PM +0200, Gregory CLEMENT wrote:
> The initial intent when the binding of the cp110 system controller was to
> have one flat node. The idea being that what is currently a clock-only
> driver in drivers would become a MFD driver, exposing the clock, GPIO and
> pinctrl functionality. However, after taking a step back, this would lead
> to a messy binding. Indeed, a single node would be a GPIO controller,
> clock controller, pinmux controller, and more.
> 
> This patch adopts a more classical solution of a top-level syscon node
> with sub-nodes for the individual devices. The main benefit will be to
> have each functional block associated to its own sub-node where we can
> put its own properties.
> 
> The introduction of the Armada 7K/8K is still in the early stage so the
> plan is to remove the old binding. However, we don't want to break the
> device tree compatibility for the few devices already in the field. For
> this we still keep the support of the legacy compatible string with a big
> warning in the kernel about updating the device tree.

Good.

> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt | 18 ++++++++++++++----
>  drivers/clk/mvebu/cp110-system-controller.c                                | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
>  2 files changed, 62 insertions(+), 19 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
