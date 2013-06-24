From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 24 Jun 2013 19:49:04 +0200
Subject: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
In-Reply-To: <51C86442.6090406@samsung.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <1371766383-29077-12-git-send-email-tomasz.figa@gmail.com>
 <2925617.TjWXJcIKRC@flatron> <51C86442.6090406@samsung.com>
Message-ID: <20130624174903.GA6795@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 12:22:42AM +0900, Kukjin Kim wrote:
> On 06/22/13 22:06, Tomasz Figa wrote:
> >This patch introduces new Samsung PWM driver, which is heavily cleaned,
> >multiplatform aware and supports DeviceTree based instantiation.
> >
> >Since on historical hardware PWM block can be shared with clocksource
> >driver, a shared spinlock is used to protect access to shared registers,
> >already exported from the clocksource driver.
> >
> >Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> >---
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-samsung.c | 601 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 602 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-samsung.c
> >
> >Changes since v2:
> >  - Replaced __raw_{readl,writel} with {readl,writel}.
> >  - Corrected commit message.
> >
> 
> [...]
> 
> >+	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
> >+		if (val>= SAMSUNG_PWM_NUM) {
> >+			pr_warning("%s: invalid channel index in samsung,pwm-outputs property\n",
> 
> Just note, checkpatch complains following, so fixed to use pr_warn()
> when I applied.

Note that you can't apply patches that touch the PWM tree without my Ack
and I already mentioned that the current way this driver is written
isn't acceptable.

So either you fix it properly, or if everybody except me thinks we don't
need a proper design for drivers anymore, then the only way I'll accept
this driver into the PWM tree is if you put a really big comment at the
top of the file saying that the driver is badly designed on purpose and
that people shouldn't be using it as a reference.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/5ac9f4dc/attachment.sig>
