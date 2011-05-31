From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 31 May 2011 23:23:06 +0200 (CEST)
Subject: [PATCH 3/3] mach-u300: cleanup clockevent code
In-Reply-To: <1306876145-6778-1-git-send-email-linus.walleij@stericsson.com>
References: <1306876145-6778-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.02.1105312319530.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 May 2011, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Use the new clockevents_config_and_register() function to register
> the U300 clockevent, since that code requires ->cpumask to be set
> we set this even on this UP system to please the framework.

Hmm, how about whacking the framework maintainer on the head for that
requirement?

On UP this should be simply ignored and on SMP we can optimize that
for all those architectures which come up with CPU0 in the first
place.

Thanks,

	tglx
