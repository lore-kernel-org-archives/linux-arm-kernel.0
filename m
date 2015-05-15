From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 15 May 2015 11:50:37 +0200
Subject: [PATCH v3 0/6] Add dwc3 usb3 DT node and various phy cleanup
In-Reply-To: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
References: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <5555C16D.9020906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 04/30/2015 03:30 PM, Peter Griffin wrote:
> Hi Maxime,
>
> This series primarily adds the dwc3 DT node which activates the usb3 controller on
> the stih407-b2120, stih410-b2120 and stih418-b2199 platforms.
>
> As part of getting this working I noticed an error with the picophyreset which
> stops the controller working which I've also fixed.
>
> regards,
>
> Peter.
>
> Changes in v3:
> - Add miphys8lp options properties for stih418 (Pete)
> - Add support for stih418-b2199 (Max)
> - Only enable usb3 controller in the board file (Max)
> - Fix superflous '\n' (Lee)
> - Rebase series on v4.1-rc1 (Pete)
>
> NB: Since v2 some patches were taken into the phy and ahci trees which I've now
> removed from the series.
>
> Changes in v2:
> - Update commit to explicitly say no ABI breakage (Rob)
> - Rebase series on v4.0-rc6 (Pete)
> - Collect up Acks (Pete)
>
> Peter Griffin (6):
>    ARM: DT: STi: STiH407: Update picophyreset for the usb3 controllers
>      usb2 phy
>    ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
>    usb: dwc3: dwc3-st: Update the incorrect DT dwc3 example.
>    ARM: DT: STi: stihxxx-b2120: Enable USB3 port on stih407-b2120 and
>      stih410-b2120
>    ARM: DT: STi: STiH418: Add miphy28lp optional oscillator clock
>      properties
>    ARM: DT: STi: STiH418: Enable USB3 port on stih418-b2199.
>
>   Documentation/devicetree/bindings/usb/dwc3-st.txt |  7 +++---
>   arch/arm/boot/dts/stih407-family.dtsi             | 30 ++++++++++++++++++++++-
>   arch/arm/boot/dts/stih418-b2199.dts               | 15 ++++++++++++
>   arch/arm/boot/dts/stihxxx-b2120.dtsi              |  5 ++++
>   4 files changed, 52 insertions(+), 5 deletions(-)
>

All DT patches of the series applied to STi DT branch for v4.2.

Thanks!
Maxime
