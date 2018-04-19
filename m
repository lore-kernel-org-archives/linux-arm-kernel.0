From: sebastien.szymanski@armadeus.com (=?UTF-8?Q?S=c3=a9bastien_Szymanski?=)
Date: Thu, 19 Apr 2018 09:27:03 +0200
Subject: [PATCH 2/2] ARM: dts: imx6ull: add operating points
In-Reply-To: <c5d92c4e36973e3e18980d410e11ec4f@agner.ch>
References: <20180418145230.10249-1-sebastien.szymanski@armadeus.com>
 <20180418145230.10249-2-sebastien.szymanski@armadeus.com>
 <c5d92c4e36973e3e18980d410e11ec4f@agner.ch>
Message-ID: <265f4635-bf67-48a9-4ad5-caaba752be8d@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 04/18/2018 05:35 PM, Stefan Agner wrote:
> On 18.04.2018 16:52, S?bastien Szymanski wrote:
>> i.MX6ULL has different operating ranges than i.MX6UL so add the
>> operating points for the i.MX6ULL. A 25mV offset is added to the minimum
>> allowed values like for the i.MX6UL.
> 
> Hi S?bastien,
> 
> Last time I checked there was a DC controller missing for the EVK, so I
> think it was not possible to go to the highest operating points yet.
> Have you tested this on the EVK?

No, I have tested on an OPOS6ULDev board.

I've just noticed that the soc-operating-points values are wrong in this
patch, I've sent a v2.

Regards,

> 
> --
> Stefan
> 
>>
>> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>  arch/arm/boot/dts/imx6ull.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
>> index 571ddd71cdba..7e6273be0291 100644
>> --- a/arch/arm/boot/dts/imx6ull.dtsi
>> +++ b/arch/arm/boot/dts/imx6ull.dtsi
>> @@ -46,6 +46,25 @@
>>  /* Delete UART8 in AIPS-1 (i.MX6UL specific) */
>>  /delete-node/ &uart8;
>>  
>> +&cpu0 {
>> +	operating-points = <
>> +		/* kHz	uV */
>> +		900000	1275000
>> +		792000	1225000
>> +		528000	1175000
>> +		396000	1025000
>> +		198000	950000
>> +	>;
>> +	fsl,soc-operating-points = <
>> +		/* KHz	uV */
>> +		900000	1400000
>> +		792000	1350000
>> +		528000	1175000
>> +		396000	1175000
>> +		198000	1175000
>> +	>;
>> +};
>> +
>>  / {
>>  	soc {
>>  		aips3: aips-bus at 2200000 {


-- 
S?bastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
