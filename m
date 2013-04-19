From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 10:13:19 -0700
Subject: Multiple issues with omap4 panda es in linux next
Message-ID: <20130419171318.GK10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's a list of breakage I've noticed so far while trying to
use linux next on my pandaboard es. Probably similar issues exist
on other boards as well.

Ideally we would not have any breakage by the merge window, so
let's try to get these fixed ASAP:

1. Serial console broken on panda es booting with DT

The symptoms are dmesg output stopping after few lines
and only continuing after pressing a key. Does not seem to
happen on blaze with DT for some reason. And does not happen
on panda es with legacy booting.

2. MUSB fails with legacy booting and DT on panda es

With both legacy and DT booting I get something like:

HS USB OTG: no transceiver configured
musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517

3. DSS fails with DT booting

Works with legacy booting but fails with DT. I'm almost certain
the DT booting was working last week or so?

This is what I now get with DT booting:

omapdss DSI error: can't get VDDS_DSI regulator
omapdss HDMI error: can't get VDDA_HDMI_DAC regulator
omapdss HDMI error: device hdmi init failed: -517
omapdss CORE error: driver probe failed: -22
...

4. WLAN with wl12xx fails with both legacy and DT booting

No real output here with the legacy mode, just the usual
using pinctrl dummy state warning.

Regards,

Tony
