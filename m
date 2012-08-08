From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 15:49:34 +0100
Subject: [PATCH 04/11] MFD: twl4030-audio: Add DT support
In-Reply-To: <50227837.10400@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <20120808131356.GS16861@opensource.wolfsonmicro.com>
 <50226CF4.1010202@ti.com>
 <20120808135253.GC16861@opensource.wolfsonmicro.com>
 <502274DA.9020204@ti.com>
 <20120808141849.GA24328@opensource.wolfsonmicro.com>
 <50227837.10400@ti.com>
Message-ID: <20120808144933.GC24328@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 05:31:19PM +0300, Peter Ujfalusi wrote:
> On 08/08/2012 05:18 PM, Mark Brown wrote:

> > I'm struggling to see any reason not to just hold the external mute on
> > for the entire time the headset is powered off?

> I think because it would mean in most cases that we keep a GPIO line enabled
> during the time the HS is not in use, which burns power.
> In most cases the mute is enabled when the GPIO line is up.

That makes sense if the GPIO is actively driven, open drain should be
better here, but it's still a generic thing which it'd be nice to
extract.

Still, the main thing here was the fact that we should be able to drop
the flag for the feature in the first place.
