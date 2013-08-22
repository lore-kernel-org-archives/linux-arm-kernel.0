From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 22 Aug 2013 16:02:25 +0100
Subject: [Patch v3 0/3] Add CCI PMU support
Message-ID: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here's the third version of patches to support the CCI PMU in the
devicetree and the driver. The patch was split up to better reflect
the split in maintainership between the bindings and the code.

I've addressed all comments raised so far. So if things look fine, I would
like to get Acks from the devicetree maintainers.

Thanks,
Punit

Changes since v2:
(posted at http://article.gmane.org/gmane.linux.ports.arm.kernel/261189)
* Improved the description of value type properties for all CCI nodes.
* Corrected example in bindings to use valid compatible string.
* Tightened the description of CCI PMU interrupts bindings.

Changes since v1:
(posted at http://article.gmane.org/gmane.linux.ports.arm.kernel/259542)
* Dropped requirement for node name.
* Dropped compatible strings for different revisions - rely on peripheral id
  register to provide the revision.
* Change interrupt bindings to require overflow interrupt per counter.

Punit Agrawal (3):
  ARM: dts: Improve CCI bindings documentation.
  ARM: dts: Document the CCI PMU DT bindings
  drivers: CCI: add ARM CCI PMU support

 Documentation/devicetree/bindings/arm/cci.txt |   58 ++-
 drivers/bus/arm-cci.c                         |  628 +++++++++++++++++++++++++
 2 files changed, 683 insertions(+), 3 deletions(-)

-- 
1.7.10.4
