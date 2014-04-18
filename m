From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Apr 2014 10:08:18 -0700
Subject: [PATCH 1/2] ARM: dts: sbc-t54: add support for sbc-t54 with cm-t54
In-Reply-To: <1396962531-27729-2-git-send-email-lifshitz@compulab.co.il>
References: <1396962531-27729-1-git-send-email-lifshitz@compulab.co.il>
 <1396962531-27729-2-git-send-email-lifshitz@compulab.co.il>
Message-ID: <20140418170818.GI5354@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dmitry Lifshitz <lifshitz@compulab.co.il> [140408 06:14]:
> Add support for CM-T54 CoM and SBC-T54 board:
> 
> http://compulab.co.il/products/computer-on-modules/cm-t54/
> http://compulab.co.il/products/sbcs/sbc-t54/
> 
> SBC-T54 is a single board computer based on OMAP5432 CPU.
> It is implemented with a CM-T54 CoM providing most of the functions,
> and SB-T54 carrier board providing connectors and several additional
> functions.
> 
> Added basic support for:
> 
> * PMIC
> * LED
> * MMC/SD
> * eMMC
> * USB
> * I2C1/4
> * SB-T54 and CM-T54 EEPROMs
> * RTC

You probably want to use the OMAP5_CORE_IOPAD and OMAP5_WKUP_IOPAD
macros for new boards as then you can easily check them against
the TRM based on the physical offset of the register.

Regards,

Tony
