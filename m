From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Jun 2013 15:39:03 +0100
Subject: [PATCH 0/3] ARM: kernel: minor topology/DT clock fixes
Message-ID: <1371739146-32639-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Following the initial patch:
1371635237-22860-1-git-send-email-f.fainelli at gmail.com

here is a more complete series of fixes to address the clocks/clock-frequency
parsing in the ARM kernel topology code. Note that some in-tree platforms for
which the topology code was enabled will issue the warning from patch 3. This
is done on purpose such that they get a chance to be fixed, either by adding
common clock support, or by adding a valid "clock-frequency" property.

Florian Fainelli (3):
  ARM: kernel: get cpu clock rate from cpu clock node first
  ARM: kernel: downgrade missing clock-frequency from error to warning
  ARM: kernel: document ARM CPUs clocks and clock-frequency properties

 Documentation/devicetree/bindings/arm/cpus.txt |  7 ++++++-
 arch/arm/kernel/topology.c                     | 23 ++++++++++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

-- 
1.8.1.2
