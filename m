From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 10:36:52 +0200
Subject: [PATCH 04/32] dmaengine: ste_dma40: Amalgamate DMA source and
 destination channel numbers
In-Reply-To: <CACRpkdaauDYTdoBHGG9FO4kKqvCYyCrjY8EGWs5gAQWErGW6_A@mail.gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdaauDYTdoBHGG9FO4kKqvCYyCrjY8EGWs5gAQWErGW6_A@mail.gmail.com>
Message-ID: <201304251036.52284.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 April 2013, Linus Walleij wrote:
> Are we now sacrificing that ability on the altar of simplification?
> 
> I actually think not, but that we should do periph-to-periph transfers
> in some other way, and that the .dir attribute should go away from
> the struct stedma40_chan_cfg as well but I'm not entirely sure.
> Someone else?

The dma-engine core has no support for device-to-device transfers,
and as far as I understand that is neither considered a useful
feature in real life, nor easy to add, so I don't think it matters
much here.

	Arnd
