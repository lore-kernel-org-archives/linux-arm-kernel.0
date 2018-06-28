From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 10:08:51 +0800
Subject: [PATCH v3 11/24] drm/sun4i: Don't check for LVDS and RGB when
 TCON has only ch1
In-Reply-To: <20180625120304.7543-12-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-12-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64VJ2Mxq7jS=rtUNFwE6BccdDcHPN7MvG0dLHnKoMNJow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> LVDS and RGB interfaces are always connected to TCONs which have channel
> 0. It doesn't make sense to try to init them on TV TCONs.
>
> Add a check if TCON has channel 0 before trying to init LVDS or RGB
> interface.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Though I think at some point we could just have separate functions
to handle channel 0 and channel 1.

ChenYu
