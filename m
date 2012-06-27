From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jun 2012 10:41:23 +0100
Subject: [PATCH 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <4FEA6AE7.4050000@codeaurora.org>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <1340377774-17173-3-git-send-email-will.deacon@arm.com>
 <4FE8DA7E.5040105@codeaurora.org>
 <20120626104944.GE27996@mudshark.cambridge.arm.com>
 <4FEA6AE7.4050000@codeaurora.org>
Message-ID: <20120627094123.GB27431@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 03:07:35AM +0100, Stephen Boyd wrote:
> On 06/26/12 03:49, Will Deacon wrote:
> > I suppose I could allow the function to fail if it's called after we've
> > calibrated. What do you reckon?
> >
> 
> Fair enough. Would anything actually go wrong if you called it twice? I
> would think everything would be assigned to what it already is but I
> haven't thought deeply about it. I don't really care to make the
> function more complicated for a case that should never happen.

If it's called once before calibration and again after calibration then that
could cause problems if a different frequency is passed. However, I think we
can probably leave the function as-is until we have the capacity to support
multiple read_current_timer implementations in the same kernel. At that
point, we'd probably have a way to register the current_timer which could
also setup the delay loop.

Will
