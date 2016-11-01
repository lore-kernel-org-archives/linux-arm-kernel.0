From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 1 Nov 2016 15:13:44 -0500
Subject: [PATCH] ARM: dts: socfpga: add specific compatible strings for
 boards
In-Reply-To: <6ebcc3e9-37b7-7c27-a111-9fc663d07864@mentor.com>
References: <20161101153817.6977-1-dinguyen@kernel.org>
 <6ebcc3e9-37b7-7c27-a111-9fc663d07864@mentor.com>
Message-ID: <dcb190ef-ef58-99fa-287a-96ec58aa2c57@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 11/01/2016 03:10 PM, Vladimir Zapolskiy wrote:
> Hi Dinh,
> 
> On 11/01/2016 05:38 PM, Dinh Nguyen wrote:
>> Add a more specific board compatible entry for all of the SOCFPGA
>> Cyclone 5 based boards.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  | 2 +-
>>  arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      | 2 +-
>>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       | 2 +-
>>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      | 2 +-
>>  arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       | 2 +-
>>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 2 +-
>>  6 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>> b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>> index afea364..5ecd2ef 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>> @@ -18,7 +18,7 @@
>>
>>  / {
>>      model = "Terasic DE-0(Atlas)";
>> -    compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +    compatible = "terasic,de0-atlas", "altr,socfpga-cyclone5",
>> "altr,socfpga";
>>
>>      chosen {
>>          bootargs = "earlyprintk";
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
>> b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
>> index 424523b..668d77c 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
>> @@ -19,7 +19,7 @@
>>
>>  / {
>>      model = "Aries/DENX MCV EVK";
>> -    compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +    compatible = "denx, mcvevk", "altr,socfpga-cyclone5",
>> "altr,socfpga";
> 
> Redundant space            ^

OK

> 
>>
>>      aliases {
>>          ethernet0 = &gmac0;
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> index 15e43f4..b0577c1 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> @@ -19,7 +19,7 @@
>>
>>  / {
>>      model = "Altera SOCFPGA Cyclone V SoC Development Kit";
>> -    compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +    compatible = "altr,socdk", "altr,socfpga-cyclone5", "altr,socfpga";
>>
>>      chosen {
>>          bootargs = "earlyprintk";
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> index 02e22f5..c5623a7 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> @@ -19,7 +19,7 @@
>>
>>  / {
>>      model = "Terasic SoCkit";
>> -    compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +    compatible = "terasic,sockit", "altr,socfpga-cyclone5",
>> "altr,socfpga";
>>
>>      chosen {
>>          bootargs = "earlyprintk";
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
>> b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
>> index 9aaf413..992ae49 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
>> @@ -21,7 +21,7 @@
>>
>>  / {
>>      model = "Altera SOCFPGA Cyclone V SoC Macnica Sodia board";
>> -    compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +    compatible = "macnica, sodia", "altr,socfpga-cyclone5",
>> "altr,socfpga";
> 
> Redundant space               ^

Ok,

> 
> If it is not yet done, you may consider to add Macnica to
> Documentation/devicetree/bindings/vendor-prefixes.txt
> 

Yes, I have sent separate patches to add the vendor prefixes.

>>
>>      chosen {
>>          bootargs = "earlyprintk";
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
>> b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
>> index b844473..78b187e 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
>> @@ -51,7 +51,7 @@
>>
>>  / {
>>      model = "samtec VIN|ING FPGA";
>> -    compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +    compatible = "samtec,vining". "altr,socfpga-cyclone5",
>> "altr,socfpga";
> 
> Comma is expected here              ^

Ok,

> 
> Probably Terasic and Samtec are also not in the vendor-prefixes.txt list,
> usually checkpatch complains about it.

Yes, I have sent patches for the vendor prefixes. Thanks for reviewing.

Dinh
