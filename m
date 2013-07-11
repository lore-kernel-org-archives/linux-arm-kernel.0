From: dsd@laptop.org (Daniel Drake)
Date: Thu, 11 Jul 2013 13:59:50 -0600
Subject: Armada 510 display controller
Message-ID: <CAMLZHHRNjbQy7zfw=bD1kC+pKh946rOBWKyFOyhzyoLkdkE0PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We seem to have reached an initial conclusion from the "Best practice
device tree design for display subsystems/DRM". Thanks for the
discussion. I am trying to come up with a binding + implementation.

I am a bit stuck though, because I don't fully understand what the
DCON on the Armada 510 does.

In that thread, the ascii art suggests that it receives the output
from the two LCD controllers. From there it can send the image to a
VGA output or a parallel bus (where the HDMI encoder lies). Does it
let you choose which LCD controller input goes to which output? Can
you clone one input onto both outputs?

If it plays such an integral role in the "get an image from Cubox onto
my TV" path, as suggested in the diagram, why can't I see any code in
the armada_drm driver that configures it?


We also have a naming conflict that might be annoying. The MMP2 and
MMP3 can effectively drive 3 different video outputs (2 panels + 1
HDMI), but the documentation and register layout does not treat it as
3 different devices. Rather it is just 1 device, annoyingly named
"display controller". Comparing MMP to Armada 510, the MMP "display
controller" seems to act like the 510's LCD controllers and display
controller combined, i.e. it coordinates both the reading of image
data from memory *and* sending it to a configurable selection of
output devices.

That might produce a challenge for writing good documentation that
covers all the target hardware. That will become apparent once I'm
clearer on what the Armada 510 DCON is and how to document it's
possible involvement in the DT. If necessary, maybe we could refer to
the Armada 510 DCON as "output controller" or "output selector" or
something like that, to avoid the name conflict.

Thanks
Daniel
