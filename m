From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 15 Jul 2015 18:53:39 +0530
Subject: [PATCH 0/4] phy: berlin-usb: PLL divider fixes
In-Reply-To: <20150703092243.GD5634@kwain>
References: <5594C650.8000405@gmail.com> <20150703092243.GD5634@kwain>
Message-ID: <55A65EDB.3020800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 03 July 2015 02:52 PM, Antoine Tenart wrote:
> Hi Thomas,
> 
> Thanks for this series!
> 
> On Thu, Jul 02, 2015 at 01:04:16AM -0400, Thomas Hebb wrote:
>> The USB PLL dividers currently set by phy-berlin-usb are incorrect for
>> BG2 and BG2CD (i.e. all Berlin variants but BG2Q). This series fixes the
>> divider values for those two chips and additionally corrects the name of
>> the of_match table to no longer contain "sata" (which was presumably
>> mistakenly carried over from phy-berlin-sata).
>>
>> I have verified that the new divider values work on BG2CD and Antoine
>> Tenart has verified that they work on BG2Q. The divider value for BG2
>> was taken from bootloader source but has not been tested.
> 
> For the BG2Q,
> 
> Tested-by: Antoine Tenart <antoine.tenart@free-electrons.com>

merged this series except
"ARM: dts: berlin: change BG2Q's USB PHY compatible"

Cheers
Kishon

> 
>>
>> Thomas Hebb (4):
>>   phy: berlin-usb: fix divider for BG2CD
>>   ARM: dts: berlin: change BG2Q's USB PHY compatible
>>   phy: berlin-usb: fix divider for BG2
>>   phy: berlin-usb: rename table copied from SATA PHY
>>
>>  arch/arm/boot/dts/berlin2q.dtsi |  6 +++---
>>  drivers/phy/phy-berlin-usb.c    | 12 ++++++------
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.4.4
>>
> 
