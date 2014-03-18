From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 18 Mar 2014 13:43:05 +0100
Subject: [PATCH 6/9] Doc/DT: Add DT binding documentation for MIPI DSI CM
 Panel
In-Reply-To: <5327E8D3.5010907@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <4670830.fkS1noPxcd@avalon> <5327E8D3.5010907@ti.com>
Message-ID: <3793066.CEaE5qMjRq@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

On Tuesday 18 March 2014 08:33:55 Tomi Valkeinen wrote:
> On 17/03/14 16:22, Laurent Pinchart wrote:
> >> +Example
> >> +-------
> >> +
> >> +lcd0: display {
> >> +	compatible = "tpo,taal", "panel-dsi-cm";
> >> +	label = "lcd0";
> >> +
> >> +	gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102, reset */
> > 
> > If the panel uses a TE GPIO but no reset GPIO, do you plan to express this
> > with a "hole" for the reset GPIO ? e.g. something like
> > 
> > 	gpios = <0>, <&gpio4 6 GPIO_ACTIVE_HIGH>;
> 
> Yes.
> 
> > Wouldn't it be better to split the gpios property into "reset-gpios" and
> > "te- gpios" ?
> 
> Yes, I can change it. I don't have a strong preference.
> 
> I've gotten similar comments for other bindings also, so I guess the
> preferred way is to use named "-gpios" properties for everything except
> the case where you really have multiple gpios with the same purpose?

That's my understanding, yes.

> The gpio binding documentation doesn't give much guidance on this.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/7f542994/attachment.sig>
