From: slash.tmp@free.fr (Mason)
Date: Thu, 04 Jun 2015 23:00:06 +0200
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
In-Reply-To: <20150604203732.GI5710@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel> <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com> <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com> <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com> <5570B5E8.90300@free.fr>
 <20150604203732.GI5710@saruman.tx.rr.com>
Message-ID: <5570BC56.1090305@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2015 22:37, Felipe Balbi wrote:
> On Thu, Jun 04, 2015 at 10:32:40PM +0200, Mason wrote:
>> On 04/06/2015 22:08, Felipe Balbi wrote:
>>
>>> On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
>>>> Also, check /proc/timer_list for a "Broadcast device". If you don't
>>>> define one, the TWD timers are set to periodic mode, with hrtimers
>>>> disabled.
>>>
>>> Did you manage to turn global timer into Broadcast device ?
>>
>> Disclaimer: I am a kernel noob, take everything I say with
>> a rock of salt.
>>
>> As far as I can see, the global timer code doesn't handle
>> frequency changes, whereas the TWD code does.
> 
> All right, but TWD has C3STOP and that prevents it from being used as
> broadcast device.

AFAICT, my platform doesn't stop the local timers in low-power
mode, so I just dropped the CLOCK_EVT_FEAT_C3STOP flag.

There's even a patch approved by Arnd somewhere in the thread,
although he did recommend I should investigate to understand
the problem better.

Regards.
