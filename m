From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Apr 2012 15:33:50 +0200
Subject: [PATCHv2] Add ADC driver for G20 and G45 evaluation boards
Message-ID: <1334756036-15944-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is the improved version of what I've been posting some time ago.
Some things changed since last version:
  - Support for Hardware triggers for the G20 has been added
  - Support for the AT91SAM9M10G45 board has been added too, both for
    software and hardware triggers
  - The driver is now in drivers/staging/iio to include all these features.

The first three patches should not have changed much since last post, so it
should be pretty ok.

Changes since v1:
  - Added DT bindings
  - Removed the clock_name field and used adc_clk instead. Used CLKDEV_CON_ID
    for the G45.
  - Misc fixes:
    * Added clk_prepare
    * Replaced kcalloc by devm_kzalloc for the trigger allocation

Thanks,
Maxime
