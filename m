From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Nov 2013 15:15:58 +0100
Subject: [PATCH] ARM: sunxi: stop timer from ticking before enabling
 interrupts
In-Reply-To: <1385815995-15145-1-git-send-email-marc.zyngier@arm.com>
References: <1385815995-15145-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131130141558.GD3002@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Sat, Nov 30, 2013 at 12:53:15PM +0000, Marc Zyngier wrote:
> The sun4i timer can still be ticking when we enable the interrupt.
> If another timer is actually used (A7 architected timer, for example),
> odds are that the interrupt will eventually fire with the event_handler
> pointer being NULL.
> 
> The obvious fix it to stop the timer before registering the interrupt.
> 
> Observed and tested on sun7i (cubietruck).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

You can add my Acked-by, but you should rather send this to Daniel
Lezcano, which is the clocksource/clockevent maintainer.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131130/af58cd59/attachment.sig>
