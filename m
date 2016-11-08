From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 8 Nov 2016 14:53:08 -0600
Subject: [PATCHv2] ARM: dts: socfpga: add specific compatible strings for
 boards
In-Reply-To: <20161101222352.GA6328@localhost>
References: <20161101205652.26384-1-dinguyen@kernel.org>
 <20161101222352.GA6328@localhost>
Message-ID: <17b93c4e-eb42-0bc1-07d7-98d52a3f057f@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/01/2016 05:23 PM, Olof Johansson wrote:
> On Tue, Nov 01, 2016 at 03:56:52PM -0500, Dinh Nguyen wrote:
>> Add a more specific board compatible entry for all of the SOCFPGA
>> Cyclone 5 based boards.
>>

[snip]

>>  / {
>>  	model = "Altera SOCFPGA Cyclone V SoC Development Kit";
>> -	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +	compatible = "altr,socdk", "altr,socfpga-cyclone5", "altr,socfpga";
> 
> This looks a little too generic, what if there's another dk with another
> SoC down the road?
> 

Right...I'll change it to "altr,socfpga-cyclone5-socdk",

>>  	chosen {
>>  		bootargs = "earlyprintk";
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> index 02e22f5..c5623a7 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> @@ -19,7 +19,7 @@
>>  
>>  / {
>>  	model = "Terasic SoCkit";
>> -	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +	compatible = "terasic,sockit", "altr,socfpga-cyclone5", "altr,socfpga";
> 
> Same thing here, this seems a bit on the generic side.
> 

perhaps "terasic,socfpga-cyclone5-sockit" ?

Thanks for reviewing.

Dinh
