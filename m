From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Nov 2014 11:39:20 +0100
Subject: [PATCH] asm-generic: Add msi.h
In-Reply-To: <alpine.DEB.2.11.1411181133080.3909@nanos>
References: <alpine.DEB.2.11.1411181133080.3909@nanos>
Message-ID: <1703620.E5bhVDQPHc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 November 2014 11:34:37 Thomas Gleixner wrote:
> To support MSI irq domains we want a generic data structure for
> allocation, but we need the option to provide an architecture specific
> version of it. So instead of playing #ifdef games in linux/msi.h we
> add a generic header file and let architectures decide whether to
> include it or to provide their own implementation and provide the
> required typedef.

Acked-by: Arnd Bergmann <arnd@arndb.de>

for merging the asm-generic file

> I know that typedefs are not really nice, but in this case there are no
> forward declarations required and it's the simplest solution.

I must be missing the obvious: what problem does the typedef solve
that you would have with just a struct?

	Arnd
