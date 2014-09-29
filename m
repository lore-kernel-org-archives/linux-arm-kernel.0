From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 29 Sep 2014 11:53:14 +0200
Subject: [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
In-Reply-To: <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714670.3040.39.camel@decadent.org.uk>
 <20140928222150.GC3248@norris-Latitude-E6410>
 <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
Message-ID: <CACna6ry91b3wcHsG4C-td+STPuiaH7oaAcQuKiKdhud+jctUeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 September 2014 08:36, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> 1) The main urgent issue: broken auto-loading
> Tracked in the thread: http://www.spinics.net/lists/linux-spi/msg01726.html
> Problem: m25p80.c references spi_nor_ids (from external file)
> Short-term solution: duplicate IDs in the m25p80.c
>
> Ben: just like Brian, I think the patch like this one (
> [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
> ) is the way to go. However few comments:

I started wondering... would this be possible to fix all m25p80 users
instead? Make them always specify modalias as "m25p80" and then
provide platform_data if needed?

Has anyone checked in how many places we use "wrong" (or should I say
"weird") modaliases? I guess some would need to grep kernel for all
possible names.
