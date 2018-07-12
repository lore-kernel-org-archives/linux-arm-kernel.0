From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 12 Jul 2018 14:36:08 +0100
Subject: RFC: tegra2/tegra3 automotive part changes
Message-ID: <3916c0ea-964e-42ab-8bfd-8e8edc5110ee@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, we are looking at up-streaming some of the work we have
done on the tegra2 and tegra3 automotive devices. The automotive
grade devices are close the commercial parts so we would like to
discuss the core changes before submitting.

The changes are mostly with things like the clock setup and a
few peripheral quirks (IIRC these are mostly MMC).

We are proposing to change the device-tree properties for the root
node and any other affected devices from "nvidia,tegraXX" to a new
"nvidia,tegraXXa". We would welcome discussion on whether to update
all the devices at the start

An example of tegra30a.dtsi:

#include "tegra30.dtsi"

/ {
         compatible = "nvidia,tegra30a";

         clock at 60006000 {
                 compatible = "nvidia,tegra30a-car";
         };
}

We don't think the changes are big enough to warrant their own
Kconfig/defconfig updates.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
