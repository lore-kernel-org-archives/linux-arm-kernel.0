From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 15:56:48 +0200
Subject: [PATCH 0/2] cpuidle fixes and cleanup
In-Reply-To: <CADWw7OgCgg8aE4W6LwmU3axDdmt-5uH=a+0fSSErfqDci3nNUA@mail.gmail.com>
References: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
 <20140701145244.GX32514@n2100.arm.linux.org.uk>
 <CADWw7OgCgg8aE4W6LwmU3axDdmt-5uH=a+0fSSErfqDci3nNUA@mail.gmail.com>
Message-ID: <53BBF8A0.1050005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.07.2014 05:11, Chander Kashyap wrote:
> On Tue, Jul 1, 2014 at 8:22 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Jul 01, 2014 at 08:02:36PM +0530, Chander Kashyap wrote:
>>> This patch series fixes the cpuidle for different states. Also removes arm
>>> diagnostic and power register save/restore code as it is made generic.
>>>
>>> Based on:
>>> ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
>>>  http://www.spinics.net/lists/arm-kernel/msg340506.html

[Ccing people who participated in discussion in that thread]

>>
>> As there is an outstanding issue with this patch, we can't proceed with
>> this set of changes until we know what's going on there.
> 
> Sure, I will wait for the conclusion.

So I believe the conclusion was that this can't be handled in generic
way, because on systems running in non-secure mode writing to those
registers faults.

However I believe this could be moved into generic helpers.

Best regards,
Tomasz
