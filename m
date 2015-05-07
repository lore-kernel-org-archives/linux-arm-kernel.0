From: bintian.wang@huawei.com (Bintian)
Date: Thu, 7 May 2015 21:06:16 +0800
Subject: [PATCH v4 0/5] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <20150507125752.GE22115@arm.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <20150507090210.GB22115@arm.com> <554B305F.4080907@huawei.com>
 <20150507112536.GD22115@arm.com> <554B542B.6040006@huawei.com>
 <20150507125752.GE22115@arm.com>
Message-ID: <554B6348.3000200@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

On 2015/5/7 20:57, Will Deacon wrote:
> On Thu, May 07, 2015 at 01:01:47PM +0100, Bintian wrote:
>> On 2015/5/7 19:25, Will Deacon wrote:
>>> On Thu, May 07, 2015 at 10:29:03AM +0100, Bintian wrote:
>>>> Hikey is a low cost board, I think it doesn't have an automatic thermal
>>>> cut out; I always use HiKey to test my patch, in the normal case,
>>>> temperature is not a problem.
>>>
>>> I don't see why the cost has anything to do with this issue; any money I
>>> save on the board will quickly be re-invested in my increased insurance
>>> premium.
>>>
>>> All I think we need is for secure software to keep an eye on the temperature
>>> and hit the power controller if it goes over some `fatal' threshold.
>>> Ideally, you'd be able to use a secure interrupt for this, but I suspect
>>> that you don't have the right hardware features for that (please correct me
>>> if I'm wrong). An alternative would be to hang something off a secure timer
>>> and get the firmware to check the board temperature on some low-frequency
>>> periodic tick.
>> If there is exception occurred on A core, there are two methods to
>> handle it:
>> (1) Delay for a period of time, watchdog will trigger the system reset.
>> (2) If the temperature is over 105 degree, the CPU will trigger reset(I
>> guess it's chip level).
>
> Aha, so now you're saying that there *is* a hardware shut-off at 105
> degrees, regardless of what the kernel is doing?
Yes!

> If that's the case, then
> we're fine and the current patches make sense in isolation.
Thank you very much and I need your ack in next version :)
I am preparing the next version and will send out soon.

Thanks,

Bintian

>
> Cheers,
>
> Will
>
> .
>
