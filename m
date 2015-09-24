From: nm@ti.com (Nishanth Menon)
Date: Thu, 24 Sep 2015 09:20:50 -0500
Subject: [PATCH 1/3] Documentation: dt: keystone: provide SoC specific
 compatible flags
In-Reply-To: <56040323.1080409@ti.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
 <1442938118-4718-2-git-send-email-nm@ti.com> <5602ED34.9010108@oracle.com>
 <56040323.1080409@ti.com>
Message-ID: <560406C2.6090200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2015 09:05 AM, Murali Karicheri wrote:
> On 09/23/2015 02:19 PM, santosh shilimkar wrote:
>> Nishant,
>>
>> On 9/22/2015 9:08 AM, Nishanth Menon wrote:
>>> Keystone2 devices are used on more platforms than just Texas
>>> Instruments reference evaluation platforms called EVMs. Providing a
>>> generic compatible "ti,keystone" is not sufficient to differentiate
>>> various SoC definitions possible on various platforms. So, provide
>>> compatible matches for each SoC family by itself.
>>>
>>> This allows SoC specific logic to be run time handled based on
>>> of_machine_is_compatible("ti,k2hk") or as needed for the dependent
>>> processor instead of needing to use board dependent compatibles that
>>> are needed now.
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>> You need to expand that 'not sufficient' for me. Unless there is
>> genuine case to support this, I would want to avoid this churn.
>>
> 
> I agree. If there are run time check required in code to treat the 
> variants of Keystone SoC differently, then this change is needed. At 
> this time, SoC DTS captures these differences. IMHO, If a future 
> Keystone SoC support required SoC specific compatibility string to 
> customize SoC specific initialization code, then it can be introduced at 
> that time. I am not sure why this is introduced with out an example usage.

a) See
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/usage-model.txt#n116
-> all we have today is board, soc generic family. The generic
compatible flag of ti,keystone to mark that this is a keystone2 device
does not identify that what kind of soc it is. which is what this
series introduces.

b) there is no realistic way for user space applications such as a
test framework or other SoC based applications in a generic distro to
detect the right SoC this platform is running on - imagine writing SoC
specific code that depends on board compatible flags - there is never
an end to that story as the number of boards expand.

c) Ideally we will try never to introduce code that will have to
depend on SoC compatible flag based match in kernel - but that is not
a reason not to follow guidelines provided by devicetree documentation
to provide SoC specific compatible flags.

-- 
Regards,
Nishanth Menon
