From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 21 Sep 2016 08:57:26 +0100
Subject: [PATCH] ARM: tegra: nyan: Enable GPU node and related supply
In-Reply-To: <1474395433.1215.23.camel@paulk.fr>
References: <20160918141311.17140-1-contact@paulk.fr>
 <f2489bf5-bb08-11f5-1b53-7a1568f20b6b@nvidia.com>
 <1474395433.1215.23.camel@paulk.fr>
Message-ID: <e95335ae-ad19-b8cd-634b-63c6a0b88e01@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 20/09/16 19:17, Paul Kocialkowski wrote:
> * PGP Signed by an unknown key
> 
> Le mardi 20 septembre 2016 ? 13:24 +0100, Jon Hunter a ?crit :
>> On 18/09/16 15:13, Paul Kocialkowski wrote:
>>>
>>> This enables the GPU node for tegra124 nyan boards, which is required to
>>> get graphics acceleration with nouveau on these devices.
>>>
>>> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>>> ---
>>>  arch/arm/boot/dts/tegra124-nyan.dtsi | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi
>>> b/arch/arm/boot/dts/tegra124-nyan.dtsi
>>> index dab9509..225ca77 100644
>>> --- a/arch/arm/boot/dts/tegra124-nyan.dtsi
>>> +++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
>>> @@ -42,6 +42,12 @@
>>>  		};
>>>  	};
>>>  
>>> +	gpu at 0,57000000 {
>>> +		status = "okay";
>>> +
>>> +		vdd-supply = <&vdd_gpu>;
>>> +	};
>>> +
>>>  	serial at 70006000 {
>>>  		/* Debug connector on the bottom of the board near SD card.
>>> */
>>>  		status = "okay";
>>> @@ -214,7 +220,7 @@
>>>  					regulator-always-on;
>>>  				};
>>>  
>>> -				sd6 {
>>> +				vdd_gpu: sd6 {
>>>  					regulator-name = "+VDD_GPU_AP";
>>>  					regulator-min-microvolt = <650000>;
>>>  					regulator-max-microvolt =
>>> <1200000>;
>>>
>>
>> Looks good to me. I see the following error when booting but looking at the
>> code appears to be benign. Thierry, Alex, is this normal/okay?
> 
> I have the same messages and asked Alexandre about them the other day. He told
> me that it looks normal.

Ok great. Hopefully, Alex can ACK then.

Cheers
Jon

-- 
nvpublic
