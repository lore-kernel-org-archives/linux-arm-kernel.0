From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 9 May 2016 11:34:38 +0300
Subject: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
In-Reply-To: <a6969765-d07d-6d0e-36df-b78b485d9644@ti.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
 <20160504172634.GS5995@atomide.com> <572A38FD.9050801@ti.com>
 <20160505184609.GB5995@atomide.com>
 <a6969765-d07d-6d0e-36df-b78b485d9644@ti.com>
Message-ID: <57304B9E.50201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/05/16 11:25, Peter Ujfalusi wrote:

> Tomi: what do you think?
> 
> According to the OMAP5 data manual the vdda_hdmi can be in 1.5V or 1.8V mode,
> 2V is not mentioned in the recommended operating conditions table.

I thought vdda_hdmi should always be 1.8V, but you're right, on omap5
1.5V is allowed according to DM. On later SoCs it's only 1.8V. I suggest
we use 1.8V on all boards, as that's what's known to work.

2V is definitely wrong.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160509/d962752c/attachment-0001.sig>
