From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 10 Jul 2011 17:40:27 +0900
Subject: [PATCH 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <CAA+hA=TirfTs9WB19snuH2HhmJvaxApEg2H1oT2BwQwPkTOuUA@mail.gmail.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-4-git-send-email-b29396@freescale.com>
	<20110709030008.GD26900@sirena.org.uk>
	<CAA+hA=TirfTs9WB19snuH2HhmJvaxApEg2H1oT2BwQwPkTOuUA@mail.gmail.com>
Message-ID: <20110710084021.GE23199@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 04:36:44PM +0800, Dong Aisheng wrote:
> 2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Fri, Jul 08, 2011 at 11:59:43PM +0800, Dong Aisheng wrote:

> >> + ? ? int (*init) (void); ? ? /* board specific init */
> >> + ? ? int (*finit) (void); ? ?/* board specific finit */

> > Eh? ?Your machine driver is already entirely board specific...

> Still not.

> It's originally used for some board's codec that do not need SAIF to
> provide mclk.
> I will remove it if we still do not need it to make the things simply.

If you've got different CODECs you almost certainly want to have
different machine drivers for the relevant boards.
