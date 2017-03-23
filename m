From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 13:45:29 +0000
Subject: [RFC PATCH v2 21/41] arm64/sve: Enable SVE on demand for userspace
In-Reply-To: <20170323134023.GG9287@leverpostej>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-22-git-send-email-Dave.Martin@arm.com>
 <20170322164809.GC19950@leverpostej>
 <20170323112404.GC3750@e103592.cambridge.arm.com>
 <98bf1730-7579-d9f9-37c0-75ccfc29087b@arm.com>
 <20170323115227.GD9287@leverpostej>
 <20170323120726.GF3750@e103592.cambridge.arm.com>
 <20170323134023.GG9287@leverpostej>
Message-ID: <20170323134529.GH3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 01:40:24PM +0000, Mark Rutland wrote:
> On Thu, Mar 23, 2017 at 12:07:26PM +0000, Dave Martin wrote:

[...]

> > My logic was that sanitisation makes no sense for anything except
> > read-only ID registers, and _system_ sounds too universal.
> > 
> > There is a sting in the tail here -- I add ZCR as an "id" reg so that we
> > can treat the maximum configurable length in the LEN field as if it were
> > an ID field.  See patch 38 (apologies Suzuki, missed your CC).
> > 
> > In fact, ZCR is neither read-only nor an ID register -- but the view of
> > it through cpufeatures does have those properties.
> > 
> > It might be better to rename it, but I considered it an OK compromise.
> > Let me know if you have concerns.
> 
> FWIW, I'm fine with read_sanitised_id_reg(), even considering the ZCR
> case, given we're using it for feature identification information.
> 
> At best, we only need a comment over the ZCR field definitions in
> arch/arm64/kernel/cpufeature.c, explaining what's going on.

Could be a good idea -- I'll add a comment or two.

> Perhaps read_sanitised_ftr_reg() covers that better? That might align
> better with the existing *_ftr_reg() naming.

Happy to go with that if nobody objects.

Cheers
---Dave
