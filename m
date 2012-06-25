From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 25 Jun 2012 20:54:21 +0530
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <4FE87FE3.1080608@wwwdotorg.org>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4FE80413.6070001@nvidia.com> <4FE87FE3.1080608@wwwdotorg.org>
Message-ID: <4FE882A5.3080504@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 June 2012 08:42 PM, Stephen Warren wrote:
> On 06/25/2012 12:24 AM, Laxman Dewangan wrote:
>> On Saturday 23 June 2012 04:44 AM, Stephen Warren wrote:
>>> From: Stephen Warren<swarren@nvidia.com>
>>>
>>> Seaboard uses a TPS6586x regulator. Instantiate this, and hook up a
>>> couple of fixed GPIO-controlled regulators too.
>>>
>>>
>>> Signed-off-by: Stephen Warren<swarren@nvidia.com>
>>> ---
>> Acked-by: Laxman Dewangan<ldewangan@nvidia.com>
>>
>> I think this series very much depends on the series
>> [PATCH V3 0/3] regulator: dt: add policy to match regulator with prop
>> "regulator-compatible"
> That's certainly true. However, it's a runtime dependency to enable a
> new feature, and shouldn't cause any breakage without that patch, so we
> don't need to be explicit about the dependency in git.
>

Here, wanted to say that although we enable it but it will not work. The 
functionality depends on the above patch.

>>> +                regulator at 3 {
>>> +                    reg =<3>;
>>> +                    regulator-compatible = "ldo0";
>>> +                    regulator-name = "vdd_ldo0";
>>> +                    regulator-min-microvolt =<1250000>;
>>> +                    regulator-max-microvolt =<3300000>;
>>> +                    vin-supply =<&sm2_reg>;
>> I think support for vin-supply is still not there for this regulator in
>> driver.
> That's also true. I wonder if we shouldn't support this in the regulator
> core bindings instead, since the existence of a parent regulator seems
> likely to be common. Either way, I'd like to include the property to
> document it for now.

I had detailed discussion with Mark on  this support and as per him 
(based on my understanding), the input to different regulator is from 
the pin of the chips and so the name should be the <pin-name>-supply 
which should be part of chip-dt binding, not to the particular rail.
