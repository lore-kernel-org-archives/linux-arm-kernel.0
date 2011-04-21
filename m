From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2011 11:03:55 +0200
Subject: [PATCH 1/3] bitops: add ifdef CONFIG_GENERIC_FIND_BIT_LE guard
In-Reply-To: <BANLkTimBF312svk0mRkt5_Y=t+B12cLW+Q@mail.gmail.com>
References: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
	<201104201631.40017.arnd@arndb.de>
	<BANLkTimBF312svk0mRkt5_Y=t+B12cLW+Q@mail.gmail.com>
Message-ID: <201104211103.55929.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2011, Akinobu Mita wrote:
> Should we also kill CONFIG_GENERIC_FIND_BIT_LE option comletely,
> then add the #ifdef for each find_*() in lib/find_next_bit.c and always build
> it unconditionally ?

I think that would be more consistent. It's not a big difference anyway, so
do it only if you feel motivated. There are a lot of other things that could
be changed this way, I'd only change it while reworking other aspects in order
to avoid accidentally breaking things.

	Arnd
