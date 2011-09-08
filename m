From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Sep 2011 09:37:43 -0700
Subject: [alsa-devel] [PATCH] ASoC: omap: convert per-board modules to
	platform drivers
In-Reply-To: <CAG5Tg6XxGP1YhQ0zW3f=1EkZfAmb9vj3pBemeSazpH1_CZ3OzQ@mail.gmail.com>
References: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
	<4E68DBF7.1030009@metafoo.de>
	<CAG5Tg6XxGP1YhQ0zW3f=1EkZfAmb9vj3pBemeSazpH1_CZ3OzQ@mail.gmail.com>
Message-ID: <20110908163742.GD3098@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 04:41:30PM +0100, Mans Rullgard wrote:
> On 8 September 2011 16:15, Lars-Peter Clausen <lars@metafoo.de> wrote:

> > Use different device driver names for different drivers.

> I guess this worked by accident on my system.

> Are there any other changes needed?

Check the N810 code - it looks like that driver should be taking
platform data to distinguish between the two models.  Possibly also rx51
though I only looked at the diff.  Also it should probably be grabbing
the clocks before it registers the card.
