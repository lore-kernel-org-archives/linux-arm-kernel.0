From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 11 Mar 2014 08:43:18 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <1393604717.3802.61.camel@paszta.hi.pengutronix.de>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>	
 <20140228155937.GQ21483@n2100.arm.linux.org.uk>
 <1393604717.3802.61.camel@paszta.hi.pengutronix.de>
Message-ID: <531EB086.8040404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 18:25, Philipp Zabel wrote:

> dvi-connector {
> 	compatible = "dvi-connector";
> 	ddc-i2c-bus = <&i2c3>;
> 
> 	port {
> 		dvi_d_in: endpoint at 0 {
> 			remote-endpoint = <&sii902x_out>;
> 		};
> 		dvi_a_in: endpoint at 1 {
> 			remote-endpoint = <&tve_out>;
> 		};
> 	};
> };
> 
> It should be possible to let the connector know that those two endpoints
> are connected to a TMDS source and to a VGA source, respectively.

I have not worked with boards that would have the analog part, so just
wondering about the above.

The above would mean that either digital or analog is in use, but not
both. Was that the intention? From the connector's perspective, the
analog and digital pins are separate, and I think they can be used at
the same time. That kind of sounds like the analog and digital pins
should be represented as separate ports.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/22de5d0b/attachment.sig>
