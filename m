From: davem@davemloft.net (David Miller)
Date: Thu, 29 Sep 2016 01:50:38 -0400 (EDT)
Subject: [PATCH 0/3] [v2] Add basic ACPI support to the Qualcomm
 Technologies EMAC driver
In-Reply-To: <1475081924-12362-1-git-send-email-timur@codeaurora.org>
References: <1475081924-12362-1-git-send-email-timur@codeaurora.org>
Message-ID: <20160929.015038.2293483616753188761.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Timur Tabi <timur@codeaurora.org>
Date: Wed, 28 Sep 2016 11:58:41 -0500

> This patch series adds support to the EMAC driver for extracting addresses,
> interrupts, and some _DSDs (properties) from ACPI.  The first two patches
> clean up the code, and the third patch adds ACPI-specific functionality.
> 
> The first patch fixes a bug with handling the platform_device for the
> internal PHY.  This phy is treated as a separate device in both DT and
> ACPI, but since the platform is not released automatically when the 
> driver unloads, managed functions like devm_ioremap_resource cannot be
> used. 
> 
> The second patch replaces of_get_mac_address with its platform-independent
> equivalent device_get_mac_address.  
> 
> The third patch parses the ACPI tables to obtain the platform_device for
> the primary EMAC node ("QCOM8070") and the internal phy node ("QCOM8071").

Series applied, thanks.
