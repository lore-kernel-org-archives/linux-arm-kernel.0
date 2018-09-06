From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 6 Sep 2018 14:18:45 +0200
Subject: [linux-sunxi] Re: [PATCH v3 27/30] ARM: dts: sun8i: h3: use
 calibration for ths
In-Reply-To: <BEA89263-1186-432A-B274-228FAC21A798@aosc.io>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
 <20180906115114.inc6dhqhy47obo25@flea>
 <BEA89263-1186-432A-B274-228FAC21A798@aosc.io>
Message-ID: <d8825c55-60e0-16da-e122-22855c294bc4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06.09.2018 14:04, Icenowy Zheng wrote:
> 
> 
> ? 2018?9?6? GMT+08:00 ??7:51:15, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>> On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
>>> On 04.09.2018 18:46, Emmanuel Vadot wrote:
>>>>> +			/* Data cells */
>>>>> +			thermal_calibration: calib at 234 {
>>>>> +				reg = <0x234 0x8>;
>>>>> +			};
>>>>    You are declaring 8 bytes of calibration data but to my knowledge
>> it's
>>>> only 2 bytes per sensor, so 2 bytes for H3.
>>>>    Am I missing something ?
>>>>
>>>>    Thanks,
>>>
>>> Emmanuel you are right, it is 2 bytes per Sensor and should be 2
>> bytes for
>>> H3, but the thermal calibration data field is on all chips 64 bit
>> wide - so
>>> 8 bytes. So I'm reading here the complete calibration data field.
>>
>> Having one cell per channel would make more sense I guess.
Ok I will change this.
> 
> I have mentioned that this is impossible because of wrong
> addressing caused by LE2BE in SID driver.
>
I know! But I would like to prepare patches for it, that they can be 
merged when this is fixed.

Philipp
