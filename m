From: stefan@agner.ch (Stefan Agner)
Date: Sat, 18 Jun 2016 21:20:05 -0700
Subject: [PATCH 1/3] ARM: dts: imx7d: create i.MX 7Solo base device tree
In-Reply-To: <20160612013526.GV20243@tiger>
References: <20160608023709.32090-1-stefan@agner.ch>
 <20160608023709.32090-2-stefan@agner.ch> <20160612013526.GV20243@tiger>
Message-ID: <9d870fb1be40772a50f08d467df048dc@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-06-11 18:35, Shawn Guo wrote:
> On Tue, Jun 07, 2016 at 07:37:07PM -0700, Stefan Agner wrote:
>> The i.MX 7 series currently consists of two SoCs: i.MX 7Solo and
>> 7Dual. The i.MX 7Solo implements a subset of features available on
>> i.MX 7Dual, hence create imx7s.dtsi as the base device tree. The
>> i.MX 7Dual's additional features over i.MX 7Solo are:
>> - Second Cortex-A7 core
>> - Second Gigabit Ethernet controller
>> - EPD (Electronc Paper Display, not yet part of the device tree)
>> - PCIe (not yet part of the device tree)
>> - Additional USB2.0 OTG controller
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/boot/dts/imx7d.dtsi | 923 +++----------------------------------------
>>  arch/arm/boot/dts/imx7s.dtsi | 880 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 928 insertions(+), 875 deletions(-)
> 
> We should probably have a beforehand patch to rename the file, so that
> we can avoid this dramatic diffstat.

If I delete imx7d.dtsi and add imx7s.dtsi in a single commit, and then
readd imx7d.dtsi in a second commit, it would break bisect-ability. All
existing device trees which include imx7d.dtsi would fail to build.

As soon as I keep imx7d.dtsi around, even if it only includes
imx7s.dtsi, git diff stats look dramatic with git default options.

Using -B -M makes the diff stat a bit less dramatic:

 arch/arm/boot/dts/imx7d.dtsi                 | 1083
+++++++++++---------------------------------------------------------------------------
 arch/arm/boot/dts/{imx7d.dtsi => imx7s.dtsi} |   79 +------
 2 files changed, 130 insertions(+), 1032 deletions(-)

However, that is only for stats, and only when using those options...

I would rather prefer to keep it in a single commit. What do you think?

--
Stefan
