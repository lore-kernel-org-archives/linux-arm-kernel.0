From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Jan 2014 10:24:23 +0800
Subject: [PATCH] ARM: imx: Explicitly pass the active level of the PHY
 reset
In-Reply-To: <CAOesGMhDUZ6WVCoh50nNYZt+WMQvaWupHLHdjBz68kUaoPxnjQ@mail.gmail.com>
References: <1388750156-23208-1-git-send-email-festevam@gmail.com>
 <20140103120712.GE25079@S2101-09.ap.freescale.net>
 <20140104054702.GA6243@quad.lixom.net>
 <CAOesGMhDUZ6WVCoh50nNYZt+WMQvaWupHLHdjBz68kUaoPxnjQ@mail.gmail.com>
Message-ID: <20140106022419.GA26128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 09:29:37AM -0800, Olof Johansson wrote:
> Actually, Russell brought this to my attention (I should have looked
> closer earlier). You guys have made an incompatible binding change
> here. In -rc6? That's not cool, we're not doing those any more.

Yes, the driver change hit mainline too quickly.

> 
> What should happen is that the driver change should be reverted
> instead. You can't rely on every device tree out there changing to
> accommodate these kind of things any more.

Fabio just sent a revert patch for it, and David has queued it.

This is a typical example that we did not implement device tree
bindings perfectly right in the first place, and we have to live with it
forever.  If someday there is board design using an active high PHY
reset, we basically have to introduce another property for it.  But
it does no harm to correct the level type of the existing property in
device tree sources anyway.  So I will still queue Fabio's dts patch [1]
for 3.14 - a different one from what you're dropping here.  The
patch [1] is against my for-next branch while the dropped one is
against mainline.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg297829.html
