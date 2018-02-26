From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Feb 2018 10:45:05 +0000
Subject: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <3fa9ebcb-fe94-bbd6-49a7-e90c91c3905e@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
 <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
 <20180226100518.GA11378@kroah.com>
 <3fa9ebcb-fe94-bbd6-49a7-e90c91c3905e@linaro.org>
Message-ID: <20180226104505.GB8736@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 06:40:42PM +0800, Alex Shi wrote:
> 
> 
> On 02/26/2018 06:05 PM, Greg KH wrote:
> > On Mon, Feb 26, 2018 at 04:20:20PM +0800, Alex Shi wrote:
> >> From: Marc Zyngier <marc.zyngier@arm.com>
> >>
> >> ** Not yet queued for inclusion in mainline **
> > 
> > As Marc said, this should have been a HUGE clue that we can't take this
> > patch.  Please go re-read
> > 	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> 
> Thanks for comments, Greg!
> 
> I read the rules for several times, and thought it maybe a exception for
> this bug fix. But since MarcZ said so. We can wait. :)

The reason I added the disclaimer to the commit message was precisely to
avoid these things accidentally going into stable. If stable diverges
significantly from mainline, it's just going to make backports of other
patches more difficult. So no, we shouldn't be considering an exception
for this.

Will
