From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Jun 2011 09:37:49 +0200
Subject: [PATCH 3/3] mach-u300: cleanup clockevent code
In-Reply-To: <alpine.LFD.2.02.1105312319530.3078@ionos>
References: <1306876145-6778-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.02.1105312319530.3078@ionos>
Message-ID: <BANLkTi=UyypKZUQOCCL-KWyAbMQBKY4ccg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/31 Thomas Gleixner <tglx@linutronix.de>:
> On Tue, 31 May 2011, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> Use the new clockevents_config_and_register() function to register
>> the U300 clockevent, since that code requires ->cpumask to be set
>> we set this even on this UP system to please the framework.
>
> Hmm, how about whacking the framework maintainer on the head for that
> requirement?

Yeah hm, I sort of figured it might be desirable to have this warning
on SMP. This:

BUG_ON(!dev->cpumask);

from clockevents.c is the culprit anyway. I dunno if it's best to
#ifdef CONFIG_SMP that thing (technically I guess it shouldn't
even be in the struct on UP but who cares) or if there is some
more clever way to do it runtime, so whatever you prefer, I can
patch it if you know what you want.

Thanks,
Linus Walleij
