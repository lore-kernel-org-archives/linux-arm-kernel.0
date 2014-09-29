From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Sep 2014 10:29:05 +0200
Subject: [PATCH v6 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
In-Reply-To: <5425CC6F.2020309@kapsi.fi>
References: <1411724593-4037-1-git-send-email-cyndis@kapsi.fi>
 <1411724593-4037-5-git-send-email-cyndis@kapsi.fi>
 <20140926114533.GN31106@ulmo> <5425CC6F.2020309@kapsi.fi>
Message-ID: <20140929082904.GF12506@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 11:28:31PM +0300, Mikko Perttunen wrote:
> On 09/26/2014 02:45 PM, Thierry Reding wrote:
[...]
> > I think a more idiomatic way to write this would be:
> >
> > static int
> > calculate_tsensor_calibration(const struct tegra_tsensor *sensor,
> > 			      struct tsensor_shared_calibration shared,
> > 			      u32 *calib)
> 
> If I do that, it will go over the 80 character limit by quite a few
> characters, which is why I didn't use that style. Personally I'm fine with
> either style.

The above doesn't exceed the 80 character limit. Putting the return
value and the static keyword on a separate line is a pretty common way
to reduce line length.

> >
> >While at it, perhaps make shared a const * instead of passing it in by
> >value?
> 
> That is possible, but I'm not sure what the difference would be. Is there a
> style rule forbidding by-value compound types? (Also if I change the style,
> it would go over 80 characters by even more.)

No it doesn't. The below fits within 80 characters per line just fine:

static int
calculate_tsensor_calibration(const struct tegra_tsensor *sensor,
			      const struct tsensor_shared_calibration *shared,
			      u32 *calib)

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/328dffc3/attachment.sig>
