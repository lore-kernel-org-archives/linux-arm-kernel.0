From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:14:35 +0200
Subject: [PATCH 1/3] dt-bindings: change the A64 HDMI PHY binding to R40
In-Reply-To: <20180903133434.58188-2-icenowy@aosc.io>
References: <20180903133434.58188-1-icenowy@aosc.io>
 <20180903133434.58188-2-icenowy@aosc.io>
Message-ID: <20180905071435.lgsogpzmh5nw6bcy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 09:34:32PM +0800, Icenowy Zheng wrote:
> By experiment, the A64 HDMi PHY doesn't support the PLL-VIDEO mux
> introduced in R40, although it has two PLL-VIDEOs.
> 
> Change the A64 HDMI PHY binding to R40 one.
> 
> This binding is introduced in v4.19, which is still in RC stage, so we
> have change to fix it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

That doesn't make much sense. The A64 doesn't have any particular
reason to behave like the R40, and the R40 can definitely use a
different compatible if it has a different behaviour. But I don't see
*why* the A64 not behaving like the R40 is a justification to remove
the A64 compatible. Especially when the R40 was released later.

Add a new compatible, and leave the A64 compatible alone.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/6d3bed30/attachment.sig>
