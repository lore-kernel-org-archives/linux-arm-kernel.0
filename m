From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 1 Jun 2013 02:34:58 +0300
Subject: [PATCH 03/15] drm/nouveau: use mdelay instead of large udelay
 constants
In-Reply-To: <1370038972-2318779-4-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-4-git-send-email-arnd@arndb.de>
Message-ID: <20130531233458.GD3345@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 01, 2013 at 12:22:40AM +0200, Arnd Bergmann wrote:
> ARM cannot handle udelay for more than 2 miliseconds, so we
                                           ^^^^

                                 There's l missing here.

> should use mdelay instead for those.

Could this be handled inside ARM udelay() instead? Probably most of the
delay values are compile-time constants.

A.
