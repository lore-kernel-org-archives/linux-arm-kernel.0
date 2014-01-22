From: jogo@openwrt.org (Jonas Gorski)
Date: Thu, 23 Jan 2014 00:03:30 +0100
Subject: [PATCH 2/2] ehci-platform: Add support for controllers with
 big-endian regs / descriptors
In-Reply-To: <Pine.LNX.4.44L0.1401221614550.1310-100000@iolanthe.rowland.org>
References: <20140122213434.00000f25@openwrt.org>
 <Pine.LNX.4.44L0.1401221614550.1310-100000@iolanthe.rowland.org>
Message-ID: <20140123000330.00002567@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jan 2014 16:17:42 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, 22 Jan 2014, Jonas Gorski wrote:
> 
> > If it's safe to set ehci->big_endian_{desc,mmio} from the _probe()
> > routine, then maybe the pdata sets in _reset() should be moved into here
> > instead of adding extra cludges/checks into _reset().
> 
> Why?  What difference would it make?

Effectivewise none, but to me it seems to be cleaner to set them once in
probe() instead of everytime reset() is called.

I admit I don't know the code flow good enough if reset() is called
more than once in the lifetime of a hcd device.

And as I said, it would allow doing the checks the patch adds for both
DT and !DT, not just DT only.


Regards
Jonas
