From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 Feb 2013 09:28:18 -0800
Subject: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
In-Reply-To: <5111A251.9020400@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-3-git-send-email-jon-hunter@ti.com>
 <20130201215154.GV22517@atomide.com> <51103247.2030906@ti.com>
 <51103A25.9010401@ti.com> <20130205233407.GR25185@atomide.com>
 <5111A251.9020400@ti.com>
Message-ID: <20130206172818.GB25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130205 16:26]:
> 
> Actually, let me look into this a bit more. It appears that for all
> omap2+ devices NOR should be mapped to CS0 at 0x08000000. So I am
> wondering if the boot-loader is re-mapping the CS0 space. If it is then
> may be we can avoid having such hacks in the kernel by fixing the
> bootloader. To date only the apollon board has really had this problem
> and I need to check what I have on my H4 (which has been hacked by me ;-)

OK. Yeah sorry I don't remember the history of why the different
mappings were needed. It could be it was just needed to keep some
devices working that were only initialized in the bootloader like
you're suspecting.

Tony
