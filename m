From: rogerq@ti.com (Roger Quadros)
Date: Mon, 11 Feb 2013 17:22:15 +0200
Subject: [PATCH v2 07/14] USB: ohci-omap3: Add device tree support and
 binding information
In-Reply-To: <20130211114611.GB2726@e106331-lin.cambridge.arm.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
 <1360252974-7912-8-git-send-email-rogerq@ti.com>
 <20130211114611.GB2726@e106331-lin.cambridge.arm.com>
Message-ID: <51190CA7.7010705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 01:46 PM, Mark Rutland wrote:
> On Thu, Feb 07, 2013 at 04:02:47PM +0000, Roger Quadros wrote:
>> Allows the OHCI controller found in OMAP3 and later chips to
>> be specified via device tree.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> ---
>>  .../devicetree/bindings/usb/omap3-ohci.txt         |   17 +++++++++++++++++
>>  drivers/usb/host/ohci-omap3.c                      |   19 +++++++++++++++++++
>>  2 files changed, 36 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/omap3-ohci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/omap3-ohci.txt b/Documentation/devicetree/bindings/usb/omap3-ohci.txt
>> new file mode 100644
>> index 0000000..ad2ace0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/omap3-ohci.txt
>> @@ -0,0 +1,17 @@
>> +OMAP HS USB OHCI controller (OMAP3 and later)
>> +
>> +Required properties:
>> +
>> +- compatible: should be "ti,ohci-omap3"
>> +- reg: should contain one register range i.e. start and length
>> +- interrupt-parent: phandle to the interrupt controller
> 
> I'm not sure that needs to be documented as a required property. It's a
> standard property, and if it's defined for the parent node, you won't need it
> here.

The last time I tried without 'interrupt-parent' it complained. Doesn't do it anymore.
Maybe I did something wrong the last time. I'll remove it.

> 
> Otherwise, this looks fine to me.

Thanks. I'll add your reviewed-by tag after addressing the above comment.

cheers,
-roger
