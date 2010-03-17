From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 17 Mar 2010 11:15:04 +0100
Subject: [PATCH 2/2] [ARM] [IMX]: Fix clock usecount counter from
	underflow.
In-Reply-To: <20100317092042.GB16150@pengutronix.de>
References: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
	<1268809916-6525-2-git-send-email-vzapolskiy@gmail.com>
	<20100317092042.GB16150@pengutronix.de>
Message-ID: <eedb5541003170315t55f3aff1n4dadd25d08a35d7b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/17 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> I'm not sure this is worth it. ?IMHO an unbalanced clk_disable is a
> severe bug that doesn't need to be handled smoothly.
>
> But maybe move the WARN_ON before the __clk_disable(clk->parent)? ?This
> way the disabled parent clock cannot stop the message to appear.
>
> Other than that, please use WARN instead of printk + WARN_ON. ?Then the
> message is printed only after the oops begin marker.

I agree with Uwe, I myself tried to do something similar in the past and people
made me realize that we don't have to fix here what is really a problem in some
driver which calls unbalanced disable/enable.

However, I think using WARN would be a good idea since it allows the
kernel hacker
to track an error which according to my own experience is very
difficult to detect.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
