From: balbi@ti.com (Felipe Balbi)
Date: Thu, 5 Nov 2015 23:14:39 -0600
Subject: [PATCH v2 5/5] ARM: dts: AM4372: add entry for qspi mmap region
In-Reply-To: <20151105235124.GA2805@rob-hp-laptop>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-6-git-send-email-vigneshr@ti.com>
 <20151105235124.GA2805@rob-hp-laptop>
Message-ID: <878u6b1zgg.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Rob Herring <robh@kernel.org> writes:
> On Tue, Nov 03, 2015 at 03:36:14PM +0530, Vignesh R wrote:
>> Add qspi memory mapped region entries for AM43xx based SoCs. Also,
>> update the binding documents for the controller to document this change.
>> 
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>
> Acked-by: Rob Herring <robh@kernel.org>
>
>> ---
>>  Documentation/devicetree/bindings/spi/ti_qspi.txt | 5 +++--
>>  arch/arm/boot/dts/am4372.dtsi                     | 4 +++-
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
>> index f05dd631bef1..05488970060b 100644
>> --- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
>> +++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
>> @@ -17,9 +17,10 @@ Recommended properties:
>>  
>>  Example:
>>  
>> +For am4372:
>>  qspi: qspi at 4b300000 {
>> -	compatible = "ti,dra7xxx-qspi";
>> -	reg = <0x47900000 0x100>, <0x30000000 0x3ffffff>;
>> +	compatible = "ti,am4372-qspi";
>> +	reg = <0x47900000 0x100>, <0x30000000 0x4000000>;
>>  	reg-names = "qspi_base", "qspi_mmap";
>>  	#address-cells = <1>;
>>  	#size-cells = <0>;

and how does the user for this look like ? Don't you need to give this a
proper 'ranges' binding ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151105/f7f380d9/attachment.sig>
