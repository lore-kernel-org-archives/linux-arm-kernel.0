From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 27 Oct 2016 11:00:57 -0500
Subject: [PATCHv2] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
In-Reply-To: <20161027070626.s3wwiadf2iumxe4u@pengutronix.de>
References: <1477505112-26079-1-git-send-email-dinguyen@opensource.altera.com>
 <20161027070626.s3wwiadf2iumxe4u@pengutronix.de>
Message-ID: <581224B9.4010808@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2016 02:06 AM, Steffen Trumtrar wrote:
> On Wed, Oct 26, 2016 at 01:05:12PM -0500, dinguyen at opensource.altera.com wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> Enable the QSPI node and add the flash chip.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>> v2: Remove partition entries for the SoCKIT
>> ---
>>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> index 02e22f5..2ce6736 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> @@ -175,6 +175,27 @@
>>  	status = "okay";
>>  };
>>  
>> +&qspi {
>> +	status = "okay";
>> +
>> +	flash: flash at 0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "n25q256a";
> 
> Did you test if this works correctly? According to my datasheet (Rev. C)
> the HPS qspi is a n25q00. The n25q256a is the other one.
> 

No, I did not test this and thanks for catching it. On my SoCKIT, I see
a marking "25Q00AA" on the QSPI chip. So do you know if the compatible
string should be "n25q00a" or "n25q00". I guess I can test it.

Dinh
