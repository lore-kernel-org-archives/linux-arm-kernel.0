From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 31 May 2014 21:03:30 +0200
Subject: [PATCH v2 0/4] mmc: Add SDIO function devicetree subnode parsing
Message-ID: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of my submission of Sascha Hauer's
"mmc: Add SDIO function devicetree subnode parsing" patch.

This version has been reworked as a result of the discussion about sdio
powerup sequencing. Specifically the location of the per sdio-function subnodes
has been moved from being a subnode under the mmc host, to being a subnode
under the mmc-slot node (which itself is a subnode under the mmc host).

This not only matches the notion of their needing to be a slot abstraction
between the 2 which came up during the powerup discussion, it actually matches
what we are already doing, as while working on this patch-set I learned that
several dt-bindings already use slot child-nodes.

Note this patch-set is not about powerup sequencing, it is related though,
it is about the need to store extra info on sdio devices in devicetree in
general. The specific itch I'm scratching here is getting oob interrupts to
work for sdio wifi modules (which in my case do not need any special powerup).

Changes since v1:
- Submit as a stand-alone patch-set, rather then as part of a larger oob irq
  support patchset crossing multiple subsystems
- Add a patch to document the already existing practice of using slot subnodes
- Split of the dt bindings documentation for sdio-func child nodes into its
  own patch
- Add a preparation patch, setting slot_no where relevant
- And finally the "Add SDIO function devicetree subnode parsing" patch itself
  has been modified to look for the sdio function childnodes under a slot node
  instead of directly under the host node

Regards,

Hans
