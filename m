From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 5 Jan 2015 16:34:37 +0100
Subject: [PATCH] Revert 9fc2105aeaaf56b0cf75296a84702d0f9e64437b to fix
 pyaudio (and probably more)
In-Reply-To: <20150105121126.GA10116@arm.com>
References: <alpine.LFD.2.11.1501041438130.18844@knanqh.ubzr>
 <20150104201026.GA23427@amd>
 <alpine.LFD.2.11.1501041512440.18844@knanqh.ubzr>
 <20150104203724.GA16372@amd>
 <alpine.LFD.2.11.1501041547050.18844@knanqh.ubzr>
 <CA+55aFy5yB2d-1iXEUtU+puua4TAmV0kZF_7TBhXO1Y4Khqb9Q@mail.gmail.com>
 <alpine.LFD.2.11.1501041609290.18844@knanqh.ubzr>
 <20150104212659.GC12302@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501042343240.18844@knanqh.ubzr>
 <20150105121126.GA10116@arm.com>
Message-ID: <20150105153437.GB3433@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2015-01-05 12:11:36, Will Deacon wrote:
> Hi all,
> 
> Sorry for the late reply, it seems that neither myself or the
> arm-linux-kernel list were on CC for this thread.

Sorry about that. I was pretty sure I cc-ed you, but apparently did
not.

> Pavel: do you have something we can run to observe the problem?

Debian 7.7: mpg123, anything pyaudio based, at least. (install
python-pyaudio, try to run examples).

I hit it with:

#!/usr/bin/env python
# Written by Yu-Jie Lin
# Public Domain
#
# Deps: PyAudio, NumPy, and Matplotlib
# Blog:
# http://blog.yjl.im/2012/11/frequency-spectrum-of-sound-using.html

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import pyaudio
import struct
import wave
...

When I decided to investigate.

> Finally, the revert doesn't have a Cc stable tag which is probably needed
> if it's going to land in 3.19 final, irrespective of whether we agree that
> it's the right way forward.

Yes, pushing is to stable is good idea. Will you take care?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
