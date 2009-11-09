From: bart.cerneels@gmail.com (Bart Cerneels)
Date: Mon, 9 Nov 2009 16:46:01 +0100
Subject: AT91 MCI SDIO transfers
Message-ID: <dd7ac1430911090746x76ad85c2kd022907ac20c7e6b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM developers, this is an Atmel AT91 MMC/SD host controller question.

I'm having a serious issue with response timeouts and unknown events
while using a marvell 8385 based SDIO wifi module. It's supported by
the libertas-sdio driver.

I have this problem originally with linux 2.6.28 but it's also
reproducible with 2.6.31.

Since the same wifi module with the exact same driver (libertas) and
binary firmware is working perfectly on my PC (ubuntu 9.10 2.6.31.4),
this can only be a host-controller problem.

As far as I can tell the quirks of the AT91-MCI as listed in the
errata are handled. But there is one major thing that I don't
understand:
The AT91 MCI has special transfer types for SDIO ( bit 3 in TRTYP in
MCI_CMDR) but reading through at91_mci.c this is never being used.

I assume the hardware has this for a reason, perhaps there is some
special handling going on specific to SDIO?

Should I continue to investigate this or does SDIO indeed work
correctly without using these transfer types?

Bart
