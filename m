From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 17 Oct 2016 08:56:16 +0300
Subject: [PATCH 2/2] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <2d276e51-9d37-8648-4aad-283bb2b23626@ti.com>
References: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
 <1475672732-17111-3-git-send-email-bgolaszewski@baylibre.com>
 <2d276e51-9d37-8648-4aad-283bb2b23626@ti.com>
Message-ID: <1e23c3e9-d34b-1d8f-8565-c9932a60fd32@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/16 20:42, Sekhar Nori wrote:

>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index f79e1b9..32908ae 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
> 
>> @@ -399,6 +420,14 @@
>>  				<&edma0 0 1>;
>>  			dma-names = "tx", "rx";
>>  		};
>> +
>> +		display: display at 213000 {
>> +			compatible = "ti,am33xx-tilcdc", "ti,da850-tilcdc";
> 
> This should instead be:
> 
> compatible = "ti,da850-tilcdc", "ti,am33xx-tilcdc";
> 
> as the closest match should appear first in the list.

Actually I don't think that's correct. The LCDC on da850 is not
compatible with the LCDC on AM335x. I think it should be just
"ti,da850-tilcdc".

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161017/a26c6f6e/attachment.sig>
