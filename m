From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Sep 2013 01:06:23 +0200
Subject: [PATCH] arm: mvebu: use the main timer as clock source from DT
In-Reply-To: <20130925103902.GA2418@localhost>
References: <1379530168-9359-1-git-send-email-jean.pihet@linaro.org>
 <20130918185611.GP19937@titan.lakedaemon.net>
 <20130925103902.GA2418@localhost>
Message-ID: <52436C6F.1010501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2013 12:39 PM, Ezequiel Garcia wrote:
> On Wed, Sep 18, 2013 at 02:56:11PM -0400, Jason Cooper wrote:
>> Adding clocksource maintainers to the Cc: ...
>>
>> On Wed, Sep 18, 2013 at 08:49:28PM +0200, Jean Pihet wrote:
>>> This commit:
>>>   573145f08c2b92c45498468afbbba909f6ce6135
>>>   clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
>>>
>>> replaced a call to the driver's timer initialization by a call to
>>> clocksource_of_init(). However, it failed to select CONFIG_CLKSRC_OF.
>>>
>>> Fix this by selecting CONFIG_CLKSRC_OF for Armada370/XP machines.
>>> Without this change the kernel is stuck at: 'Calibrating delay loop...'.
>>>
>>> Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
>>> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> ---
>>>  drivers/clocksource/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>
>> Daniel, John, Thomas,
>>
>> Can you queue this up for v3.12-rc2?  It fixes a boot breakage.
>>
> 
> Is this already merged somewhere? Is there any chance we can push
> it through *any* tree so it makes -rc3?

Yes, I will take it in my tree.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
