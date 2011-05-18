From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 18 May 2011 16:06:33 +0400
Subject: PXA: Handling of UDC with no VBUS pins
Message-ID: <20110518120633.GA9860@doriath.ww600.siemens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, colleagues,

There are several PXA platforms which on the UDC tranceiver part have
a pullup pin to support connect/disconnect but no VBUS pin to detect
host presense. Currently such platforms are supported through udc driver
itself. I'd like to clean that part of pxa25x_udc/pxa27x_udc drivers and
to move gpio pullup handling to tranceiver.

My question is what would be better: to extend gpio-vbus to work w/o
VBUS pin or to write new transceiver driver only handling gpio-pullup?

-- 
With best wishes
Dmitry
