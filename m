From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 11 May 2016 09:31:56 +0200
Subject: [PATCH 1/2] clocksource: sp804: Add support for OX810SE 24bit
 timer width
In-Reply-To: <20160426163055.GB13887@linaro.org>
References: <1459520559-13110-1-git-send-email-narmstrong@baylibre.com>
 <1459520559-13110-2-git-send-email-narmstrong@baylibre.com>
 <20160422074645.GA3974@linaro.org> <alpine.DEB.2.11.1604220953000.3941@nanos>
 <571E2E38.3060401@baylibre.com> <20160426163055.GB13887@linaro.org>
Message-ID: <5732DFEC.6070605@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2016 06:30 PM, Daniel Lezcano wrote:
> On Mon, Apr 25, 2016 at 04:48:24PM +0200, Neil Armstrong wrote:
>> On 04/22/2016 09:53 AM, Thomas Gleixner wrote:
>>> On Fri, 22 Apr 2016, Daniel Lezcano wrote:
>>>
>>>> On Fri, Apr 01, 2016 at 04:22:38PM +0200, Neil Armstrong wrote:
>>>>> In order to support the Dual-Timer on the Oxford Semiconductor OX810SE SoC,
>>>>> implement variable counter width, keeping 32bit as default width.
>>>>> Add new compatible string oxsemi,ox810se-rps-timer in order to select
>>>>> the 24bit counter width.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>> ---
>>>>>  drivers/clocksource/timer-sp804.c | 107 ++++++++++++++++++++++++--------------
>>>>>  include/clocksource/timer-sp804.h |  42 ++++++++++++---
>>>>>  2 files changed, 102 insertions(+), 47 deletions(-)
>>>>
>>>> I will take those patches but this driver really deserves a cleanup.
>>>
>>> If it deserves a cleanup, then this should happen _BEFORE_ we add new
>>> functionality to it.
>>>
>>> Thanks,
>>>
>>> 	tglx
>>>
>>
>> Hi Thomas, Daniel,
>>
>> Sure this driver should have a cleanup, but it still depends on old legacy vexpress calls.
>>
>> The reason I submitted a change and a small cleanup over this driver is because the high
>> similarities of the HW and avoiding adding a brand new driver cloning much of its
>> functionalities.
> 
> Hi Neil,
> 
> it is a good idea to avoid having new drivers when it is possible to group 
> them into a single one.
>  
>> I propose to study an eventual cleanup, but could this change be submitted for 4.7 since
>> it's part of a base platform support serie ?
> 
> I am not against if the next patches you send are cleanups.
> 
> Thomas ?
> 

Hi Thomas,

Is the proposition acceptable ? When this patchset will hit 4.7, I will work on a rework for 4.8.

Thanks,
Neil
