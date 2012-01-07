From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 07 Jan 2012 19:32:12 +0100
Subject: [PATCH] backlight: lcd: add driver for raster-type lcd's with
 gpio controlled panel reset
In-Reply-To: <20120107182319.GA13181@n2100.arm.linux.org.uk>
References: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
 <20120107182319.GA13181@n2100.arm.linux.org.uk>
Message-ID: <4F088FAC.3000200@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2012 07:23 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 05, 2012 at 09:12:26PM +0530, Thomas Abraham wrote:
>> Add a lcd panel driver for simple raster-type lcd's which uses a gpio
>> controlled panel reset. The driver controls the nRESET line of the panel
>> using a gpio connected from the host system. The Vcc supply to the panel
>> is (optionally) controlled using a voltage regulator. This driver excludes
>> support for lcd panels that use a serial command interface or direct
>> memory mapped IO interface.
> 
> I'm trying to work out what kind of LCD panel this is for.  I assume
> not the panels which would be connected to a SoC, which have a parallel
> interface to a frame buffer device (LCD controller)?
> 
> If this is for these kinds of LCD panels, how are you handling the
> timing required for active panels - some of which must not be powered
> up without the LCD controller first being setup and enabled, and must
> be powered down before the LCD controller is disabled.
> 
> I've seen this requirement with panels connected to ARM Ltd's development
> boards, and also some SoCs.

This is handled by the LCD framework. Or at least should be, see this patchset
http://www.spinics.net/lists/linux-fbdev/msg04503.html

- Lars
