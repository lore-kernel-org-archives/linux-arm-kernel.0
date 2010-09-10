From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Sep 2010 18:16:21 +0200
Subject: [PATCH] ARM: make TCM allocation static and common for all archs
In-Reply-To: <1278717389-8964-1-git-send-email-linus.walleij@stericsson.com>
References: <1278717389-8964-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100910161621.GF21361@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01:16 Sat 10 Jul     , Linus Walleij wrote:
> This changes the TCM handling so that a fixed area is reserved at
> 0xfffe0000-0xfffeffff for TCM. This areas is used by XScale but
> XScale does not have TCM so the mechanisms are mutually exclusive.
> 
> This change is needed to make TCM detection more dynamic while
> still being able to compile code into it, and is a must for the
> unified ARM goals: the current TCM allocation at different places
> in memory for each machine would be a nightmare if you want to
> compile a single image for more than one machine with TCM so it
> has to be nailed down in one place.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> This is another TCM patch, to be applied on top of the other
> stuff I've sent so far. This has been tested on U300 and PB1176
> however I haven't sent a patch for activating TCM on the RealViews
> just yet, because I want to check the potential SMP issues that
> would affect some of them. It would probably be possible to add
> it on the mach-versatile though. (I don't have one.)
> ---
Any feed back about the tcm?

Best Regards,
J.
