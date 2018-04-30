From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 30 Apr 2018 10:53:17 +0100
Subject: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
In-Reply-To: <CAEi0qNkt75cqF=03HrQ81+pDdWVOpzGiHrk8_cTNTJo9os9D8Q@mail.gmail.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <e0b5ae90-f21e-f5db-a4af-52900a2e8c07@arm.com>
 <CAEi0qNkt75cqF=03HrQ81+pDdWVOpzGiHrk8_cTNTJo9os9D8Q@mail.gmail.com>
Message-ID: <07a0b8c1-3d87-0cae-61df-dbff782be301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/04/18 07:37, Joel Fernandes wrote:
> On Wed, Jan 17, 2018 at 4:10 AM, Julien Thierry <julien.thierry@arm.com> wrote:
>> Hi,
>>
>> On 17/01/18 11:54, Julien Thierry wrote:
>>>
>>> This series is a continuation of the work started by Daniel [1]. The goal
>>> is to use GICv3 interrupt priorities to simulate an NMI.
>>>
>>
>>
>> I have submitted a separate series making use of this feature for the ARM
>> PMUv3 interrupt [1].
> 
> I guess the hard lockup detector using NMI could be a nice next step
> to see how well it works with lock up detection. That's the main
> usecase for my interest. However, perf profiling is also a strong one.
> 

 From my understanding, Linux's hardlockup detector already uses the ARM 
PMU interrupt to check whether some task is stuck. I haven't looked at 
the details of the implementation yet, but in theory having the PMU 
interrupt as NMI should make the hard lockup detector use the NMI.

When I do the v3, I'll have a look at this to check whether the 
hardlockup detector works fine when using NMI.

Cheers,

-- 
Julien Thierry
