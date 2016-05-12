From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 12 May 2016 22:01:13 +0300
Subject: [PATCH] PM / Runtime: Defer resuming of the device in
 pm_runtime_force_resume()
In-Reply-To: <CAPDyKFpOxabizwQqhtKb-h0vGpTRtrCa0nPxAKMY22rnjLCouw@mail.gmail.com>
References: <1461234842-22820-1-git-send-email-ulf.hansson@linaro.org>
 <5465506.Z3sjI0lQh6@avalon>
 <CAPDyKFpOxabizwQqhtKb-h0vGpTRtrCa0nPxAKMY22rnjLCouw@mail.gmail.com>
Message-ID: <4661739.p5SU9QcIps@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday 27 Apr 2016 16:23:49 Ulf Hansson wrote:
> [...]
> 
> >> Following you reasoning, I agree!
> >> 
> >> Let's put this patch on hold for a little while. I am already working
> >> on changing genpd, so it shouldn't take long before I can post some
> >> additional genpd patches improving the behaviour.
> > 
> > I'd like to see something merged for v4.7 if possible. I agree that my
> > patch isn't a long term solution (we want to avoid adding additional
> > fields to the device power structure), but it has the benefit of being
> > available now and fixing the problem I ran into with drivers that would
> > be broken on v4.7 without a fix. Do you think you could get a better fix
> > ready in time for v4.7 ? If so I'm fine with dropping this patch, but
> > otherwise I'd prefer to get it merged and reverted as part of your better
> > implementation for v4.8.
> 
> My impression was that devices becomes unnecessary resumed when they
> don't need to. They won't stay resumed as the PM core invokes
> pm_runtime_put() in the system PM complete phase.
> 
> So, in the end I think we are trying to optimize a behaviour here, but
> not fix something that is "broken", correct?
> 
> Anyway, I have no objections to your proposed solution, so I leave it
> to Rafael and Kevin to decide what to do.

Kevin, Rafael, any comment ? I need to fix PM support in a driver that is 
currently broken partly due to this issue. Which of "PM / Runtime: Only force-
resume device if it has been force-suspended" and this patch should we merge, 
if any ?

> From my side I will continue with the improvements for the system PM
> support in genpd.

Thanks.

-- 
Regards,

Laurent Pinchart
