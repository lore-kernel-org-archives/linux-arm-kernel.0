From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 11:40:00 +0200
Subject: [PATCH v2 1/5] phy: berlin-sata: Move PHY_BASE into private data
 struct
In-Reply-To: <54462865.6000205@ti.com>
References: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1413882477-27922-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <54462865.6000205@ti.com>
Message-ID: <544629F0.3090505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2014 11:33 AM, Kishon Vijay Abraham I wrote:
> On Tuesday 21 October 2014 02:37 PM, Sebastian Hesselbarth wrote:
>> Currently, Berlin SATA PHY driver assumes PHY_BASE address being
>> constant. While this PHY_BASE is correct for BG2Q, older BG2 PHY_BASE
>> is different. Prepare the driver for BG2 support by moving the phy_base
>> into private driver data.
>>
>> Acked-by: Antoine T?nart <antoine.tenart@free-electrons.com>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
...
>> ---
>>   drivers/phy/phy-berlin-sata.c | 42 ++++++++++++++++++++++++++++--------------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/phy/phy-berlin-sata.c b/drivers/phy/phy-berlin-sata.c
>> index 69ced52d72aa..9682b0f66177 100644
>> --- a/drivers/phy/phy-berlin-sata.c
>> +++ b/drivers/phy/phy-berlin-sata.c
>> @@ -30,7 +30,7 @@
>>   #define MBUS_WRITE_REQUEST_SIZE_128	(BIT(2) << 16)
>>   #define MBUS_READ_REQUEST_SIZE_128	(BIT(2) << 19)
>>
>> -#define PHY_BASE		0x200
>> +#define BG2Q_PHY_BASE		0x200
[...]
>> +static u32 bg2q_sata_phy_base = BG2Q_PHY_BASE;
>> +
>> +static const struct of_device_id phy_berlin_sata_of_match[] = {
>> +	{
>> +		.compatible = "marvell,berlin2q-sata-phy",
>> +		.data = &bg2q_sata_phy_base,
>
> Can't the base directly come from dt?

You are suggesting a "marvell,phy-base-address" property, right?
I have no strong opinion about it, I accept your call (or DT maintainer
ones).

Sebastian
