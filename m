From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 17 May 2012 14:52:36 +0100
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <20120517132223.GB9650@n2100.arm.linux.org.uk>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FB3D294.4020505@wwwdotorg.org>
 <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
 <201205161942.20296.arnd@arndb.de>
 <20120517132223.GB9650@n2100.arm.linux.org.uk>
Message-ID: <20120517135236.GA5807@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 02:22:23PM +0100, Russell King - ARM Linux wrote:

> DMA on the other hand seems to have cases where you can make a choice
> between two or more providers of the service.  The impression that I'm
> getting from this thread is that it's difficult to describe that kind
> of relationship in DT - DT is good at describing "A provides X to C"
> but not "A _or_ B provides X to C and you can chose either A or B
> depending on <something> to satisfy X".

A similar thing exists in a lot of clock trees - often the final clock
block before an IP block includes a mux which could come from one of a
number of sources.
