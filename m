From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 12 Jan 2012 06:57:43 +1100
Subject: [PATCH 06/11] ep93xx: Don't use system controller defines in
 audio drivers
In-Reply-To: <20120111174216.GD24213@opensource.wolfsonmicro.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-7-git-send-email-rmallon@gmail.com>
 <20120111174216.GD24213@opensource.wolfsonmicro.com>
Message-ID: <4F0DE9B7.60201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/12 04:42, Mark Brown wrote:
> On Wed, Jan 11, 2012 at 02:14:31PM +1100, Ryan Mallon wrote:
>> Both the Snapper CL15 and EDB93xx audio drivers set the same audio
>> configuration in ep93xx_i2s_acquire. Remove the arguments to
>> ep93xx_i2s_acquire so that the audio drivers no longer need the
>> EP93XX_SYSCON defines exported.
> What if there are other boards out there which use a different
> configuration?

We can either add a second function, like ep93xx_i2s_acquire_on_ssp, or
we can create a set of defines for the various options needed. I just
want to avoid exposing the system controller registers/flags directly.
The ep93xx chip is now obsolete, so I don't expect new boards to appear,
and these two boards have been the only ones with audio support for a
couple of years now, so this seemed to be the best solution.

~Ryan
