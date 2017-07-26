From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Jul 2017 09:27:11 +0100
Subject: [PATCH] perf: qcom_l2: fix column exclusion check
In-Reply-To: <95095f56-7b08-4ed9-f7e5-5d5768a75cc5@codeaurora.org>
References: <1500931022-21000-1-git-send-email-nleeder@codeaurora.org>
 <20170725170105.GF12749@leverpostej>
 <95095f56-7b08-4ed9-f7e5-5d5768a75cc5@codeaurora.org>
Message-ID: <20170726082710.GA31242@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 03:43:54PM -0400, Leeder, Neil wrote:
> On 7/25/2017 1:01 PM, Mark Rutland wrote:
> > On Mon, Jul 24, 2017 at 05:17:02PM -0400, Neil Leeder wrote:
> >> The check for column exclusion did not verify that the event being
> >> checked was an L2 event, and not a software event.
> >> Software events should not be checked for column exclusion.
> >> This resulted in a group with both software and L2 events sometimes
> >> incorrectly rejecting the L2 event for column exclusion and
> >> not counting it.
> >>
> >> Add a check for PMU type before applying column exclusion logic.
> >>
> >> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> > 
> > This looks correct, so:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Should this have:
> > 
> > Fixes: 21bdbb7102edeaeb ("perf: add qcom l2 cache perf events driver")
> > 
> > ... ?
> > 
> Thanks. I'll re-post with the Fixes tag.

No need, I'll pick it up and add it when I apply.

Cheers,

Will
