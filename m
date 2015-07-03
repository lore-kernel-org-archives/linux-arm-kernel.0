From: tommyhebb@gmail.com (Thomas Hebb)
Date: Fri, 3 Jul 2015 10:33:27 -0400
Subject: [PATCH 1/4] phy: berlin-usb: fix divider for BG2CD
In-Reply-To: <20150703092028.GC5634@kwain>
References: <5594C652.2020901@gmail.com> <20150703092028.GC5634@kwain>
Message-ID: <55969D37.7020804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2015 05:20 AM, Antoine Tenart wrote:
> Thomas,
> 
> On Thu, Jul 02, 2015 at 01:04:18AM -0400, Thomas Hebb wrote:
>> The marvell,berlin2cd-usb-phy compatible incorrectly sets the PLL
>> divider to BG2's value instead of BG2CD/BG2Q's. Change it to the right
>> value.
>>
>> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
>> Cc: stable at vger.kernel.org
> 
> Only this one is sent to stable? The BG2 won't be fixed in stable?
> 
> Antoine

Since BG2 doesn't currently have its USB PHY enabled in device tree, I
didn't see any reason to mark that fix for stable; we'd have to wait
until next cycle for it to be of use anyway. This is the same division
that Sebastian suggested.

I admit it looks a bit odd to have both dividers be the same. If you
want me to mark the other patches for stable for clarity reasons, I'm
happy to do that.

-Tom

>> ---
>>  drivers/phy/phy-berlin-usb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/phy-berlin-usb.c
>> index c6fc95b..ab54f28 100644
>> --- a/drivers/phy/phy-berlin-usb.c
>> +++ b/drivers/phy/phy-berlin-usb.c
>> @@ -106,8 +106,8 @@
>>  static const u32 phy_berlin_pll_dividers[] = {
>>  	/* Berlin 2 */
>>  	CLK_REF_DIV(0xc) | FEEDBACK_CLK_DIV(0x54),
>> -	/* Berlin 2CD */
>> -	CLK_REF_DIV(0x6) | FEEDBACK_CLK_DIV(0x55),
>> +	/* Berlin 2CD/Q */
>> +	CLK_REF_DIV(0xc) | FEEDBACK_CLK_DIV(0x54),
>>  };
>>  
>>  struct phy_berlin_usb_priv {
>> -- 
>> 2.4.4
>>
> 
