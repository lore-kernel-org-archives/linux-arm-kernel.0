From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 08 Aug 2017 20:26:57 +0800
Subject: [PATCH v3 0/4] thermal: add brcmstb AVS TMON driver
In-Reply-To: <a29d8aef-8d24-9e63-c078-48c3a1a6fccf@gmail.com>
References: <20170731192633.58747-1-code@mmayer.net>
 <a29d8aef-8d24-9e63-c078-48c3a1a6fccf@gmail.com>
Message-ID: <1502195217.4296.33.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-08-07 at 10:52 -0700, Florian Fainelli wrote:
> On 07/31/2017 12:26 PM, Markus Mayer wrote:
> > 
> > From: Markus Mayer <mmayer@broadcom.com>
> > 
> > This series adds the brcmstb AVS TMON driver.
> > 
> > The driver was originally written by Brian Norris.
> > 
> > v1 of this series can be found at https://lkml.org/lkml/2017/6/5/92
> > 1
> > v2 of this series can be found at https://lkml.org/lkml/2017/7/21/5
> > 85
> FWIW, this looks good to me, Eduardo, Rui, can we get this moving?
> 
Usually, Eduardo will take the arm soc thermal patches. But he is not
able to take it this time as he is really busy.
To me, the thermal framework related code looks good, and I will queue
it for next merge window, although I don't have the knowledge about the
hardware details.

thanks,
rui

> > 
> > 
> > Changes since v2:
> > - replaced calls to pr_debug() with calls to dev_dbg() [PATCH 2/4
> > only]
> > - all other patches are unchanged from v2
> > 
> > Changes since v1:
> > - Fixed wording in binding document
> > - Fixed lincensing to consistently mention GPL v2
> > - Use thermal_zone_get_slope() and thermal_zone_get_offset()
> > - Some minor clean-ups
> > 
> > Brian Norris (2):
> > ? Documentation: devicetree: add binding for Broadcom STB AVS TMON
> > ? thermal: add brcmstb AVS TMON driver
> > 
> > Markus Mayer (2):
> > ? ARM: multi_v7_defconfig: add CONFIG_BRCMSTB_THERMAL
> > ? arm64: defconfig: add CONFIG_BRCMSTB_THERMAL
> > 
> > ?.../devicetree/bindings/thermal/brcm,avs-tmon.txt??|??20 ++
> > ?MAINTAINERS????????????????????????????????????????|???8 +
> > ?arch/arm/configs/multi_v7_defconfig????????????????|???1 +
> > ?arch/arm64/configs/defconfig???????????????????????|???1 +
> > ?drivers/thermal/Kconfig????????????????????????????|???2 +-
> > ?drivers/thermal/broadcom/Kconfig???????????????????|???7 +
> > ?drivers/thermal/broadcom/Makefile??????????????????|???1 +
> > ?drivers/thermal/broadcom/brcmstb_thermal.c?????????| 386
> > +++++++++++++++++++++
> > ?8 files changed, 425 insertions(+), 1 deletion(-)
> > ?create mode 100644
> > Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
> > ?create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c
> > 
> 
