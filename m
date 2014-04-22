From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 23:45:55 +0200
Subject: [PATCH v2 22/38] ARM: orion: switch to a per-platform
 handle_irq() function
In-Reply-To: <1398202002-28530-23-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-23-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4298778.6g1TfFX2gY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 23:26:26 Thomas Petazzoni wrote:
> However, the common CONFIG_MULTI_IRQ_HANDLER handler for non-DT
> platforms in plat-orion/irq.c doesn't match the needs of
> Orion5x. Also, it doesn't make much sense for orion_irq_init() to
> register the multi-IRQ handler: orion_irq_init() is called once for
> each IRQ cause/mask tuple, while the multi-IRQ handler only needs to
> be registered once.

Since you now have the code for doing MULTI_IRQ_HANDLER on Orion5x,
why not always enable it for both Orion and Kirkwood, and remove
the #ifdef?

	Arnd
