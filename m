From: slash.tmp@free.fr (Mason)
Date: Tue, 1 Aug 2017 18:32:21 +0200
Subject: [RFC PATCH v2 0/2] nb8800 suspend/resume support
Message-ID: <33d1ab47-6098-5e3f-8a3c-f72626d07113@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I need suspend/resume support in the nb8800 driver.
On tango platforms, suspend loses all context (MMIO registers).
To make the task easy, we just close the device on suspend,
and open it again on resume. This requires properly resetting
the HW on resume.

Patch 1 moves all the HW init to nb8800_init()
Patch 2 adds suspend/resume support

Regards.
