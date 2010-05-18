From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 May 2010 19:22:03 +0100
Subject: [RFC PATCH 0/3] ep93xx i2s audio
In-Reply-To: <4BF21B67.8090404@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com>
Message-ID: <20100518182202.GB22554@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 04:45:27PM +1200, Ryan Mallon wrote:

> The following patch series adds support for i2s audio on the ep93xx,
> with the Snapper CL15 used as an example implementation. The driver is
> basically working, but still incomplete and needs some tidy up before it
> will be accepted for mainline. I am posting the patches to get feedback
> from others as to how well it works on their boards and ideas to improve
> the code.

Please do always CC the maintainers for relevant subsystems and also the
relevant mailing lists when posting patches, even if just as RFC.  In
this case you've done neither.

> The following issues still exist:
>  - The setting of SDIV/LRDIV is ugly since it requires modifying one of
> the clock registers from the audio driver.

Clock API perhaps?

>  - Audio capture has not been tested
>  - Sometimes playback (ie aplay) results in noise. Killing the process
> and trying again will result in correct playback.
>  - Some empty functions can probably be removed

Yes.

>  - Not sure if I2SONSSP/AC97 should be a function argument, or a Kconfig
> option (opinions please).
