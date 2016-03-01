From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  1 Mar 2016 17:59:56 +0100
Subject: [PATCH 0/6] rtc: generic: follow up for COMPILE_TEST
Message-ID: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Today's linux-next kernel allowed building the rtc-generic
driver (and most other rtc drivers) on all architectures,
but this caused some errors on architectures without asm/rtc.h.

This series reworks that driver to avoid the dependency,
and simplifies all four implementations. My first approach
was to split the driver into four separate drivers, but
that didn't feel right when three of them have their own
multiplexors.

The first five patches can be applied independent of one other,
while patch 6 is optional and can be applied when all others
are merged. Alternatively, they can all go in through the
rtc tree. I compile-tested only the powerpc and sh targets for
which I happened to have cross-compilers installed.

	Arnd
