From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Apr 2013 15:27:06 +0100
Subject: [PATCH 20/30] ASoC: samsung: convert to dmaengine API
In-Reply-To: <1365638712-1028578-21-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-21-git-send-email-arnd@arndb.de>
Message-ID: <20130411142706.GB24971@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:05:02AM +0200, Arnd Bergmann wrote:
> In order to build the exynos kernel with CONFIG_ARCH_MULTIPLATFORM,
> we must convert all users of the Samsung private DMA interface to
> the generic dmaengine API. This version of the patch adds the
> generic dmaengine API as an alternative to the existing samsung
> specific one. Once all the older platforms provide support for
> the common dmaengine interfaces, we can remove the old code.

There's generic ASoC dmaengine code which should be used instead of open
coding this.  Lars-Peter Clausen and Lee Jones have been working on
making this a totally generic driver, right now it's a library.
