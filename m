From: labbott@redhat.com (Laura Abbott)
Date: Mon, 24 Oct 2016 10:58:10 -0700
Subject: [PATCH 00/10] arm64: move thread_info off of the task stack
In-Reply-To: <20161024174840.GR15620@leverpostej>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
 <10401f46-cabc-23ec-a448-c377dbce7911@redhat.com>
 <20161024174840.GR15620@leverpostej>
Message-ID: <fb8c8a44-36c8-9bbb-5cbb-9b42fd815d8d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 10:48 AM, Mark Rutland wrote:
> On Mon, Oct 24, 2016 at 10:38:59AM -0700, Laura Abbott wrote:
>> On 10/19/2016 12:10 PM, Mark Rutland wrote:
>>> Hi all,
>>>
>>> Building atop of Andy's work on x86 and generic code, these patches move
>>> arm64's thread_info off of the stack and into task_struct. This protects
>>> thread_info from corruption in the face of stack overflow, and serves as
>>> a step towards fully robust stack overflow handling, which will be
>>> addressed by subsequent patches.
>>>
>>> These patches are based atop of a preparatory series [1] (itself based
>>> on v4.9-rc1) that's also necessary for s390. I've placed those patches
>>> in a branch [2] on my kernel.org repo, along with this series [3]. I'm
>>> hoping that the prep work will be able to become a stable branch/tag
>>> soon.
>>>
>>> I've given the series some light testing on a couple of SMP arm64
>>> platforms, but this has yet to see a thorough beating; please do try to
>>> make this fall over!
>>>
>>> Since RFC [4]:
>>> * Rely on prior patches to make thread_info arch-specific
>>> * Make smp_processor_id() use a per-cpu variable
>>> * Split out current_stack_pointer
>>> * Make SMP actually work
>>>
>>> [1] http://lkml.kernel.org/r/1476901693-8492-1-git-send-email-mark.rutland at arm.com
>>> [2] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=core/ti-stack-split
>>> [3] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/ti-stack-split
>>> [4] http://lkml.kernel.org/r/1473947349-14521-1-git-send-email-mark.rutland at arm.com
>
>> I pulled the arm64/ti-stack-split branch on top of a Fedora
>> tree and ran back-to-back kernel RPM builds for a long weekend.
>> It's still going as of this morning so you can take that as a
>>
>> Tested-by: Laura Abbott <labbott@redhat.com>
>
> Thanks! That's much appreciated!
>
> Just to check, did you grab the version with entry.S fixes rolled in
> (where the head is 657f54256c427fec)?

Ah I did not. That came in after I started the test. I'll start
another run with the new version.

>
> Thanks,
> Mark.
>

Thanks,
Laura
