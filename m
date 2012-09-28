From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 28 Sep 2012 16:30:16 -0500
Subject: [PATCH V2 0/7] ARM: OMAP2+: Add device-tree support for timers
In-Reply-To: <5065F19E.5020708@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <505A7E0B.30709@ti.com> <20120920235309.GO28835@atomide.com>
 <5063330E.3000203@ti.com> <5065F19E.5020708@ti.com>
Message-ID: <506616E8.9000006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/28/2012 01:51 PM, Vaibhav Hiremath wrote:
> 
> 
> On 9/26/2012 10:23 PM, Jon Hunter wrote:
>>
>> On 09/20/2012 06:53 PM, Tony Lindgren wrote:
>>> * Benoit Cousson <b-cousson@ti.com> [120919 19:24]:
>>>> Hi Tony,
>>>>
>>>> I was about to take the DTS patch, but was wondering if you will pull
>>>> the driver changes for 3.7.
>>>
>>> I suggest that you do a separate branch on top of Paul's hwmod series
>>> when he posts those if that works for you?
>>
>> Benoit, I see that you have pulled in the DTS patch.
>>
>> Do you guys want me to rebase the remaining patches with Rob's change on
>> Tony's master branch and re-submit?
>>
> 
> Jon,
> 
> Sorry for delayed response, But I tried using your omap_test application
> to validate this patch series, but it is failing for me.
> 
> How did you test it? Are you running same test application at your end?

Check your email on Sept 14th. I sent you the latest version of the test
code. I will resend in case it got lost in deep space.

> I am debugging this issue, i just thought I should tell you this before
> its too late.
> 
> 
> Below is the log -
> 
> [root at arago /]# echo 3 > /tmp/omap-test/timer/one
> [   79.612223] omap_dm_timer_request_specific: Please use
> omap_dm_timer_request_by_cap()
> [   79.620636] Timer 3 not available!

Yes that's expected as omap_dm_timer_request_specific is not supported
with DT. Don't spend anytime debugging you just need the latest test.

Cheers
Jon
