From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 15:18:50 +0100
Subject: [PATCH 04/11] MFD: twl4030-audio: Add DT support
In-Reply-To: <502274DA.9020204@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <20120808131356.GS16861@opensource.wolfsonmicro.com>
 <50226CF4.1010202@ti.com>
 <20120808135253.GC16861@opensource.wolfsonmicro.com>
 <502274DA.9020204@ti.com>
Message-ID: <20120808141849.GA24328@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 05:16:58PM +0300, Peter Ujfalusi wrote:
> On 08/08/2012 04:52 PM, Mark Brown wrote:

> > Is the point it's at in the sequence the end?

> On both ends :o
> On HS enable: the extmute has to be enabled, run the power on sequence for the
> HS, wait for ramp, disable the HS extmute.

> On stop: enable the extmute, run the sequence, wait for ramp, release the extmute.

I'm struggling to see any reason not to just hold the external mute on
for the entire time the headset is powered off?

> > We can always add a patch stubbing it out as part of the series, or in a
> > branch in the OF tree that we can pull in.

> If you are OK with the hassle I can add a patch to the series for
> include/linux/of.h to handle this.

Yes, please.
