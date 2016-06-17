From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2016 13:41:19 +0200
Subject: [PATCH] [V3] mmc: mmci: add missing include of mmci_qcom_dml.h
In-Reply-To: <1466102852-10063-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466102852-10063-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <4881149.p2gsOpsjH3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 16, 2016 7:47:32 PM CEST Ben Dooks wrote:

> Note, since this is a very small addition to the mmci
> module, it would better to build it into the main mmci
> driver (either by direct copy, or multiple linked
> module)

I suspect the latter is actually what the author intended,
except they accidentally made the symbol tristate and got the
Makefile logic wrong.

Most likely, the qcom developers never considered the case
of having loadable modules.

	Arnd
