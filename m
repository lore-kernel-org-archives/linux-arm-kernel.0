From: pratyush.anand@st.com (Pratyush Anand)
Date: Wed, 27 Apr 2011 12:22:49 +0530
Subject: [PATCH V7 02/17] SPEAr13xx: Add PCIe host controller base driver
	support.
In-Reply-To: <201104172219.01493.arnd@arndb.de>
References: <cover.1298977728.git.viresh.kumar@st.com>
	<4DA47085.9090209@gmail.com> <4DA59635.2020705@st.com>
	<201104172219.01493.arnd@arndb.de>
Message-ID: <4DB7BD41.50108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/18/2011 1:49 AM, Arnd Bergmann wrote:
> On Wednesday 13 April 2011, pratyush wrote:
>>> Other vendors are likely to have the same IP, but none of the code here
>>> is written to be common. In light of recent discussions this would be a
>>> good candidate to avoid future duplication.
>>>
>>> It doesn't appear that pcie.c contains much SPEAr specific code. The few
>>> defines and structs that are could be passed in. Some comments below.
>>>
>>
>> Yes, this driver is for an PCIe host which uses Synopsys IP. But 
>> SPEAr specific wrapper has been used heavily in the code.
>> Synopsis provides some signal which can be interfaced to registers
>> for CPU access. This interface can be different for different vendor.
>> All the application registers are SPEAr specific representation
>> and may not be same for other vendor.
>> So all accesses for app_reg in the code may not be similar in other 
>> implementation. 
>>
>> ...
> 
> But they could also be the same in another implementation, right?
> 
> I would suggest in general to make the code as generic as easily possible
> and put it into an appropriate location for sharing, but not spending

Our next SOC has new revision of Synopsys PCIe Controller, which has more
generic application interface registers. I am planning to divide code for
this new SOC, so that it would be easily usable if someone has same controller.
What could be the best location for shared code?

Regards
Pratyush

> too much effort on making it more generic than needed.
> 
> The next port that needs a variant of the code can then modify the
> driver accordingly to add the necessary differences and ways to
> detect them.
> 
> 	Arnd
> .
> 
