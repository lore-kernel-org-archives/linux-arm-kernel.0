From: carlv@codeaurora.org (Carl Vanderlip)
Date: Wed, 23 Mar 2011 13:42:44 -0700
Subject: [PATCH 09/20] video: msm: Split out MDP2.2 HW specific code.
In-Reply-To: <1300885912.6117.16.camel@m0nster>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>	
	<1300485423-27281-1-git-send-email-carlv@codeaurora.org>
	<1300885912.6117.16.camel@m0nster>
Message-ID: <4D8A5B44.9050306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2011 06:11 AM, Daniel Walker wrote:
> On Fri, 2011-03-18 at 14:57 -0700, Carl Vanderlip wrote:
>> index df9d74e..d6e75c3 100644
>> --- a/arch/arm/mach-msm/Kconfig
>> +++ b/arch/arm/mach-msm/Kconfig
>> @@ -76,6 +76,11 @@ config HAS_MSM_DEBUG_UART_PHYS
>>  config  MSM_VIC
>>         bool
>>  
>> +config MSM_MDP22
>> +       bool
>> +       depends on ARCH_MSM7X00A
>> +       default y
>> + 
> You should remove the "default y" and this should be moved to a Kconfig
> under video (shouldn't be added into mach-msm).
>
> Daniel
>
What about removing the 'depends on' and 'default y' and making it be
selected by MSM7X00A?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
