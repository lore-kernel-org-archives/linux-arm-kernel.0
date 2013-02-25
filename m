From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 25 Feb 2013 09:17:01 +0100
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130225081701.GO1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 07:51:25PM +0800, Shawn Guo wrote:
> Changes since v1:
>  * Remove the absolute path of imxXX-pinfunc.h in binding doc
>  * Remove the pin id from PIN_FUNC_ID/macro
> 
> Shawn Guo (3):
>   ARM: dts: imx: use pre-processor for device trees
>   ARM: dts: imx: replace magic number with pin function name
>   pinctrl: imx: move hard-coding data into device tree

Looks good to me. The patches are really *huge*. Does it make sense to
make 2/3 and 3/3 a single patch to make the churn smaller?

Sascha

> 
>  .../bindings/pinctrl/fsl,imx-pinctrl.txt           |    6 +-
>  .../bindings/pinctrl/fsl,imx35-pinctrl.txt         |  955 +--------
>  .../bindings/pinctrl/fsl,imx51-pinctrl.txt         |  759 +------
>  .../bindings/pinctrl/fsl,imx53-pinctrl.txt         | 1174 +---------
>  .../bindings/pinctrl/fsl,imx6q-pinctrl.txt         | 1596 +-------------
>  .../{imx25-karo-tx25.dts => imx25-karo-tx25.dtsp}  |    2 +-
>  .../arm/boot/dts/{imx25-pdk.dts => imx25-pdk.dtsp} |    2 +-
>  arch/arm/boot/dts/{imx25.dtsi => imx25.dtsip}      |    2 +-
>  .../boot/dts/{imx27-apf27.dts => imx27-apf27.dtsp} |    2 +-
>  .../arm/boot/dts/{imx27-pdk.dts => imx27-pdk.dtsp} |    2 +-
>  ...hytec-phycore.dts => imx27-phytec-phycore.dtsp} |    2 +-
>  arch/arm/boot/dts/{imx27.dtsi => imx27.dtsip}      |    2 +-
>  .../arm/boot/dts/{imx31-bug.dts => imx31-bug.dtsp} |    2 +-
>  arch/arm/boot/dts/{imx31.dtsi => imx31.dtsip}      |    2 +-
>  arch/arm/boot/dts/imx35-pinfunc.h                  |  970 +++++++++
>  .../boot/dts/{imx51-apf51.dts => imx51-apf51.dtsp} |    2 +-
>  .../dts/{imx51-babbage.dts => imx51-babbage.dtsp}  |   16 +-
>  arch/arm/boot/dts/imx51-pinfunc.h                  |  773 +++++++
>  arch/arm/boot/dts/{imx51.dtsi => imx51.dtsip}      |  247 +--
>  .../arm/boot/dts/{imx53-ard.dts => imx53-ard.dtsp} |   70 +-
>  .../arm/boot/dts/{imx53-evk.dts => imx53-evk.dtsp} |   18 +-
>  arch/arm/boot/dts/imx53-mba53.dts                  |  129 --
>  arch/arm/boot/dts/imx53-mba53.dtsp                 |  135 ++
>  arch/arm/boot/dts/imx53-pinfunc.h                  | 1189 ++++++++++
>  .../arm/boot/dts/{imx53-qsb.dts => imx53-qsb.dtsp} |   22 +-
>  .../arm/boot/dts/{imx53-smd.dts => imx53-smd.dtsp} |   16 +-
>  .../dts/{imx53-tqma53.dtsi => imx53-tqma53.dtsip}  |   32 +-
>  arch/arm/boot/dts/{imx53.dtsi => imx53.dtsip}      |  207 +-
>  arch/arm/boot/dts/{imx6dl.dtsi => imx6dl.dtsip}    |    0
>  .../boot/dts/{imx6q-arm2.dts => imx6q-arm2.dtsp}   |    8 +-
>  arch/arm/boot/dts/imx6q-pinfunc.h                  | 1529 +++++++++++++
>  .../{imx6q-sabreauto.dts => imx6q-sabreauto.dtsp}  |    6 +-
>  .../{imx6q-sabrelite.dts => imx6q-sabrelite.dtsp}  |   18 +-
>  .../dts/{imx6q-sabresd.dts => imx6q-sabresd.dtsp}  |   14 +-
>  arch/arm/boot/dts/imx6q.dtsi                       |  302 ---
>  arch/arm/boot/dts/imx6q.dtsip                      |  303 +++
>  arch/arm/boot/dts/{imx6qdl.dtsi => imx6qdl.dtsip}  |    2 +-
>  drivers/pinctrl/pinctrl-imx.c                      |  120 +-
>  drivers/pinctrl/pinctrl-imx.h                      |   13 +-
>  drivers/pinctrl/pinctrl-imx35.c                    | 1524 +++----------
>  drivers/pinctrl/pinctrl-imx51.c                    | 1252 +++--------
>  drivers/pinctrl/pinctrl-imx53.c                    | 1579 ++------------
>  drivers/pinctrl/pinctrl-imx6q.c                    | 2263 +++-----------------
>  43 files changed, 6284 insertions(+), 10983 deletions(-)
>  rename arch/arm/boot/dts/{imx25-karo-tx25.dts => imx25-karo-tx25.dtsp} (96%)
>  rename arch/arm/boot/dts/{imx25-pdk.dts => imx25-pdk.dtsp} (96%)
>  rename arch/arm/boot/dts/{imx25.dtsi => imx25.dtsip} (99%)
>  rename arch/arm/boot/dts/{imx27-apf27.dts => imx27-apf27.dtsp} (98%)
>  rename arch/arm/boot/dts/{imx27-pdk.dts => imx27-pdk.dtsp} (96%)
>  rename arch/arm/boot/dts/{imx27-phytec-phycore.dts => imx27-phytec-phycore.dtsp} (98%)
>  rename arch/arm/boot/dts/{imx27.dtsi => imx27.dtsip} (99%)
>  rename arch/arm/boot/dts/{imx31-bug.dts => imx31-bug.dtsp} (96%)
>  rename arch/arm/boot/dts/{imx31.dtsi => imx31.dtsip} (98%)
>  create mode 100644 arch/arm/boot/dts/imx35-pinfunc.h
>  rename arch/arm/boot/dts/{imx51-apf51.dts => imx51-apf51.dtsp} (97%)
>  rename arch/arm/boot/dts/{imx51-babbage.dts => imx51-babbage.dtsp} (94%)
>  create mode 100644 arch/arm/boot/dts/imx51-pinfunc.h
>  rename arch/arm/boot/dts/{imx51.dtsi => imx51.dtsip} (61%)
>  rename arch/arm/boot/dts/{imx53-ard.dts => imx53-ard.dtsp} (55%)
>  rename arch/arm/boot/dts/{imx53-evk.dts => imx53-evk.dtsp} (82%)
>  delete mode 100644 arch/arm/boot/dts/imx53-mba53.dts
>  create mode 100644 arch/arm/boot/dts/imx53-mba53.dtsp
>  create mode 100644 arch/arm/boot/dts/imx53-pinfunc.h
>  rename arch/arm/boot/dts/{imx53-qsb.dts => imx53-qsb.dtsp} (89%)
>  rename arch/arm/boot/dts/{imx53-smd.dts => imx53-smd.dtsp} (88%)
>  rename arch/arm/boot/dts/{imx53-tqma53.dtsi => imx53-tqma53.dtsip} (75%)
>  rename arch/arm/boot/dts/{imx53.dtsi => imx53.dtsip} (69%)
>  rename arch/arm/boot/dts/{imx6dl.dtsi => imx6dl.dtsip} (100%)
>  rename arch/arm/boot/dts/{imx6q-arm2.dts => imx6q-arm2.dtsp} (90%)
>  create mode 100644 arch/arm/boot/dts/imx6q-pinfunc.h
>  rename arch/arm/boot/dts/{imx6q-sabreauto.dts => imx6q-sabreauto.dtsp} (88%)
>  rename arch/arm/boot/dts/{imx6q-sabrelite.dts => imx6q-sabrelite.dtsp} (87%)
>  rename arch/arm/boot/dts/{imx6q-sabresd.dts => imx6q-sabresd.dtsp} (84%)
>  delete mode 100644 arch/arm/boot/dts/imx6q.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6q.dtsip
>  rename arch/arm/boot/dts/{imx6qdl.dtsi => imx6qdl.dtsip} (99%)
> 
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
