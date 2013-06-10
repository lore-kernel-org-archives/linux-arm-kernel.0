From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Jun 2013 07:25:11 -0700
Subject: [PATCH 4/4] ARM: OMAP: Move DT wake-up event handling over to
 use pinctrl-single-omap
In-Reply-To: <688FBEF7C8277944BE5AED9A41FB1EBC1AB12DA0@DNCE05.ent.ti.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205046.16513.2802.stgit@localhost>
 <688FBEF7C8277944BE5AED9A41FB1EBC1AB12DA0@DNCE05.ent.ti.com>
Message-ID: <20130610142511.GF8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Quadros, Roger <rogerq@ti.com> [130610 05:37]:
> Hi Tony, (sorry, on Outlook web)
> 
> -                       compatible = "ti,omap4-padconf", "pinctrl-single";
> +                       compatible = "ti,omap4-padconf";
> 
> This change is not necessary if we make sure the pinctrl-single-omap driver
> gets registered early enough, before the pinctrl devices are probed.
>  (e.g. subsys_initcall())

I'd rather make everything just module_init, there should not be
any need to tinker with the init call ordering any longer with
deferred probe. And by making everything into regular device drivers
we actually see real error messages without DEBUG_LL and earlyprintk
if something goes wrong.

Note that there are patches queued to make twl-core.c just regular
module_init as well, so that should fix any issues you might be
related it probing before pinctrl.
 
> I've commented about this in the other patch.

Sorry can you clarify, which other patch? The other message I saw
in this thread was empty. Or at least I have not seen it yet.

Regards,

Tony
