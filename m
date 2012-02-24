From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Feb 2012 22:43:25 +0000
Subject: [PATCH 5/5] ARM: Cortex-M3: Add support for exception handling
In-Reply-To: <CAHkRjk70x+Fn+Z4iUxSMc7Zq2cKBo_ka0tNhV0i5JWmEixpRrA@mail.gmail.com>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1329423490-15580-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120216222002.GL27825@n2100.arm.linux.org.uk>
 <20120224220122.GD14173@pengutronix.de>
 <CAHkRjk70x+Fn+Z4iUxSMc7Zq2cKBo_ka0tNhV0i5JWmEixpRrA@mail.gmail.com>
Message-ID: <20120224224325.GC15120@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:12:06PM +0000, Catalin Marinas wrote:
> Just to reply to Russell - yes, this part needs changing (could be the
> pt_regs saving or just the signal and trace code that copies them to
> user so that we preserve the ABI).

It's more than just that.  What about the various exception handling
code which needs to look up registers by numerical index?  That
encompasses kprobes, alignment fixup, swp emulation, fp exception
fixup, and so forth.
