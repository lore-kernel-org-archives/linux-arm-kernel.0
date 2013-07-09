From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Jul 2013 09:37:29 +0200
Subject: [PATCH 03/04] ARM: shmobile: Add EMEV2 and KZM9D to
 ARCH_SHMOBILE_MULTI
In-Reply-To: <20130709054359.14007.23619.sendpatchset@w520>
References: <20130709054331.14007.66068.sendpatchset@w520>
 <20130709054359.14007.23619.sendpatchset@w520>
Message-ID: <201307090937.29805.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 July 2013, Magnus Damm wrote:
> +void __init __weak emev2_clock_init(void)
> +{
> +       /* in case legacy clocks are disabled then do nothing */
> +}

Nitpicking:

I don't like the __weak symbols too much, in general I prefer
doing either

	if (IS_ENABLED(CONFIG_SHMOBILE_CLOCKS)
		emev2_clock_init()

or using an inline alternative in the header file.

	Arnd
