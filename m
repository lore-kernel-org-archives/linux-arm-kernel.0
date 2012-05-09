From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 14:46:40 +0000
Subject: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
In-Reply-To: <4FAA7CB6.8030506@atmel.com>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
 <4FAA7CB6.8030506@atmel.com>
Message-ID: <201205091446.40849.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Nicolas Ferre wrote:
> Jonathan, Arnd, Olof,
> 
> As explained by Maxime, this patch series is adding the Atmel ADC driver
> to the out-of-staging iio subsystem. It relies on patches that are in
> staging-next.
> On the other hand, I really wouldn't like to split the series between
> iio and arm-soc...
> My question is: would it be possible to take this series in Jonathan
> iio/staging-next git tree for inclusion in 3.5? Arnd & Olof, is it ok
> for you? Do you want to add your Acked-by on some patches?

Hmm, if we would do only the DT-based probing for this, it would be
very simple to split the patches between the two branches, but with
the dependency on the platform_data definition, we can't do that.

If you think we still need the platform_data, I guess it can go in
the iio tree, but I'd be happier if we didn't need it any more.

	Arnd
