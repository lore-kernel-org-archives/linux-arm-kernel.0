From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 28 Oct 2010 11:49:06 -0400
Subject: [PATCH v4 01/12] misc: add driver for sequencer serial port
In-Reply-To: <1288124308-14999-2-git-send-email-cyril@ti.com>
References: <1288124308-14999-1-git-send-email-cyril@ti.com>
	<1288124308-14999-2-git-send-email-cyril@ti.com>
Message-ID: <AANLkTi=rDep3jkp2QAjVsgjZ7JQ0ysnse4TARv29fyHm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/26 Cyril Chemparathy <cyril@ti.com>:

> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> device. ?It has a built-in programmable execution engine that can be programmed
> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
>
> This patch adds a driver for this controller device. ?The driver does not
> expose a user-land interface. ?Protocol drivers built on top of this layer are
> expected to remain in-kernel.

Why is this thing in drivers/misc?

drivers/mfd is IMHO the apropriate place for a driver like this, and
the subdrivers should be migrated to use mfd cells and platform
drivers for the subdevices.

All functions and abstractions you create here look suspiciously
lot like other MFD devices.

But please, beat me up if I'm wrong!

Yours,
Linus Walleij
