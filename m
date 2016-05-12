From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 12 May 2016 22:28:22 +0200
Subject: [PATCH] PM / Runtime: Defer resuming of the device in
 pm_runtime_force_resume()
In-Reply-To: <4661739.p5SU9QcIps@avalon>
References: <1461234842-22820-1-git-send-email-ulf.hansson@linaro.org>
 <5465506.Z3sjI0lQh6@avalon>
 <CAPDyKFpOxabizwQqhtKb-h0vGpTRtrCa0nPxAKMY22rnjLCouw@mail.gmail.com>
 <4661739.p5SU9QcIps@avalon>
Message-ID: <CAJZ5v0jTAM74asCM5gG5wBWn+gvSQ21_W6dY9WQD+cMybUnEEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 9:01 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hello,
>
> On Wednesday 27 Apr 2016 16:23:49 Ulf Hansson wrote:
>> [...]
>>
>> >> Following you reasoning, I agree!
>> >>
>> >> Let's put this patch on hold for a little while. I am already working
>> >> on changing genpd, so it shouldn't take long before I can post some
>> >> additional genpd patches improving the behaviour.
>> >
>> > I'd like to see something merged for v4.7 if possible. I agree that my
>> > patch isn't a long term solution (we want to avoid adding additional
>> > fields to the device power structure), but it has the benefit of being
>> > available now and fixing the problem I ran into with drivers that would
>> > be broken on v4.7 without a fix. Do you think you could get a better fix
>> > ready in time for v4.7 ? If so I'm fine with dropping this patch, but
>> > otherwise I'd prefer to get it merged and reverted as part of your better
>> > implementation for v4.8.
>>
>> My impression was that devices becomes unnecessary resumed when they
>> don't need to. They won't stay resumed as the PM core invokes
>> pm_runtime_put() in the system PM complete phase.
>>
>> So, in the end I think we are trying to optimize a behaviour here, but
>> not fix something that is "broken", correct?
>>
>> Anyway, I have no objections to your proposed solution, so I leave it
>> to Rafael and Kevin to decide what to do.
>
> Kevin, Rafael, any comment ? I need to fix PM support in a driver that is
> currently broken partly due to this issue. Which of "PM / Runtime: Only force-
> resume device if it has been force-suspended" and this patch should we merge,
> if any ?

My and Kevin's assumption was that Ulf would provide a better fix
shortly, but I'm not sure how realistic that is.

Ulf?
