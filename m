From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 23 Jul 2015 14:07:59 +0200
Subject: [PATCH v2] thermal: consistently use int for temperatures
In-Reply-To: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
References: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150723120759.GA17690@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-07-21 09:21:32, Sascha Hauer wrote:
> The thermal code uses int, long and unsigned long for temperatures
> in different places.
> 
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0?C. This will probably
> immediately shut the machine down due to overtemperature if started below
> 0?C.
> 
> 'long' is 64bit on several architectures. This is not needed since INT_MAX ?mC
> is above the melting point of all known materials.

Can we do something like

typedef millicelsius_t int;

...to document the units?

> Consistently use a plain 'int' for temperatures throughout the thermal code and
> the drivers. This only changes the places in the drivers where the temperature
> is passed around as pointer, when drivers internally use another type this is
> not changed.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
