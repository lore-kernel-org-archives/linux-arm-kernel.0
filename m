From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 May 2018 11:11:02 -0700
Subject: [PATCH] arm: dts: omap: fix OF graph in omap3-devkit8000
In-Reply-To: <20180508135930.5768-5-robh@kernel.org>
References: <20180508135930.5768-1-robh@kernel.org>
 <20180508135930.5768-5-robh@kernel.org>
Message-ID: <20180515181102.GT98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [180508 07:01]:
> omap3-devkit8000-common.dtsi defines a graph connection for DVI, but
> then omap3-devkit8000-lcd-common.dtsi overrides that with a graph
> connection for the LCD as the same output signals are used. This
> leaves an incomplete graph as the TFP410 output has only half a
> connection. The result is the following warning:
> 
> arch/arm/boot/dts/omap3-devkit8000-lcd70.dtb: Warning (graph_endpoint): /encoder0/ports/port at 0/endpoint: graph connection to node '/ocp at 68000000/dss at 48050000/port/endpoint' is not bidirectional
> 
> Fix this by defining multiple endpoints which is the correct way to show
> a 1 to many connection.

Applying into omap-for-v4.18/dt-fixes thanks.

Tony
