From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Fri, 18 Dec 2015 15:13:48 +0100
Subject: [Regression] No display on i.MX53 after update to 4.4-rc4
Message-ID: <5674149C.90206@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

after updating my kernel to include:

     gpu: ipu-v3: Assign of_node of child platform devices to 
corresponding ports  [304e6be652e2ef2190adf9c23a2a1e5f9f39800d]

the display initialisation fails with:

     "imx-ipuv3 18000000.ipu: missing port at 0 node in /soc/ipu at 18000000"

Indeed the in tree imx53.dtsi file does not contain that node.

Does the node need to be added (even if the camera is not being used) or 
should ipu_add_client_devices() not bail out if one node is missing?

Regards,

Martin
