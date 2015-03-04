From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 04 Mar 2015 14:21:53 +0100
Subject: [PATCH] ARM: ARMADA XP: WRT1900AC: Add support for the Ethernet
 switch
In-Reply-To: <54F5AEA5.7050502@free-electrons.com>
References: <1425154848-15441-1-git-send-email-andrew@lunn.ch>
 <54F57A41.1040102@free-electrons.com> <20150303104451.GA10252@lunn.ch>
 <54F5AEA5.7050502@free-electrons.com>
Message-ID: <54F706F1.4010002@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2015 13:52, Gregory CLEMENT wrote:
> On 03/03/2015 11:44, Andrew Lunn wrote:
>> On Tue, Mar 03, 2015 at 10:09:21AM +0100, Gregory CLEMENT wrote:
>>> Hi Andrew,
>>>
>>> On 28/02/2015 21:20, Andrew Lunn wrote:
>>>> Add a DSA section to the DT blob representing the Ethernet switch.
>>>>
>>>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>>>> ---
>>>> This patch requires at runtime patches in net-next,
>>>> 4c732668f98b96a0fa2645ac220fd9bbc17838c4
>>>
>>> This dts fragment looks sane. The dependencies is only at runtime so
>>> it is less annoying for bissectability. So I tend applying it, however
>>> what happens if patch 4c732668f98b96a0fa2645ac220fd9bbc17838c4 is not
>>> present. Does the kernel crash? Or does it only make the Ethernet
>>> switch not available?
>>
>> Hi Gregory
>>
>> It does not crash. During probe of DSA, it fails to find the phy's
>> attached to the switch ports. This causes the probe to fail and the
>> switch drive gets unloaded.
> 
> Good. So it is safe to apply this patch to mvebu/dt now.
> 

Now applied on mvebu/dt


Thanks,

Gregory

> 
> 
>>
>>        Andrew
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
