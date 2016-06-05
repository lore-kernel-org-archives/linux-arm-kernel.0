From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 5 Jun 2016 21:24:19 +0200
Subject: [PATCH v2 1/6] ir-rx51: Fix build after multiarch changes broke it
In-Reply-To: <1463427254-7728-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1463427254-7728-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1463427254-7728-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20160605192419.GA20086@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-05-16 22:34:09, Ivaylo Dimitrov wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> The ir-rx51 driver for n900 has been disabled since the multiarch
> changes as plat include directory no longer is SoC specific.
> 
> Let's fix it with minimal changes to pass the dmtimer calls in
> pdata. Then the following changes can be done while things can
> be tested to be working for each change:
> 
> 1. Change the non-pwm dmtimer to use just hrtimer if possible
> 
> 2. Change the pwm dmtimer to use Linux PWM API with the new
>    drivers/pwm/pwm-omap-dmtimer.c and remove the direct calls
>    to dmtimer functions
> 
> 3. Parse configuration from device tree and drop the pdata
> 
> Note compilation of this depends on the previous patch
> "ARM: OMAP2+: Add more functions to pwm pdata for ir-rx51".
> 
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: linux-media at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
