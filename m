From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 10:35:21 +0200
Subject: [PATCH] gpio/mxc: use the edge_sel feature if available
In-Reply-To: <1569254394.2932189.1340107238237.JavaMail.root@advansee.com>
References: <20120619012420.GJ19249@S2101-09.ap.freescale.net>
 <1569254394.2932189.1340107238237.JavaMail.root@advansee.com>
Message-ID: <CACRpkdbLMCirzyk-UbS0zx_TpY-mx51-aEn0bk-48eGMhmm=fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 2:00 PM, Beno?t Th?baudeau
<benoit.thebaudeau@advansee.com> wrote:

> Can you give me an example
> that tells me by what you replaced those cpu_is_xxx()? By some feature test
> macros?

Since this is a DT-enabled driver, add a boolean attribute for
the DT node like "has-edge-select" and add that attribute to
the SoC .dtsi files for the SoCs that has this feature.

Another (better) option is if there are magic numbers in the
silicon register range that you can check for revision of that
hardware in itself. Such auto-detect plug-n-play is always best.

> E.g., there are still many of those cpu_is_xxx() in
> drivers/mtd/nand/mxc_nand.c in linux-next.

Two wrongs does not make one right or how you put it ;-)

Yours,
Linus Walleij
