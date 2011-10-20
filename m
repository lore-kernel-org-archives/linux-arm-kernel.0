From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Oct 2011 10:52:35 +0100
Subject: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
In-Reply-To: <4E9FDCD9.7030202@cam.ac.uk>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
	<4E9EFE0B.2030205@cam.ac.uk> <4E9F15B6.90506@free-electrons.com>
	<20111020090532.7df7af70@skate> <4E9FDCD9.7030202@cam.ac.uk>
Message-ID: <20111020095235.GL18713@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 09:33:29AM +0100, Jonathan Cameron wrote:

> Agreed.  This is currently up in the air. The current state of those IIO
> hooks is that they do pull only.  Push based capture is tricky as for IIO
> we want to control the triggering of the push at a far finer scale than
> makes sense for input. I'm not yet clear how these two will play together.

What's the issue here?  The touchscreen input is just a trigger

> If we sit something underneath the IIO and input drivers (or use the lower
> portions of IIO to do this) then the intent would be to have a fully generic
> input touchscreen driver on top.  I'm not sure that's possible. For

I'm not sure that's going to be tractable, while the ADC usage may be the
same I'd expect to see a bunch of other logic around them for pen down
detection.  I'd guess it is going to be more tractable to have a library
that most ADC touchscreens can share which handles the actual data
transfer bit of things but has extra glue logic around it to make the
actual device.
