From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Sep 2009 18:24:38 +0100
Subject: [PATCH 1/2] AB3100 regulator support v3
In-Reply-To: <1251756258-23917-1-git-send-email-linus.walleij@stericsson.com>
References: <1251756258-23917-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20090902172438.GA1190@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2009 at 12:04:18AM +0200, Linus Walleij wrote:
> This adds support for the regulators found in the AB3100
> Mixed-Signal IC.
> 
> It further also defines platform data for the ST-Ericsson
> U300 platform and extends the AB3100 MFD driver so that
> platform/board data with regulation constraints and an init
> function can be passed down all the way from the board to
> the regulators.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

This looks basically good - my only concern is if the initialisation
data supplied for the regulators is just setting up the things that can
be set up via the API or if there's other stuff going on (this was my
reason for the question I asked the other day).  If there's other stuff
being configured then I'm happy with the patch modulo the static thing.
