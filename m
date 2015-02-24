From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 23 Feb 2015 19:45:48 -0800
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <54E3777B.20607@free-electrons.com>
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
 <87oaotaa6r.fsf@free.fr> <20150216205825.GG25269@lukather>
 <87k2zha69p.fsf@free.fr> <20150217103740.GK25269@lukather>
 <877fvga2mb.fsf@free.fr> <54E3777B.20607@free-electrons.com>
Message-ID: <20150224034548.GC18140@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 02:16:43PM -0300, Ezequiel Garcia wrote:
> On 02/17/2015 02:07 PM, Robert Jarzmik wrote:
> > It will be Brian choice eventually, but if you say that you will submit that
> > approach for next cycle, and yours for stable, and that for next you'll convert
> > mdelay() to msleep(), I'll stop arguing.
> 
> How about you push a proper patchset with this alternative (and a nice
> cover letter explaining the need for a threaded irq) so we can discuss
> properly this new turn?

I think both Maxime's change (polling a new HW bit) and Robert J's
change (move to a threaded IRQ) are good. I'll take another look, but I
expect I'll take Maxime's v4 for the 4.0 cycle, and Robert J's v2 for
4.1 (or will we just jump straight to 5.0? I never know). Will I see a
patch to convert to msleep() and/or a jiffies timeout in the near
future?

Brian
