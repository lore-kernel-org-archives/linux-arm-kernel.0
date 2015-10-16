From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 16 Oct 2015 15:08:39 +0200
Subject: [RFC 1/2] Dcumentation: bridge: Add documentation for ps8640 DT
 properties
In-Reply-To: <1444997709-57293-1-git-send-email-ck.hu@mediatek.com>
References: <1444997709-57293-1-git-send-email-ck.hu@mediatek.com>
Message-ID: <1445000919.3541.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

there is a typo in the subject: s/Dcumentation/Documentation/.

Am Freitag, den 16.10.2015, 20:15 +0800 schrieb CK Hu:
> From: Jitao Shi <jitao.shi@mediatek.com>
> 
> Add documentation for DT properties supported by ps8640
> DSI-eDP converter.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
[...]
> +	- ps8640-1v2-supply: OF device-tree regulator specification for 1v2.
> +	- ps8640-3v3-supply: OF device-tree regulator specification for 3v3.

The ps8640- part of the regulator supply property names is redundant.
The PS8622 driver uses vdd12-supply as its regulator. Should we strive
for consistency here? Or if you have access to the datasheet, how are
these inputs called there?

> +
> +Optional properties:
> +	- video interfaces: Device node can contain video interface port
> +			    nodes for panel according to [1].
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt

It should be documented here that port at 0 is the input port and port at 1 is
the output port.

best regards
Philipp
