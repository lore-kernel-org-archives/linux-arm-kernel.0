From: stefan@agner.ch (Stefan Agner)
Date: Wed, 23 May 2018 11:07:17 +0200
Subject: [PATCH v3 3/3] ARM: dts: imx6ull-colibri-wifi: remove operating
 points
In-Reply-To: <20180523043032.2htohlypynnvpiye@vireshk-i7>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180522062853.24799-3-sebastien.szymanski@armadeus.com>
 <20180523043032.2htohlypynnvpiye@vireshk-i7>
Message-ID: <dc3523800c274e96dc5642c9c5b65ebe@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.05.2018 06:30, Viresh Kumar wrote:
> On 22-05-18, 08:28, S?bastien Szymanski wrote:
>> Operating points are now defined in the imx6ull.dtsi file so remove
>> them from board device trees.
>>
>> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>  arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi | 14 --------------
>>  1 file changed, 14 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
>> index 3dffbcd50bf6..183193e8580d 100644
>> --- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
>> +++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
>> @@ -20,20 +20,6 @@
>>
>>  &cpu0 {
>>  	clock-frequency = <792000000>;
>> -	operating-points = <
>> -		/* kHz	uV */
>> -		792000  1225000
>> -		528000	1175000
>> -		396000	1025000
>> -		198000	950000
>> -	>;
>> -	fsl,soc-operating-points = <
>> -		/* KHz	uV */
>> -		792000  1175000
>> -		528000	1175000
>> -		396000	1175000
>> -		198000	1175000
>> -	>;
>>  };
>>
>>  &iomuxc {
> 
> Maybe you should merge this with the previous patch itself.


I am with Viresh here, I rather prefer this in a single commit so it is
clear that frequencies moved to the base device tree.

Also, add a comment that frequency selection is now handled in code,
e.g.:

"The valid frequencies for a particular SKU are now selected by the
cpufreq driver according to ratings stored in OTP fuses."

But the two device tree changes with the driver do what they should do
here, so:

Tested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan
