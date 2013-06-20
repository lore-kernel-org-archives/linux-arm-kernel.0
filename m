From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 20 Jun 2013 10:04:07 +0200
Subject: [PATCH v2 2/2] gpio-rcar: Remove #ifdef CONFIG_OF around
 OF-specific sections
In-Reply-To: <CACRpkdZJ1Hg=4w1fySiMgy0-Qdph1pD0OZGLFecxHhTsMEKQog@mail.gmail.com>
References: <1371551389-5493-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1667096.lqpXoD2UlE@avalon>
 <CACRpkdZJ1Hg=4w1fySiMgy0-Qdph1pD0OZGLFecxHhTsMEKQog@mail.gmail.com>
Message-ID: <1653091.GeQyMLF6L8@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thursday 20 June 2013 08:42:23 Linus Walleij wrote:
> On Wed, Jun 19, 2013 at 9:51 PM, Laurent Pinchart wrote:
> > On Wednesday 19 June 2013 21:17:35 Linus Walleij wrote:
> >> On Tue, Jun 18, 2013 at 12:29 PM, Laurent Pinchart wrote:
> >> > All functions and data types used by OF-specific code paths are
> >> > declared
> >> > in <linux/of.h> regardless of CONFIG_OF. Replace the #ifdef CONFIG_OF
> >> > guard with a if(IS_ENABLED(CONFIG_OF)) and let the compiler optimize
> >> > the unused code away.
> >> > 
> >> > Signed-off-by: Laurent Pinchart
> >> > <laurent.pinchart+renesas@ideasonboard.com>
> >> 
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Thank you. Can you please take the patch in your tree ?
> 
> No. It does not apply:
> 
> ]$ git am --signoff rcar-fix.patch
> Till?mpar: gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific sections
> error: patch misslyckades: drivers/gpio/gpio-rcar.c:279
> error: drivers/gpio/gpio-rcar.c: patchen kan inte till?mpas
> Patchen misslyckades vid 0001 gpio-rcar: Remove #ifdef CONFIG_OF
> around OF-specific sections
> En kopia av patchen som misslyckades finns i:
>    /home/linus/src/linux-trees/linux-gpio/.git/rebase-apply/patch
> N?r du har l?st problemet k?r du "git am --resolved".
> Om du vill hoppa ?ver patchen k?r du ist?llet "git am --skip".
> F?r att ?terst?lla originalgrenen och avbryta k?r du "git am --abort".
> 
> 
> Isn't this RCAR stuff funneled through ARM SoC this merge window?
> Then you have to send it to the ARM SoC folks corresponding branch.

Oops, my bad. I had mistaken it for one of the pinctrl patches.

/me needs to sleep more :-)

-- 
Regards,

Laurent Pinchart
