From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon,  4 Apr 2016 17:22:01 -0300
Subject: [PATCH 0/5] Extend the LED panic trigger
Message-ID: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per commit 916fe61995 ("leds: trigger: Introduce a kernel panic LED
trigger"), the kernel now supports a new LED trigger to hook on
the panic blink.

However, the only way of using this is to dedicate a LED device
to this function.

To overcome this limitation, the present series introduces the
capability to switch the LED trigger of certain LED devices upon
a kernel panic (using the panic notifier).

The decision of which LEDs should be switched to the panic trigger
is left to each LED device driver. As an example, a devicetree
boolean property is introduced and used in the leds-gpio driver.

Feedback and other ideas on how to implement this are most welcomed.

Ezequiel Garcia (5):
  leds: triggers: Allow to switch the trigger to "panic" on a kernel
    panic
  leds: triggers: Add a led_trigger_event_nosleep API
  leds: trigger: panic: Use led_trigger_event_nosleep
  devicetree: leds: Introduce "panic-blink" optional property
  leds: gpio: Support the panic-blink firmware property

 Documentation/devicetree/bindings/leds/common.txt |  2 +
 drivers/leds/led-triggers.c                       | 78 +++++++++++++++++++++--
 drivers/leds/leds-gpio.c                          |  4 ++
 drivers/leds/trigger/ledtrig-panic.c              |  2 +-
 include/linux/leds.h                              |  6 ++
 5 files changed, 87 insertions(+), 5 deletions(-)

-- 
2.7.0
