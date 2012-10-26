From: michael@walle.cc (Michael Walle)
Date: Fri, 26 Oct 2012 20:06:15 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <20121025094343.58015440@skate>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <77006526a6de40ddb455b25787b08342.squirrel@ssl.serverraum.org>
 <20121025094343.58015440@skate>
Message-ID: <201210262006.15968.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

Am Donnerstag 25 Oktober 2012, 09:43:43 schrieb Thomas Petazzoni:
> Regardless of those GPIOs, did you solve the hang that happened even
> when you removed the gpio_set_value() calls? Or is it still a problem
> currently?

quick update, i found out, that my board loops in the mvebu interrupt handler 
mvebu_gpio_irq_handler(). maybe this is also the lockup Jamie Lentin sees.

are interrupts always enabled, now? is there a way to control them? maybe 
there is something missing in the dts, now.

-- 
michael
