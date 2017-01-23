From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:32:35 +0100
Subject: [PATCH 00/16] arm: dts: extend mt7623 support
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1187ee6f-e929-de5d-344b-2d20e36adff0@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/01/2017 12:29, John Crispin wrote:
> This series extends the dts files used for booting mt7623 base boards.
> Since support for mt7623 was added around v4.6, many new drivers have
> been accepted upstream. The contained patches add several of these to
> the devicetree.
> 
> Additionally the series does a bit of refactoring. MTK/WCN pointed out
> that the evaluation board is infact a reference design and asked the the
> evb files be renamed to rfb.
> 
> As with all of the current ARM bases MTK silicon, these boards also have
> a PMIC. Instead of adding the nodes to all of the dts files, we add an
> intermediate dtsi file that contains the required nodes. This allows us
> to reduce the size of the top most dts files.
> 
> The RFB comes in various versions and asiarf has even done a crowdfunder
> to sell them. We should try to reduce the duplication. This series adds
> a common dtsi file for these boards. This results in the topmost dts files
> only needing to specify the compatible string, MTD nodes and ethernet setup.
> 

Hi,

i have a 2nd series in the making which makes the following things work,
just in case anyone else is also working on this, let me know so that we
don't duplicate any of the work.

* pcie
* cpufreq
* mt7623a RFB
* ethernet
* spi-nor
* PWM

	John


> John Crispin (16):
>   arm: dts: add clock controller device nodes
>   arm: dts: add subsystem clock controller device nodes
>   arm: dts: add power domain controller device node
>   arm: dts: add clock-frequency to the a7 timer node to mt7623.dtsi
>   arm: dts: add pinctrl nodes to the mt7623 dtsi file
>   arm: dts: add pmic nodes to the mt7623 dtsi file
>   arm: dts: add i2c nodes to the mt7623.dtsi file
>   arm: dts: add spi nodes to the mt7623.dtsi file
>   arm: dts: add nand nodes to the mt7623.dtsi file
>   arm: dts: add mmc nodes to the mt7623.dtsi file
>   arm: dts: add usb nodes to the mt7623.dtsi file
>   arm: dts: add mt7623-mt6323.dtsi file
>   arm: dts: rename mt7623-evb.dts to arch/arm/boot/dts/mt7623n-rfb.dtsi
>   arm: dts: cleanup the mt7623n rfb uart nodes
>   arm: dts: enable the usb device on the mt7623n rfb
>   arm: dts: enable the nand device on the mt7623n nand rfb
> 
>  Documentation/devicetree/bindings/arm/mediatek.txt |    4 +-
>  arch/arm/boot/dts/Makefile                         |    2 +-
>  arch/arm/boot/dts/mt7623-evb.dts                   |   33 ---
>  arch/arm/boot/dts/mt7623-mt6323.dtsi               |  273 ++++++++++++++++++
>  arch/arm/boot/dts/mt7623.dtsi                      |  297 +++++++++++++++++++-
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts             |  109 +++++++
>  arch/arm/boot/dts/mt7623n-rfb.dtsi                 |   61 ++++
>  7 files changed, 730 insertions(+), 49 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/mt7623-evb.dts
>  create mode 100644 arch/arm/boot/dts/mt7623-mt6323.dtsi
>  create mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
>  create mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
> 
