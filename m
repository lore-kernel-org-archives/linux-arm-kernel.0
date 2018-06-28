From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Thu, 28 Jun 2018 06:45:56 +0200
Subject: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs if they don't have
 channel 0
In-Reply-To: <CAGb2v64EkVK+AEngEuadBzAZagyU7eyOhHhBh0iFrxS+-BbCYQ@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-10-jernej.skrabec@siol.net>
 <CAGb2v64EkVK+AEngEuadBzAZagyU7eyOhHhBh0iFrxS+-BbCYQ@mail.gmail.com>
Message-ID: <2676604.ZYCNkuCdbT@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 28. junij 2018 ob 03:51:31 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > TV TCONs (channel 1 only) are always connected to TV or HDMI encoder.
> > Because of that, all output endpoints on such TCON node will point to a
> > encoder which is part of component framework.
> > 
> > Correct current graph traversing algorithm in such way that it doesn't
> > skip output enpoints with id 0 on TV TCONs.
> 
> No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that don't
> have channel 0, it must be skipped.

I'm not sure where this is stated. I read TCON binding again. Can you please 
point me to it?

So on TV TCONs on R40 (without channel 0) TVE would be endpoint 1 and HDMI 
endpoint 2 (or the other way around)?

Best regards,
Jernej
