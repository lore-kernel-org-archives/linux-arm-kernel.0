From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 26 Apr 2014 20:54:11 +0400
Subject: [PATCH 7/8] ARM: dts: imx27: Trim node name for FEC
In-Reply-To: <1398530361.804335708@f372.i.mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
 <1398487933-5683-7-git-send-email-shc_work@mail.ru>
 <535BDF92.8010704@cogentembedded.com> <1398530361.804335708@f372.i.mail.ru>
Message-ID: <535BE4B3.8090009@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-04-2014 20:39, Alexander Shiyan wrote:

>>> This patch reduce node name for FEC. Otherwise, the name for PHY
>>> is composed incorrectly.

>>> Before:
>>> fec 1002b000.ethernet eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=1002b000.etherne:00, irq=-1)

>>> After:
>>> fec 1002b000.fec eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=1002b000.fec-1:00, irq=-1)

>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>> ---
>>>    arch/arm/boot/dts/imx27.dtsi | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)

>>> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
>>> index a75555c..377339e 100644
>>> --- a/arch/arm/boot/dts/imx27.dtsi
>>> +++ b/arch/arm/boot/dts/imx27.dtsi
>>> @@ -497,7 +497,7 @@
>>>    				clocks = <&clks 38>;
>>>    			};
>>>
>>> -			fec: ethernet at 1002b000 {
>>> +			fec: fec at 1002b000 {

>>      The "ethernet" name complies to the ePAPR standard. Don't change it, please.

> So this is ok?
> mii_bus:phy_addr=1002b000.etherne:00

    Why not? :-)

WBR, Sergei
