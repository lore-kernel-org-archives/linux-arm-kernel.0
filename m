From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Feb 2015 17:17:04 +0000
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
In-Reply-To: <54EDFEC4.7060600@codeaurora.org>
References: <loom.20150213T053547-381@post.gmane.org>
 <20150213105447.GB3508@e104818-lin.cambridge.arm.com>
 <loom.20150213T124417-857@post.gmane.org>
 <20150213141425.GA4713@localhost>
 <loom.20150213T153239-809@post.gmane.org>
 <20150213153253.GA23801@e104818-lin.cambridge.arm.com>
 <loom.20150218T122348-60@post.gmane.org>
 <54E7AC90.40209@codeaurora.org>
 <20150224101754.GA27420@e104818-lin.cambridge.arm.com>
 <54EDFEC4.7060600@codeaurora.org>
Message-ID: <20150225171703.GG1105@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 11:56:36AM -0500, Christopher Covington wrote:
> On 02/24/2015 05:17 AM, Catalin Marinas wrote:
> > Writing CNTFRQ from non-secure mode would trap as well.
> 
> Are you saying it could A) cause an exception targeting the current EL/mode
> but not others, or B) cause an exception targeting the current or another EL/mode?

IIRC, it only traps at the current mode (if non-secure EL1 or EL2).

> > The detection mechanism would have to involve trapping of an undefined
> > instruction but it doesn't need to be done early during boot.
> 
> I put detection during early boot because I wanted to potentially change
> ELs/modes during early boot.

Yes, but it is simpler to install an undef hook later in the boot
process.

-- 
Catalin
