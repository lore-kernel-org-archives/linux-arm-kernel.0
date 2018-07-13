From: collinsd@codeaurora.org (David Collins)
Date: Thu, 12 Jul 2018 18:34:02 -0700
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20180712165457.GI10369@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <20180702102853.GI18211@sirena.org.uk>
 <9bbfb628-018d-2d89-257b-9cc4e716cb46@codeaurora.org>
 <20180712165457.GI10369@sirena.org.uk>
Message-ID: <c6919357-6c3b-1f69-4d51-2ed2ddd2c942@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2018 09:54 AM, Mark Brown wrote:
> On Mon, Jul 09, 2018 at 04:44:14PM -0700, David Collins wrote:
>> On 07/02/2018 03:28 AM, Mark Brown wrote:
>>> On Fri, Jun 22, 2018 at 05:46:14PM -0700, David Collins wrote:
>>>> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mode)
>>>> +{
>>>> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
>>>> +		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
>>>> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
>>>> +		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_INVALID,
>>>> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
>>>> +	};
> 
>>> Same here, based on that it looks like auto mode is a good map for
>>> normal.
> 
>> LDO type regulators physically do not support AUTO mode.  That is why I
>> specified REGULATOR_MODE_INVALID in the mapping.
> 
> The other question here is why this is even in the table if it's not
> valid (I'm not seeing a need for the MODE_COUNT define)?

I thought that having a table would be more concise and easier to follow.
I can change this to a switch case statement.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
