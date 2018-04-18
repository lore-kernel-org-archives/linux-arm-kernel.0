From: collinsd@codeaurora.org (David Collins)
Date: Wed, 18 Apr 2018 14:34:42 -0700
Subject: [v2,2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20180417194755.GE244487@google.com>
References: <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <20180417182347.GD244487@google.com>
 <2e45c0e5-7e79-3479-de18-9613e8eacf15@codeaurora.org>
 <20180417194755.GE244487@google.com>
Message-ID: <68fd7aa7-25fc-73d6-ffc9-ca8ce5c3d9b9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2018 12:47 PM, Matthias Kaehlcke wrote:
> On Tue, Apr 17, 2018 at 12:15:18PM -0700, David Collins wrote:
>> On 04/17/2018 11:23 AM, Matthias Kaehlcke wrote:
>>> On Fri, Apr 13, 2018 at 07:50:35PM -0700, David Collins wrote:
>>>> [...]
>>>> +static const u32 pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
>>>> +	[REGULATOR_MODE_STANDBY] = 4,
>>>> +	[REGULATOR_MODE_IDLE]    = 5,
>>>> +	[REGULATOR_MODE_NORMAL]  = -EINVAL,
>>>> +	[REGULATOR_MODE_FAST]    = 7,
>>>> +};
>>>
>>> Define constants for the modes on the PMIC4 side?
>>
>> Are you suggesting something like this?
>>
>> #define PMIC4_LDO_MODE_RETENTION	4
>> #define PMIC4_LDO_MODE_LPM		5
>> #define PMIC4_LDO_MODE_HPM		7
>>
>> static const u32 pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
>> 	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
>> 	[REGULATOR_MODE_IDLE]    = PMIC4_LDO_MODE_LPM,
>> 	[REGULATOR_MODE_NORMAL]  = -EINVAL,
>> 	[REGULATOR_MODE_FAST]    = PMIC4_LDO_MODE_HPM,
>> };
>>
>> #define PMIC4_SMPS_MODE_RETENTION	4
>> #define PMIC4_SMPS_MODE_PFM		5
>> #define PMIC4_SMPS_MODE_AUTO		6
>> #define PMIC4_SMPS_MODE_PWM		7
>>
>> static const u32 pmic_mode_map_pmic4_smps[REGULATOR_MODE_STANDBY + 1] = {
>> 	[REGULATOR_MODE_STANDBY] = PMIC4_SMPS_MODE_RETENTION,
>> 	[REGULATOR_MODE_IDLE]    = PMIC4_SMPS_MODE_PFM,
>> 	[REGULATOR_MODE_NORMAL]  = PMIC4_SMPS_MODE_AUTO,
>> 	[REGULATOR_MODE_FAST]    = PMIC4_SMPS_MODE_PWM,
>> };
>>
>> I considered using this approach, but it didn't seem like it increased
>> readability and did increase the line count.  Each of the constants would
>> only be used once.  Would you prefer this style (or something else)?
> 
> Personally I prefer this style, since the constants are more
> expressive than the literals. I agree that the 'inline' constant
> definition is a bit noisy, perhaps it would be better to move the
> definitions to the top of the file or group them before the definition
> of pmic_mode_map_pmic4_ldo. Alteratively you could create a
> drivers/regulator/qcom_rpmh-regulator.h and also move the definitions
> of struct struct rpmh_vreg_hw_data, rpmh_vreg, ... there.

I'll add constants for the per-type regulator modes at the top of the
file.  We'll see if other reviewers like them.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
