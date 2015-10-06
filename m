From: labbott@fedoraproject.org (Laura Abbott)
Date: Tue,  6 Oct 2015 13:47:11 -0700
Subject: [RFC][PATCH 0/2] Devicetree bindings for Ion
Message-ID: <1444164433-9107-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laura Abbott <laura@labbott.name>


Hi,

At the last Plumbers and Linaro Connect, there was some discussion
related to Ion. One of the items that came up towards eventually
getting Ion out of staging was some concept of stable devicetree
bindings. This is a proof of concept for bindings.

Most of this is based on previously submitted work
(https://lkml.org/lkml/2015/6/30/425 thank you Andrew Andrianov for
getting this started!) and also the
out of tree qcom bindings (available somewhere on codeaurora.org).
As the title indicates, this is an RFC and the purpose here is to
get feedback on if these bindings would potentially work. If there
are platforms out there that don't use devicetree, the bindings
would hopefully also serve as a guide for how to setup the platform
data for heaps like CMA.

One of the big things this series improves on is giving a standard
mechanism for defining and allocating memory for all heap types.
DMA/CMA is handled as well as memory for carveout and chunk heaps.

Further TODO:
- Need to fixup include paths so heap types can be cleanly included
  in DTS files
- Figure out callbacks or similar for support custom platform heaps

Laura Abbott (2):
  WIP: Devicetree bindings for Ion
  staging: ion: Add files for parsing the devicetree (WIP)

 drivers/staging/android/ion/Kconfig        |  10 ++
 drivers/staging/android/ion/Makefile       |   7 +-
 drivers/staging/android/ion/devicetree.txt |  53 +++++++++
 drivers/staging/android/ion/ion_of.c       | 185 +++++++++++++++++++++++++++++
 drivers/staging/android/ion/ion_of.h       |   3 +
 5 files changed, 255 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/android/ion/devicetree.txt
 create mode 100644 drivers/staging/android/ion/ion_of.c
 create mode 100644 drivers/staging/android/ion/ion_of.h

-- 
2.4.3
