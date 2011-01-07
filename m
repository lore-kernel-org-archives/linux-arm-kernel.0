From: david-b@pacbell.net (David Brownell)
Date: Fri, 7 Jan 2011 01:00:44 -0800 (PST)
Subject: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
	irq chip
In-Reply-To: <20110105202939.GC8717@n2100.arm.linux.org.uk>
Message-ID: <522801.72719.qm@web180309.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> o lazy-disable state

This is an odd state, and confusion regularly
comes up ... I've never been a fan of having the
imperatively named disable_irq() act like a

disable_irq_at a_random_later_time_ _but_nyet().  If
one must have the latter function, clearer IMO
to name it better and have disable_irq()
do exactly that by the time it returns ... that
is after all what folk expect given its name and conventional interpretation of "disable".
 (ergo confusion when that's not what happens)

lazy_disable_irq() would be accurate, butI'm not
sure many folk would choose to use it.

- Dave
