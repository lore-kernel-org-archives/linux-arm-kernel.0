From: laura@labbott.name (Laura Abbott)
Date: Mon, 16 Nov 2015 16:57:32 -0800
Subject: [PATCHv2 0/3] Devicetree bindings for Ion
Message-ID: <1447721855-7574-1-git-send-email-laura@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi,

This is another attempt at devicetree bindings for Ion. The big complaint from
v1 was that too much unnecessary data was being pushed into devicetree.
v2 takes a different approach of using just compatbile strings for the heaps.
This gets closer to the devicetree philosophy of describing just the hardware.
Each heap ultimately represents some kind of memory that exists in the system.
The compatible string indicates the match for how to handle the type of memory
on this system. The details like heap-id, name etc. are now pushed out to C
files. This makes Ion heaps look closer to something like a quirks framework.
(I'd argue this isn't a complete mischaracterization given the type of setup
Ion gets used for...) The one downside here is that this leads to more new
bindings for each board that gets added.

This version also includes a sample C file which shows what the structure
might look like. As always, your comments and reviews are appreciated.

Thanks,
Laura

Laura Abbott (3):
  ion: Devicetree bindings for Ion
  staging: ion: Add files for parsing the devicetree (WIP)
  NOMERGE: Sample driver

 drivers/staging/android/ion/Kconfig         |  16 +++
 drivers/staging/android/ion/Makefile        |   2 +
 drivers/staging/android/ion/devicetree.txt  |  50 +++++++++
 drivers/staging/android/ion/ion_of.c        | 168 ++++++++++++++++++++++++++++
 drivers/staging/android/ion/ion_of.h        |  35 ++++++
 drivers/staging/android/ion/ion_of_sample.c |  96 ++++++++++++++++
 6 files changed, 367 insertions(+)
 create mode 100644 drivers/staging/android/ion/devicetree.txt
 create mode 100644 drivers/staging/android/ion/ion_of.c
 create mode 100644 drivers/staging/android/ion/ion_of.h
 create mode 100644 drivers/staging/android/ion/ion_of_sample.c

-- 
2.5.0
