From: rogerq@ti.com (Roger Quadros)
Date: Mon, 19 Aug 2013 17:25:50 +0300
Subject: [PATCH v4 4/8] usb: phy: omap-usb3: Don't use
 omap_get_control_dev()
In-Reply-To: <52122A69.6080000@cogentembedded.com>
References: <1376908667-14974-1-git-send-email-rogerq@ti.com>
 <1376908667-14974-5-git-send-email-rogerq@ti.com>
 <52122A69.6080000@cogentembedded.com>
Message-ID: <52122AEE.5050401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 08/19/2013 05:23 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/19/2013 02:37 PM, Roger Quadros wrote:
> 
>> omap_get_control_dev() is being deprecated as it doesn't support
>> multiple instances. As control device is present only from OMAP4
>> onwards which supports DT only, we use phandles to get the
>> reference to the control device.
> 
>> As we don't support non-DT boot, we just bail out on probe
>> if device node is not present.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/usb/phy/phy-omap-usb3.c |   22 ++++++++++++++++++----
>>   1 files changed, 18 insertions(+), 4 deletions(-)
> 
>> diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
>> index 4a7f27c..981313e 100644
>> --- a/drivers/usb/phy/phy-omap-usb3.c
>> +++ b/drivers/usb/phy/phy-omap-usb3.c
> [...]
>> @@ -198,6 +199,12 @@ static int omap_usb3_probe(struct platform_device *pdev)
>>   {
>>       struct omap_usb            *phy;
>>       struct resource            *res;
>> +    struct device_node *node = pdev->dev.of_node;
>> +    struct device_node *control_node;
>> +    struct platform_device *control_pdev;
> 
>    Could you align the variable names with the above 2 variables?
> Either that, or remove the alignment of those two.

OK, I'll remove the alignment of the 1st two lines.

cheers,
-roger
