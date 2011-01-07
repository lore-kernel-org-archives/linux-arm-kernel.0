From: pratyush.anand@st.com (pratyush)
Date: Fri, 7 Jan 2011 14:24:57 +0530
Subject: [PATCH V2] ST SPEAr: PCIE gadget suppport
In-Reply-To: <20110106121853.016fb990.akpm@linux-foundation.org>
References: <137dfad4a093ea0ac80396f5eb7fbf0c382be698.1294314772.git.viresh.kumar@st.com>
	<20110106121853.016fb990.akpm@linux-foundation.org>
Message-ID: <4D26D4E1.6050609@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/7/2011 1:48 AM, Andrew Morton wrote:
> On Thu, 6 Jan 2011 17:29:10 +0530
> Viresh Kumar <viresh.kumar@st.com> wrote:
> 
>> From: Pratyush Anand <pratyush.anand@st.com>
>>
>> This is a configurable gadget. can be configured by sysfs interface. Any
>> IP available at PCIE bus can be programmed to be used by host
>> controller.It supoorts both INTX and MSI.
>> By default, gadget is configured for INTX and SYSRAM1 is mapped to BAR0
>> with size 0x1000
>>
>> ...
>>
>> --- /dev/null
>> +++ b/Documentation/misc-devices/spear-pcie-gadget.txt
> 
> Please recheck this documentation file - it contains a number of simple
> typos.
> 

will check that and send PATCH V3.
 
>>
>> ...
>>
>> +	if (strict_strtoul(buf, 0, &config->requested_msi))
>> +		return -EINVAL;
> 
> It doesn't matter much, but the code really should propagate the
> strict_strtoul() return error code back to the caller, rather than
> overwriting it with -EINVAL.
> 

will do that modification in PATCH V3.

Regards
Pratyush

> .
> 
