From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:31:20 +0100
Subject: [PATCH RESEND] ARM: s3c2440: fix boot failure introduced by recent
	changes in gpiolib
In-Reply-To: <1283537894-7463-1-git-send-email-awg@embtoolkit.org>
References: <1283537894-7463-1-git-send-email-awg@embtoolkit.org>
Message-ID: <4C86CB48.6000502@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/10 19:18, Abdoulaye Walsimou Gaye wrote:
> Recent changes in s3c gpio break mini2440 board and may be others.
> The problem is that mach-mini2440.c: mini2440_init()
> (where we call s3c_gpio_setpull()) is called before s3c2440.c: s3c2440_init()
> (where we initialize s3c24xx_gpiocfg_default.set_pull function pointer).
> This causes dereferencing of NULL pointer at boot time and a kernel panic.
> 
> Signed-off-by: Abdoulaye Walsimou Gaye <awg@embtoolkit.org>

ok, i'll think over this. it is probably the right thing to do.
