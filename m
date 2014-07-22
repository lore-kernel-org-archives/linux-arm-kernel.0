From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 10:09:12 +0800
Subject: [PATCH 2/3] ARM: smp_scu: enable SCU standby support
In-Reply-To: <20140721102638.GE32578@arm.com>
References: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
 <1405928755-19413-3-git-send-email-shawn.guo@freescale.com>
 <20140721085150.GB15666@arm.com> <20140721092703.GL8537@dragon>
 <20140721102638.GE32578@arm.com>
Message-ID: <20140722020911.GO8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 11:26:38AM +0100, Catalin Marinas wrote:
> The usual question - could the firmware enable this bit before Linux
> starts?

It could, I guess.  Actually, on i.MX we're setting this bit in platform
code right now.  But I think setting this bit makes sense for most of
the platforms, so it can reasonably be done in SCU core function.  Isn't
it the point of having core/common function after all?

> We already do a read/modify/write sequence here and are only
> supposed to write the enable bit as the rest are implementation defined.

Isn't standby bit implemented by all A9 SCU except a couple of very
early revisions (per Will)?

Shawn
