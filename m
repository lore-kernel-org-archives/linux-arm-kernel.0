From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 14 Dec 2017 17:06:25 +0100
Subject: [RFC PATCH 0/7] gpiolib: add bias support
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171214160625.GG19186@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I have not introduced a gpiod_set_bias() because I think the only place to
> setup this is in the device tree. It's useless to setup a bias pull up if there
> is an external pull up on the board.

Hi Ludovic

I have a use case where having gpiod_set_bias() would be good. The
DLN2 is a USB device, which offers GPIO, I2C, and SPI services on its
pins. It is a hot pluggable device, and i'm using it on Intel
machines, making it double hard to use with Device Tree.

It would be good to be able to set the pull up/down on the GPIO pins,
probably from a small kernel module which calls gpiod_set_bias(), or
via /sysfs.

    Andrew
