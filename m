From: khilman@ti.com (Kevin Hilman)
Date: Wed, 14 Mar 2012 07:23:59 -0700
Subject: [linux-pm] [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <CAMbhsRRD2bdkcUZvScb-cF05e=R3h69bNVaTPFX4jBKBBOjuMg@mail.gmail.com>
 (Colin Cross's message of "Tue, 13 Mar 2012 17:47:20 -0700")
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4F1929E9.7070707@linaro.org> <8762e8kqi6.fsf@ti.com>
 <CAMbhsRRZ+xt179RN32-+eBWngbRow=MpKV1XcLvG-sHGF6VOJA@mail.gmail.com>
 <CAMbhsRRD2bdkcUZvScb-cF05e=R3h69bNVaTPFX4jBKBBOjuMg@mail.gmail.com>
Message-ID: <87mx7jjm68.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross <ccross@android.com> writes:

> On Tue, Mar 13, 2012 at 5:28 PM, Colin Cross <ccross@android.com> wrote:
>> On Tue, Mar 13, 2012 at 4:52 PM, Kevin Hilman <khilman@ti.com> wrote:

[...]

>>>
>>> Checking the ready_count seemed like an easy way to do this, but did you
>>> have any other mechanisms in mind for CPUs to communicate that they've
>>> exited/aborted?
>>
>> Why not set a flag from CPU1 when it exits the low power state, and
>> have CPU0 spin on the powerdomain register or the flag? ?You can then
>> use the parallel barrier function to ensure both cpus have seen the
>> flag and reset it to 0 before returning.
>
> I realized the parallel barrier helper was not included in the patch
> set I posted, it will be in the next patch set.  

Do you have an ETA for the next patchset?  I'll be glad to give it a
spin on OMAP4.

> Short version, no caller to cpuidle_coupled_parallel_barrier will
> return before all cpus in the coupled set have called it.  It allows
> you to resynchronize the cpus after an abort to ensure they have all
> seen the abort flag before clearing it and returning, leaving
> everything in the correct state for the next idle attempt.

OK, this sounds like it will work well for what I need.

Kevin
