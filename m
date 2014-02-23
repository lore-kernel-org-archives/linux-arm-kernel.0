From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Feb 2014 13:09:08 +0100
Subject: [PATCH v3 0/4] ARM: sunxi: Add driver for sunxi usb phy + usb dts
 bindings
Message-ID: <1393157352-21104-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon, Maxime,

Here is v3 of my sunxi-usb-phy driver it addresses all review remarks made
in response to v2, and as such this should be the final version, changes:

-Fix check for wrong variable in error handling path pointed out by wens
-Switch to using reg-names to differentiate between the different register
 ranges needed

Kishon, can you please queue up the 1st patch of this series for 3.15 ?

Maxime, can you please add patches 2-4 to your dt-for-3.15 branch? Note these
are only the dtsi bits.

I'm holding back all the board .dts patches until it is clear how we want to
deal with the ahci + usb regulator bits. Specifically I'm waiting for an answer
to this question:

"I hope this helps explain my reasoning, as said I'm fine with
either way, if you want to change over to a single file +
explicit enabling, let me know and I'll respin the ahci dts
patches.  Note I'm going on vacation for a week starting Monday,
so you likely won't get a new version until next weekend."

In my last reply to "[PATCH v6 17/18] ARM: sun4i: dt: Add ahci / sata support"

I've a feeling you (Maxime) want me to rework things in to a single dtsi
for all common regulators + explicit enabling, which works for me, but before
doing the necessary refactoring I would like to hear that this is what you
want from you.

Regards,

Hans


p.s.

I'm going on vacation for 5 days leaving tomorrow, so I won't send the
(refactored) board .dts file patches until next weekend.
