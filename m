From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Sep 2012 14:29:52 +0200
Subject: [PATCH 5/8] gpio: 74x164: Add output pin support
In-Reply-To: <20120905142244.003e5e4b@eb-e6520>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-5-git-send-email-maxime.ripard@free-electrons.com>
 <20120905112012.13ce2c86@skate> <20120905114645.57bfe591@eb-e6520>
 <20120905120906.12d08bf5@skate> <20120905122652.7c752e96@eb-e6520>
 <20120905135646.3bbf98fa@skate> <20120905142244.003e5e4b@eb-e6520>
Message-ID: <20120905142952.2e1f12fd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 5 Sep 2012 14:22:44 +0200,
Eric B?nard <eric@eukrea.com> a ?crit :

> > > OK that's exactly what I was thinking to ;-)
> > 
> > Good. So, do you think it's reasonable to use the STCP as a chip-select
> > for this device?
>
> in your case maybe but that really depends on how the chip is wired to
> the CPU so I'm not sure that can be a generic choice.

I'm not sure to see how this chip could be wired differently to the
CPU. The CPU must do a low-to-high transition on STCP to get the values
out from the internal register.

So, in other words, we don't know how to choose between:

 *) Keep the current solution Maxime has implemented, where we have a
    specific latch GPIO property in the Device Tree for this 74HC595,
    and the 74HC595 driver is responsible for toggling this GPIO when
    needed.

 *) Use the internal SPI controller logic to control this pin as a
    chip-select, and therefore get rid of Maxime's code with the
    specific latch GPIO property in the Device Tree.

Thoughts?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
