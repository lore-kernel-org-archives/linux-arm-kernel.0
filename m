From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 27 Aug 2009 20:46:50 +0200
Subject: 6410 issues with samsung-ap-2.6
In-Reply-To: <200908242149.n7OLnU6d017655@chronolytics.com>
References: <200908242149.n7OLnU6d017655@chronolytics.com>
Message-ID: <20090827204650.48cb46f1@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Aug 2009 17:49:30 -0400 (EDT)
"David F. Carlson" <dave@chronolytics.com> wrote:

> I am having trouble with the the input gpio_keys code that does a
> "gpio_to_irq()" to get the gpio to irq mapping.
> 
> This call always fails for the 6410 (ENXIO).  I see no code for the
> 6410 to get a irq.

Just checked in mainline, and there is support there for gpio_to_irq(),
at least for gpio bank N. It shouldn't be too hard to add support for
the two remaining banks.

	M.
