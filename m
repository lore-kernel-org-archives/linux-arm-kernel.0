From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 May 2018 11:11:27 -0700
Subject: [PATCH] arm: dts: omap: fix OMAP3 CM-T3x OF graph video connectors
In-Reply-To: <20180508135930.5768-6-robh@kernel.org>
References: <20180508135930.5768-1-robh@kernel.org>
 <20180508135930.5768-6-robh@kernel.org>
Message-ID: <20180515181127.GU98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [180508 07:01]:
> The OMAP3 CM-T3x based boards define 2 /connector nodes for S-Video and
> DVI output. However, since they have the same node name, the S-Video
> connector overwritten. This leaves a dangling graph connection which
> gives the following warning:
> 
> arch/arm/boot/dts/omap3-sbc-t3517.dtb: Warning (graph_endpoint): /ocp at 68000000/dss at 48050000/encoder at 48050c00/port/endpoint: graph connection to node '/connector/port/endpoint' is not bidirectional
> 
> Fix this by renaming the nodes to s-video-connector and dvi-connector.

Applying this too into omap-for-v4.18/dt-fixes.

Regards,

Tony
