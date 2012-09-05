From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 5 Sep 2012 15:44:42 +0000 (UTC)
Subject: OMAP baseline test results for v3.6-rc4
Message-ID: <alpine.DEB.2.00.1209051523340.11516@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic boot and power management test results for v3.6-rc4:

    http://www.pwsan.com/omap/testlogs/test_v3.6-rc4/20120904122415/

Some observations:

* N800: panics during kernel init
  - This is caused by an MMC driver bug; fixed by "[PATCH] MMC: OMAP MSDI: 
    fix broken PIO mode", available from here:
    http://www.spinics.net/lists/arm-kernel/msg190879.html

* CM-T3517: L3 in-band error with USB OTG during boot
  - Cause unknown; longstanding issue; does not occur on the 3517EVM

* 37xx EVM: CORE not entering dynamic off-idle
  - Cause unknown; dynamic retention-idle seems to work; system suspend to 
    off works

* 4430ES2 Panda: CORE, L4PER, L3INIT, TESLA, IVAHD not going idle
  - Cause unknown; may be partially due to McPDM reset problem

(The objective in posting these is to determine what is and isn't working 
in the mainline releases, as well as to make it easier to determine what 
is fixed or is broken by subsequent series that use this as a base.)


- Paul
