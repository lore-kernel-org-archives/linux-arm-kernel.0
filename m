From: timur@freescale.com (Timur Tabi)
Date: Fri, 16 Mar 2012 16:31:20 -0500
Subject: [alsa-devel] [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
 <CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
 <20120316111814.GA7860@S2101-09.ap.freescale.net>
 <20120316192110.GH3158@opensource.wolfsonmicro.com>
 <CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
Message-ID: <4F63B128.7040705@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trent Piepho wrote:
> The ESAI and SSI hardware are totally different.  SSI gives you a
> playback and a record stream in an I2S, or I2S like, interface.  A
> stream is mono or stereo. ESAI has IIRC up to six output and four
> inputs streams.  Each stream is in parallel on the same clock, and can
> have one or more channels. 

Are these channels on the same wire in a time-division multiplexing, or on
six different wires?  If it's a TDM, then the SSI can actually do this
using "network mode", but I don't enable that in the driver, since it's
not really I2S compliant.

Well, this point is not really relevant to the discussion.

-- 
Timur Tabi
Linux kernel developer at Freescale
