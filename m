From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 12:02:13 +0000
Subject: [PATCH 2/3] ARM: ux500: Turn on the 'heartbeat' LED trigger
In-Reply-To: <20130109115911.GI3931@n2100.arm.linux.org.uk>
References: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
 <201301091156.55644.arnd@arndb.de>
 <20130109115911.GI3931@n2100.arm.linux.org.uk>
Message-ID: <201301091202.14105.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Russell King - ARM Linux wrote:
> On Wed, Jan 09, 2013 at 11:56:55AM +0000, Arnd Bergmann wrote:

> > Right. The change I suggested fixes the build errors but doesn't actually
> > make the intended behavior correct. Just using a configuration file is the
> > right solution here.
> 
> Hang on a moment: if the lack of the LEDs support leads to build errors,
> doesn't that mean there's missing conditional compilation?

The build error would have come only from selecting LEDS_TRIGGERS without
also selecting NEW_LEDS and LEDS_CLASS. I haven't actually tried if that
results in a hard error, but you'd get at least a Kconfig warning.

	Arnd
