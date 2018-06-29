From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 29 Jun 2018 21:23:51 +0200
Subject: [PATCH v3 17/24] drm/sun4i: Don't change clock bits in DW HDMI
 PHY driver
In-Reply-To: <CAGb2v66Ew7bshwiObQsbep9CCNeVeQFzunYrDcQsw+F+7rffHQ@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-18-jernej.skrabec@siol.net>
 <CAGb2v66Ew7bshwiObQsbep9CCNeVeQFzunYrDcQsw+F+7rffHQ@mail.gmail.com>
Message-ID: <5733268.4vEHGKJsVO@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 28. junij 2018 ob 04:24:02 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > DW HDMI PHY driver and PHY clock driver share same registers. Make sure
> > that DW HDMI PHY setup code doesn't change any clock related bits.
> > During initialization, set PHY PLL parent bit to 0.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> and maybe a fixes tag?

No need for fixes tag here. H3 and H5 HDMI PHYs have only one possible parent 
clock. Without this patch, 0 is always written in parent clock bit, which 
correctly selects first parent.

This is preparation patch for 2 clock parents support.

Best regards,
Jernej
