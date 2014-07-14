From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 14 Jul 2014 11:01:47 +0530
Subject: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
In-Reply-To: <53BE926A.2070005@ti.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
 <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
 <53BE926A.2070005@ti.com>
Message-ID: <CAKohpo=aoWgQseciOiZcYqupKZyz5eMFNA4A+VRSHoCbQuqeGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2014 18:47, Kishon Vijay Abraham I <kishon@ti.com> wrote:

>> diff --git a/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
>> new file mode 100644
>> index 0000000..b9b281a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
>
> We generally create a single document for a SoC vendor. So just use st-phy.txt.

st-phy may not be appropriate as this is specifically for SPEAr. New
binding doc looks like this:

diff --git a/Documentation/devicetree/bindings/phy/st-spear-miphy.txt
b/Documentation/devicetree/bindings/phy/st-spear-miphy.txt
new file mode 100644
index 0000000..2a6bfdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st-spear-miphy.txt
@@ -0,0 +1,15 @@
+ST SPEAr miphy DT details
+=========================
+
+ST Microelectronics SPEAr miphy is a phy controller supporting PCIe and SATA.
+
+Required properties:
+- compatible : should be "st,spear1310-miphy" or "st,spear1340-miphy"
+- reg : offset and length of the PHY register set.
+- misc: phandle for the syscon node to access misc registers
+- #phy-cells : from the generic PHY bindings, must be 1.
+       - cell[1]: 0 if phy used for SATA, 1 for PCIe.
+
+Optional properties:
+- phy-id: Instance id of the phy. Only required when there are multiple phys
+  present on a implementation.
