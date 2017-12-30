From: contact@paulk.fr (Paul Kocialkowski)
Date: Sat, 30 Dec 2017 16:23:27 +0100
Subject: [PATCH 0/3] axp20x backup battery charging
Message-ID: <20171230152330.28946-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces support for axp20x backup battery charging, with
a dedicated device-tree property.

I wondered whether to include this in a power-supply driver or not.
Since it does not, in fact, supply power to the whole system and
because no status changes over time, I thought it would be inappropriate
to craft a power supply driver only for this.
I also wondered whether to stick this into an existing power-supply
driver, as is done by e.g. twl4030, but we have two distinct supply
drivers for the axp20x (ac and usb), that may be used together or not.
Also, the backup battery isn't tied to the power supply anyway.

This is why I thought it would make more sense to put this in the mfd
driver directly. What do you think?
