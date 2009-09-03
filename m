From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 03 Sep 2009 17:41:58 +0200
Subject: Patches for Freescale MXC SoCs and direct ULPI communication [v3]
In-Reply-To: <1251924478-30651-1-git-send-email-daniel@caiaq.de>
References: <1251924478-30651-1-git-send-email-daniel@caiaq.de>
Message-ID: <4A9FE3C6.3050609@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Daniel Mack wrote:
> Sorry for the long delay on this issue.
> 
> Here comes another round of four patches to support the EHCI ports on
> Freescale's MX2/MX3 SoCs.
> 
> The difference to the last version I've sent is that the ISP1504
> specific drivers has become a generic ULPI driver now with all the
> defines renamed.
> 
> Also the driver does not set DRV_VBUS and DRV_VBUS_EXT blindly
> anymore but uses a flags field in the otg_transceiver struct which can
> be specified when creating the device. This allows the adaption of the
> code to a wider variety of applications.
> 
> As a reference, I've added a patch to add board specific support code
> for the lilly1131 module.

I have such a patch for mx31moboard too. Sascha, should I send it to you 
now or wait ?

> 
> Let me know if that still works for other boards and if that version
> looks better to you.

I cannnot say much about the code, it seems that you have addressed all 
the comments on the previous version (especially about the ulpi 
genericity). I can however confirm that it still works well on mx31moboard.

> 
> Again, #1, #2 and #4 are supposed to go thru the USB folks' channel,
> while the rest might be picked by Sascha Hauer eventually.
> 
> Thanks,
> Daniel
> 
> [PATCH 1/5] USB OTG: add support for ulpi connected external transceivers
> [PATCH 2/5] USB OTG: Add generic driver for ULPI OTG transceiver
> [PATCH 3/5] MXC: Add support for ULPI Viewports
> [PATCH 4/5] USB: Add EHCI support for MX27 and MX31 based boards
> [PATCH 5/5] MX3: add USB support for lilly1131

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
