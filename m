From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 20:03:19 +0800
Subject: [PATCH 1/2] ARM:MX28: Add additionnal muxing options to iMX28 DTSI
In-Reply-To: <4FE98414.4070903@free-electrons.com>
References: <1340356494-24664-1-git-send-email-maxime.ripard@free-electrons.com>
 <1340356494-24664-2-git-send-email-maxime.ripard@free-electrons.com>
 <20120625155047.GD2342@S2101-09.ap.freescale.net>
 <4FE98414.4070903@free-electrons.com>
Message-ID: <20120626120317.GE8858@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:42:44AM +0200, Maxime Ripard wrote:
> I have two questions here though.
> 
> First, I'm worrying a bit about the fact that the duart_pins_b is
> actually the first pin groups in the muxing selection register by index,
> before duart_pins_a. It's a bit confusing, but it would imply that we
> would need to rename duart_pins_a to duart_pins_b, and change all the
> references to it as well, but I can definitely send a patch for it. What
> is your opinion ?
> 
The numbering of mux options for a function is not meant to match the
register index in any case.  Actually, it's no way to match.  For
example, if pin pair <0x3102 0x3032> is used on one board, how would
you number it?  (Well, the example is odd but it's possible.)

> Secondly, why do we need to change the reg field as well ?
> 
We need to use the same node name "duart" for pin groups that are
mux-ed on duart function.  "reg" value is used to distinguish the node
name, as the "reg" value is required to be part of node name.

-- 
Regards,
Shawn
