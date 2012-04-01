From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 1 Apr 2012 12:29:49 +0100
Subject: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
In-Reply-To: <201203301845.07534.arnd@arndb.de>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <201203301136.05038.arnd@arndb.de> <4F75D5C0.5050307@wwwdotorg.org>
 <201203301845.07534.arnd@arndb.de>
Message-ID: <20120401112949.GA19107@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 06:45:07PM +0000, Arnd Bergmann wrote:
> On Friday 30 March 2012, Stephen Warren wrote:

> > > +- cd-inverted: when present, polarity on the wp gpio line is inverted
> > > +- wp-inverted: when present, polarity on the wp gpio line is inverted

> > I'm not sure about those two: Some of the GPIO bindings have flags in
> > the GPIO specifier (Tegra, ARM PL061, gpio.txt mentions the possibility
> > of polarity being in the specifier), and bit 0 of the flags is used to
> > indicate inversion. I think that either we should rely on GPIO
> > specifiers having such flags and remove these xxx-inverted properties
> > from the MMC binding, or remove that flag bit from the GPIO bindings.

> Maybe the GPIO maintainer can comment on this. My understanding is
> that not all gpio controllers support this in their bindings. If they
> do, I agree that we can remove the extra properties here.

Surely it'd be better to fix this at the GPIO controller end rather than
having a patchwork of approaches?
