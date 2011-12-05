From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 5 Dec 2011 15:23:53 +0100
Subject: [PATCH 0/3] of: Add support for named irq and reg
Message-ID: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant & Rob,

Following the previous patch submission [1], here is an updated series
that adds the support for both reg and irq names.
A small improvement is done as well on the property with multiple strings
helper function.

Please note that I've just realized that Russell's concern with the
/proc/iomem readability might not even be valid in the DT case.
I might be wrong, but it looks like devices created by of_device_alloc
does not seems to call the insert_resource. It means that the /proc/iomem
is mostly empty when the devices are created from device tree blob.
I'm not sure it was done on purpose, but even if this is not the case,
the fact is that this /proc/iomem entry does not seems to be used
extensively.
That does not mean it cannot be improved, but it should change the urgency
to fix that with regards to that series.

This series is based on 3.2-rc4 and is available here:
git://gitorious.org/omap-pm/linux.git for_3.3/resource-names

Comments are welcome.

Auto comment: I'm not super happy with these new properties name because it
is not really consistent. If you have any better idea, do not hesitate.

Thanks,
Benoit


[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg57881.html


Benoit Cousson (3):
  of/base: Take NULL string into account for property with multiple strings
  of/address: Add reg-names property to name an iomem resource
  of/irq: Add interrupts-names property to name an irq resource

 .../devicetree/bindings/interrupts-names.txt       |   50 ++++++++++++++++++++
 Documentation/devicetree/bindings/reg-names.txt    |   48 +++++++++++++++++++
 drivers/of/address.c                               |   16 ++++--
 drivers/of/base.c                                  |    8 +--
 drivers/of/irq.c                                   |   11 ++++-
 5 files changed, 122 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupts-names.txt
 create mode 100644 Documentation/devicetree/bindings/reg-names.txt
