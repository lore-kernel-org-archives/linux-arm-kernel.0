From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 23 Jun 2016 19:48:51 +0200
Subject: [RESEND PATCH v2 1/5] ir-rx51: Fix build after multiarch changes
 broke it
In-Reply-To: <1466623341-30130-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1466623341-30130-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <201606231948.51640@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2016 21:22:17 Ivaylo Dimitrov wrote:
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

I think that this extensive description is not needed for commit 
message. Just for email discussion.

> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: linux-media at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/60b96145/attachment.sig>
