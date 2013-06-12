From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 09:55:49 -0600
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <20130612090729.GA20236@e102568-lin.cambridge.arm.com>
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
 <51B748BB.7070602@wwwdotorg.org>
 <20130611162224.GA13741@e102568-lin.cambridge.arm.com>
 <51B754F5.4070109@wwwdotorg.org>
 <20130612090729.GA20236@e102568-lin.cambridge.arm.com>
Message-ID: <51B89A05.6020503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 03:07 AM, Lorenzo Pieralisi wrote:
> On Tue, Jun 11, 2013 at 05:48:53PM +0100, Stephen Warren wrote:
>> On 06/11/2013 10:22 AM, Lorenzo Pieralisi wrote:
>>> Hi Stephen,
>>>
>>> On Tue, Jun 11, 2013 at 04:56:43PM +0100, Stephen Warren wrote:
>>>> On 06/11/2013 03:58 AM, Lorenzo Pieralisi wrote:
>>>>> Hi Russell, all,
>>>>>
>>>>> even though I think this set is ready to get merged, it would be great
>>>>> if we can test it on as many platforms as possible since it touches core
>>>>> suspend/resume operations on ARM platforms relying on CONFIG_ARM_CPU_SUSPEND,
>>>>> and there are many.
>>>>
>>>> FWIW, I booted a Tegra system with these patches applied and didn't see
>>>> any issue in very brief testing. I'm not sure what targeted testing
>>>> would be useful?
>>>
>>> That's great thanks. CPUidle deep C-states (when CPUs resume from reset
>>> through cpu_resume) are the main triggers of this code, so you should be
>>> running with them enabled to test it.
>>
>> OK, in that case I believe I tested that; I had our "LP2" CPU
>> power-management mode enabled as always, and that powers off the CPUs
>> and resumes them, and didn't see any issue.
> 
> Great, thanks, I guess this also means you did not notice any suspicious
> warnings at boot (ie "Large number of MPIDR hash buckets detected").

I didn't, although I didn't look that hard for them!

> Can I add your tested-by please ?

Sure.
