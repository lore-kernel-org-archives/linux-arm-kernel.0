From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 25 Feb 2012 08:49:52 +0000
Subject: [PATCH 5/5] ARM: Cortex-M3: Add support for exception handling
In-Reply-To: <20120224224325.GC15120@n2100.arm.linux.org.uk>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1329423490-15580-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120216222002.GL27825@n2100.arm.linux.org.uk>
 <20120224220122.GD14173@pengutronix.de>
 <CAHkRjk70x+Fn+Z4iUxSMc7Zq2cKBo_ka0tNhV0i5JWmEixpRrA@mail.gmail.com>
 <20120224224325.GC15120@n2100.arm.linux.org.uk>
Message-ID: <20120225084952.GA24821@MacBook-Pro.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:43:25PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 24, 2012 at 10:12:06PM +0000, Catalin Marinas wrote:
> > Just to reply to Russell - yes, this part needs changing (could be the
> > pt_regs saving or just the signal and trace code that copies them to
> > user so that we preserve the ABI).
> 
> It's more than just that.  What about the various exception handling
> code which needs to look up registers by numerical index?  That
> encompasses kprobes, alignment fixup, swp emulation, fp exception
> fixup, and so forth.

Some of these don't apply to the M profile, like swp emulation (Thumb-2
only core). Anyway, it's not difficult to get the pt_regs structure back
to the standard layout.

Catalin
