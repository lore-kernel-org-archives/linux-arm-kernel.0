From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jan 2018 18:44:47 +0000
Subject: [PATCH] arm64: Implement branch predictor hardening for Falkor
In-Reply-To: <20180108170933.GU25869@arm.com>
References: <1515184139-23743-1-git-send-email-shankerd@codeaurora.org>
 <20180108170933.GU25869@arm.com>
Message-ID: <20180108184446.GC13175@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 05:09:33PM +0000, Will Deacon wrote:
> On Fri, Jan 05, 2018 at 02:28:59PM -0600, Shanker Donthineni wrote:
> > Falkor is susceptible to branch predictor aliasing and can
> > theoretically be attacked by malicious code. This patch
> > implements a mitigation for these attacks, preventing any
> > malicious entries from affecting other victim contexts.
> 
> Thanks, Shanker. I'll pick this up (fixing the typo pointed out by Drew).

Note that MIDR_FALKOR doesn't exist in mainline, so I had to drop those
changes too. See the kpti branch for details.

If you'd like anything else done here, please send additional patches to me
and Catalin that we can apply on top of what we currently have. Note that
I'm in the air tomorrow, so won't be picking up email.

Cheers,

Will
