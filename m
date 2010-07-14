From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Wed, 14 Jul 2010 21:39:42 +0530
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100714154726.GH31073@rakim.wolfsonmicro.main>
References: <33A307AF30D7BF4F811B1568FE7A9B1810E7E88D@EXDCVYMBSTM006.EQ1STM.local>
	<20100713145645.GA24626@rakim.wolfsonmicro.main>
	<20100713150814.GA13767@bnru01.bnr.st.com>
	<20100713150905.GD24626@rakim.wolfsonmicro.main>
	<20100713161343.GA25342@bnru01.bnr.st.com>
	<20100713203852.GA1756@rakim.wolfsonmicro.main>
	<20100714145053.GA1689@bnru01.bnr.st.com>
	<20100714145748.GF31073@rakim.wolfsonmicro.main>
	<20100714153643.GB1689@bnru01.bnr.st.com>
	<20100714154726.GH31073@rakim.wolfsonmicro.main>
Message-ID: <20100714160941.GC1689@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> OK, you're missing the point here.  The system constraints say what's
> going to be used on this actual system not what an individual component
> is capable of supporting.  Regulators are almost always vastly more
> flexible than any system can use and so the constraints are used to tell
> the regulator core what configurations can be used on a given system.
> You need to check what makes sense on the system for the things that are
> connected.
Ok.

> For *all* supplies?
Yes. whatever supplies I have listed here all can be enabled/disabled by
their consumers. Sorry to ask, but please help me to understand the
emphasis of the question. There are other supplies, which are controlled
outside the kernel and so I haven't exposed them here.
 
> Again, you need to think about what's actually hooked up.  Permission to
> do any of this stuff depends heavily on the set of consumers that are
> actually hooked up - think about the example I mentioned above where
Agreed.

> some of the consumers on a shared supply are hooked up and doing enables
> and disables, for example.  What happens when they cause the supply to
> be disabled but another consumer is running?
Again, sorry to ask(this is confusing :() - but isn't this managed by
the core? It is the core's responsibility to effectively disable a
supply when none of the consumers are using it; and to block a disable
even when a single consumer is still using it.

For eg, all the audio digital and analog supplies listed here can be
disabled/enabled by the consumer. Same goes for the VAUXn peripheral
supplies, which have shared consumers running at the same voltages.

Regards,
Sundar
