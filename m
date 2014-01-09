From: hdegoede@redhat.com (Hans de Goede)
Date: Thu,  9 Jan 2014 18:57:04 +0100
Subject: [PATCH v3 0/2] ohci and ehci-platform clks, phy and dt support
Message-ID: <1389290226-6971-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v3 of my ohci and ehci-platform clks, phy and dt support patch-set.

This version is mostly the result of some discussions on irc with Maxime to
improve the dt-bindings. This has resulted in 2 changes:

1) Drop the clock-names from the dt-bindings, instead get clocks by index.

Since the intend is to be a generic ohci / ehci driver, the code does not
give any special meaning to any of the clocks, so simply just get as many
clocks as there are by index.

2) Change the compatible string to "mmio-ohci" resp. "mmio-ehci"

v2 was using allwinner,sun4i-ohci as compat string to avoid having to come
up with a generic name, but in retrospect this is the wrong thing to do. This
will likely lead to dts files for non allwinner boards using compatible =
"allwinner,sun4i-ohci", and if we then ever need to do some allwinner specific
quirks, these boards end up getting these quirks applied too.

dts files should use the generic mmio-ehci compatible as least prefered option,
ie: compatible = "allwinner,sun7i-a20-ehci", "mmio-ehci";

This will allow use of the generic driver while leaving the option open to
later add soc specific quirks without needing dt changes.

Regards,

Hans
