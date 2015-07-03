From: tommyhebb@gmail.com (Thomas Hebb)
Date: Fri, 3 Jul 2015 10:34:20 -0400
Subject: [PATCH 4/4] phy: berlin-usb: rename table copied from SATA PHY
In-Reply-To: <20150703091831.GB5634@kwain>
References: <5594C65E.1030802@gmail.com> <20150703091831.GB5634@kwain>
Message-ID: <55969D6C.1040309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2015 05:18 AM, Antoine Tenart wrote:
> Thomas,
> 
> On Thu, Jul 02, 2015 at 01:04:30AM -0400, Thomas Hebb wrote:
>> We're not in a SATA PHY driver, so the of_match table shouldn't have
>> "sata" in its name.
> 
> There is already a patch fixing this (which was sent last week):
> 
> https://lkml.org/lkml/2015/6/24/103
> 
> You can drop this one from the series.
> 
> Antoine

Acknowledged. Sorry for the noise.

-Tom

>>
>> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
>> Suggested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>>  drivers/phy/phy-berlin-usb.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/phy-berlin-usb.c
>> index 335e06d..7143cd3 100644
>> --- a/drivers/phy/phy-berlin-usb.c
>> +++ b/drivers/phy/phy-berlin-usb.c
>> @@ -152,7 +152,7 @@ static struct phy_ops phy_berlin_usb_ops = {
>>  	.owner		= THIS_MODULE,
>>  };
>>  
>> -static const struct of_device_id phy_berlin_sata_of_match[] = {
>> +static const struct of_device_id phy_berlin_usb_of_match[] = {
>>  	{
>>  		.compatible = "marvell,berlin2-usb-phy",
>>  		.data = &phy_berlin_pll_dividers[0],
>> @@ -163,12 +163,12 @@ static const struct of_device_id phy_berlin_sata_of_match[] = {
>>  	},
>>  	{ },
>>  };
>> -MODULE_DEVICE_TABLE(of, phy_berlin_sata_of_match);
>> +MODULE_DEVICE_TABLE(of, phy_berlin_usb_of_match);
>>  
>>  static int phy_berlin_usb_probe(struct platform_device *pdev)
>>  {
>>  	const struct of_device_id *match =
>> -		of_match_device(phy_berlin_sata_of_match, &pdev->dev);
>> +		of_match_device(phy_berlin_usb_of_match, &pdev->dev);
>>  	struct phy_berlin_usb_priv *priv;
>>  	struct resource *res;
>>  	struct phy *phy;
>> @@ -208,7 +208,7 @@ static struct platform_driver phy_berlin_usb_driver = {
>>  	.driver	= {
>>  		.name		= "phy-berlin-usb",
>>  		.owner		= THIS_MODULE,
>> -		.of_match_table	= phy_berlin_sata_of_match,
>> +		.of_match_table	= phy_berlin_usb_of_match,
>>  	 },
>>  };
>>  module_platform_driver(phy_berlin_usb_driver);
>> -- 
>> 2.4.4
>>
> 
