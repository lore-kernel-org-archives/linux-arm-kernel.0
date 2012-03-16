From: tpiepho@gmail.com (Trent Piepho)
Date: Fri, 16 Mar 2012 17:45:09 -0400
Subject: [alsa-devel] [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <4F63B128.7040705@freescale.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
 <CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
 <20120316111814.GA7860@S2101-09.ap.freescale.net>
 <20120316192110.GH3158@opensource.wolfsonmicro.com>
 <CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
 <4F63B128.7040705@freescale.com>
Message-ID: <CA+7tXijxUpnoBfrjOEyBeLPF9T9qhBiy6B+8LPVnyNc99mYVQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 5:31 PM, Timur Tabi <timur@freescale.com> wrote:
> Trent Piepho wrote:
>> The ESAI and SSI hardware are totally different. ?SSI gives you a
>> playback and a record stream in an I2S, or I2S like, interface. ?A
>> stream is mono or stereo. ESAI has IIRC up to six output and four
>> inputs streams. ?Each stream is in parallel on the same clock, and can
>> have one or more channels.
>
> Are these channels on the same wire in a time-division multiplexing, or on
> six different wires? ?If it's a TDM, then the SSI can actually do this
> using "network mode", but I don't enable that in the driver, since it's
> not really I2S compliant.

Six different wires.  Each wire can have multiple channels, or
"slots", to do mono, stereo, 5.1, etc.  Each wire needs the same
number of slots, since there is only one frame sync.  And only one bit
clock too.  RX and TX can be synchronous or async.  I know it has
network mode too, but our hardware is I2S so I never bothered to look
into exactly what network mode is.
