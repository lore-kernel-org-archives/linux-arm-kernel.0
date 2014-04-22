From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Apr 2014 12:01:32 -0700
Subject: [PATCH] ARM: dts: am437x-gp-evm: Boot fixes
In-Reply-To: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
References: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20140422190132.GA12204@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [140422 11:52]:
> This patch, along with patch here [1], fixes boot for am437x-gp-evm. The
> bootloader configures gpio5_7 to control the DDR3 termination regulator,
> the linked patch prevents that gpio bank from being reset and losing
> the previously configured state, and this patch binds the gpio to a
> regulator so the kernel is aware of the state of the gpio.
> 
> [1] https://www.mail-archive.com/linux-omap at vger.kernel.org/msg102941.html

Setting up the GPIO regulator makes sense to me. But the hack in the
link above is potentially a nasty time bomb for anybody trying to
use GPIO bank 5 on that board.

What tests have been done that the GPIO bank behaves properly when
it's not reset?

Regards,

Tony
