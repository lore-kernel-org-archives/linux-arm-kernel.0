From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Feb 2011 16:25:13 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTimS-1CxkSHDChqX1K8bt-89T=8SDoSdmKeZ4PXG@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102111551.15508.arnd@arndb.de>
	<AANLkTimS-1CxkSHDChqX1K8bt-89T=8SDoSdmKeZ4PXG@mail.gmail.com>
Message-ID: <201102111625.14226.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 February 2011, Lei Wen wrote:
> > Several orders of magnitude. It is very easy to get a card that can write
> > 12 MB/s into a case where it writes no more than 30 KB/s, doing only
> > things that happen frequently with ext3.
> >
> 
> Maybe we could get that case into mmc_test code, so that we could track
> that in latter whether it already be fixed or not? Or in other word, to prove
> the firmware in sd card is stupid or not. :)
 
There are many kinds of stupid, and a lot of cards are. I've actually had
excellent success with simply measuring from user space, which is
much easier than in mmc_test.

Unfortunately, you have to write to the card to do that, which may destroy
the data even if you write the same data that is already on it.

See
https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashCardSurvey
for most of my results. I'm about to write up a better paper with all the
measurements, and will make my tools available soon.


	Arnd
