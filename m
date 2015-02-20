From: mmarek@suse.cz (Michal Marek)
Date: Fri, 20 Feb 2015 11:24:18 +0100
Subject: [PATCH] [media] [kbuild] Add and use IS_REACHABLE macro
In-Reply-To: <5822078.VORY4BTfEj@wuerfel>
References: <6116702.rrbrOqQ26P@wuerfel> <14254005.QkaJhTuY5H@wuerfel>
 <54E5FBEA.1000005@suse.cz> <5822078.VORY4BTfEj@wuerfel>
Message-ID: <54E70B52.9040708@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-02-20 10:29, Arnd Bergmann wrote:
> On Thursday 19 February 2015 16:06:18 Michal Marek wrote:
>>> We have similar problems in other areas
>>> of the kernel. In theory, we could enforce the VIDEO_TUNER driver to
>>> be modular here by adding lots of dependencies to it:
>>>
>>> config VIDEO_TUNER
>>>       tristate
>>>       depends on MEDIA_TUNER_TEA5761 || !MEDIA_TUNER_TEA5761
>>>       depends on MEDIA_TUNER_TEA5767 || !MEDIA_TUNER_TEA5767
>>>       depends on MEDIA_TUNER_MSI001  || !MEDIA_TUNER_MSI001
>>
>> Nah, that's even uglier. I suggest to merge your IS_REACHABLE patch.
>>
> 
> Ok, can I take this as an ack from your side to merge the
> include/linux/kconfig.h part of the patch through the linux-media
> tree?

Yes. If you want

Acked-by: Michal Marek <mmarek@suse.cz> [kconfig]


> I thought about splitting up the patch into two, but that would
> just make merging it harder because we'd still have the dependency.

Agreed, no need to pedantically split patches just for the sake of it.

Michal
