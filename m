From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2012 18:23:19 +0000
Subject: [PATCH] backlight: lcd: add driver for raster-type lcd's with
 gpio controlled panel reset
In-Reply-To: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
References: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120107182319.GA13181@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 09:12:26PM +0530, Thomas Abraham wrote:
> Add a lcd panel driver for simple raster-type lcd's which uses a gpio
> controlled panel reset. The driver controls the nRESET line of the panel
> using a gpio connected from the host system. The Vcc supply to the panel
> is (optionally) controlled using a voltage regulator. This driver excludes
> support for lcd panels that use a serial command interface or direct
> memory mapped IO interface.

I'm trying to work out what kind of LCD panel this is for.  I assume
not the panels which would be connected to a SoC, which have a parallel
interface to a frame buffer device (LCD controller)?

If this is for these kinds of LCD panels, how are you handling the
timing required for active panels - some of which must not be powered
up without the LCD controller first being setup and enabled, and must
be powered down before the LCD controller is disabled.

I've seen this requirement with panels connected to ARM Ltd's development
boards, and also some SoCs.
