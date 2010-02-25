From: hector@marcansoft.com (Hector Martin)
Date: Thu, 25 Feb 2010 01:01:34 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100224223049.GA25587@n2100.arm.linux.org.uk>
References: <1266933437-4876-1-git-send-email-hector@marcansoft.com>	<20100224084259.GA8068@pengutronix.de>	<4B84F0F6.40902@marcansoft.com>	<20100224110353.GA15105@n2100.arm.linux.org.uk>	<4B8543B2.4030004@marcansoft.com>	<20100224153028.GA28805@pengutronix.de>	<4B85A389.6080701@marcansoft.com>
	<20100224223049.GA25587@n2100.arm.linux.org.uk>
Message-ID: <4B85BDDE.9000706@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Feb 24, 2010 at 11:09:13PM +0100, Hector Martin wrote:
>> Uwe Kleine-K?nig wrote:
>>> Independant of the outcome of this discussion I suggest reverting the
>>> switch to the new decompressor for .33.  Hectors patch definitely isn't
>>> .33 material and broken or not the old decompressor was more reliable.
>> That's reasonable, as far as .33 goes. Obviously I'm not expecting my
>> patch to make it to this release.
> 
> Could you put together a description for the commit log for this revert
> please?

Something like this?

Revert "arm: add support for LZO-compressed kernels"

This commit switches to a different inflate implementation. This
implementation is subtly broken when used within the current ARM
compressed loader due to some build hacks. Revert the switch until those
hacks can be removed.

-- 
Hector Martin (hector at marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
