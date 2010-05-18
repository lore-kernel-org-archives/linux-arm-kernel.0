From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 18 May 2010 16:45:27 +1200
Subject: [RFC PATCH 0/3] ep93xx i2s audio
Message-ID: <4BF21B67.8090404@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The following patch series adds support for i2s audio on the ep93xx,
with the Snapper CL15 used as an example implementation. The driver is
basically working, but still incomplete and needs some tidy up before it
will be accepted for mainline. I am posting the patches to get feedback
from others as to how well it works on their boards and ideas to improve
the code.

The following issues still exist:
 - The setting of SDIV/LRDIV is ugly since it requires modifying one of
the clock registers from the audio driver.
 - Audio capture has not been tested
 - Sometimes playback (ie aplay) results in noise. Killing the process
and trying again will result in correct playback.
 - Some empty functions can probably be removed
 - Not sure if I2SONSSP/AC97 should be a function argument, or a Kconfig
option (opinions please).

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
