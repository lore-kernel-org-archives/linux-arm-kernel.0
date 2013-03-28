From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 28 Mar 2013 21:19:01 +0100
Subject: [PATCH] ARM: dove: fix Dove cpu type from V7 to PJ4
In-Reply-To: <20130328181425.GE3368@n2100.arm.linux.org.uk>
References: <1364051211-24414-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130328170654.GX13280@titan.lakedaemon.net>
 <20130328181425.GE3368@n2100.arm.linux.org.uk>
Message-ID: <5154A5B5.7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 07:14 PM, Russell King - ARM Linux wrote:
> On Thu, Mar 28, 2013 at 01:06:54PM -0400, Jason Cooper wrote:
>> On Sat, Mar 23, 2013 at 04:06:51PM +0100, Sebastian Hesselbarth wrote:
>>> The CPU used in Marvell Dove SoCs is a PJ4 Sheeva core. Using
>>> CONFIG_CPU_PJ4 instead of CONFIG_CPU_V7 will also allow to enable
>>> iWMMXt extensions on Dove.
>>>
>>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>>> ---
>>> Cc: Russell King<linux@arm.linux.org.uk>
>>> Cc: Jason Cooper<jason@lakedaemon.net>
>>> Cc: Andrew Lunn<andrew@lunn.ch>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-kernel at vger.kernel.org
>>> ---
>>>   arch/arm/Kconfig |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Hmmm, I'm getting (with dove_defconfig):
>>
>> arch/arm/kernel/built-in.o: In function `iwmmxt_do':
>> /.../arch/arm/kernel/pj4-cp0.c:36: undefined reference to `iwmmxt_task_release'
>> /.../arch/arm/kernel/pj4-cp0.c:40: undefined reference to `iwmmxt_task_switch'
>> make: *** [vmlinux] Error 1
>
> Looks to me like PJ4 IWMMXT support wasn't properly tested out when it
> was submitted - it's possible to end up with pj4-cp0.c built without
> the IWMMXT code that it depends on being built...

Russel, Jason,

do we force iWMMXt on CPU_PJ4 or should there be some #ifdef'ery if 
IWMMXT is not selected?

Sebastian
