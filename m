From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 09:51:31 +0800
Subject: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs if they don't have
 channel 0
In-Reply-To: <20180625120304.7543-10-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-10-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64EkVK+AEngEuadBzAZagyU7eyOhHhBh0iFrxS+-BbCYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> TV TCONs (channel 1 only) are always connected to TV or HDMI encoder.
> Because of that, all output endpoints on such TCON node will point to a
> encoder which is part of component framework.
>
> Correct current graph traversing algorithm in such way that it doesn't
> skip output enpoints with id 0 on TV TCONs.

No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that don't
have channel 0, it must be skipped.

ChenYu
