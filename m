From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 2 Apr 2015 14:48:37 +0000
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on
 Armada 370 DB
In-Reply-To: <20150402161626.182e267d@free-electrons.com>
References: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <2321040.CmsL1gluUd@wuerfel>
 <20150402153650.2cc9c3d7@free-electrons.com>
 <2515980.d69ggAvHPo@wuerfel>
 <20150402161626.182e267d@free-electrons.com>
Message-ID: <20150402144837.GF24598@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Thu, Apr 02, 2015 at 04:16:26PM +0200, Thomas Petazzoni wrote:
> Except that the very early steppings of Armada 370 and Armada XP had a
> bug, which prevented from changing the internal register base address,
> so they had no other choice but to keep it at 0xd0000000. And then,
> once those early steppings were replaced by real production steppings,
> the bug was fixed, and they migrated to 0xf1000000, and the situation
> was back to normal.

fwiw, I agree with the change, and I appreciate this background info.
It's comforting to hear that it was a hardware bug, not just a "well, we
forgot to remap in u-boot, oh well."

> Arnd, please don't get in the way of platform maintainers for such very
> platform-specific issues for which you don't have the background about
> what happened and why we're doing this change. It's the responsibility
> of the platform maintainers to decide how and when they want to keep or
> break the compatibility.

Inhale, exhale, zen. :-)  Arnd is doing exactly what he's supposed to be
doing.  He spotted something that doesn't appear to match the big
picture of what we're trying to do with DT.  He questioned it.  It's our
job to give him a clear, technical argument for why we're making the
change.  To put it bluntly: him, Olof, and others are our sanity check.

If we can't provide a sound technical reasoning for the change(s), then
they shouldn't accept a branch containing them.

thx,

Jason.
