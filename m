From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 12 Jul 2015 01:06:27 +0300
Subject: [PATCH 3/3] arm64, mm: Use IPIs for TLB invalidation.
In-Reply-To: <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
 <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <55A19363.1050506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/11/2015 11:25 PM, David Daney wrote:

> From: David Daney <david.daney@cavium.com>

> Most broadcast TLB invalidations are unnecessary.  So when
> invalidating for a given mm/vma target the only the needed CPUs via

    The only the needed?

> and IPI.

> For global TLB invalidations, also use IPI.

> Tested on Cavium ThunderX.

> This change reduces 'time make -j48' on kernel from 139s to 116s (83%
> as long).

> The patch is needed because of a ThunderX Pass1 erratum: Exclusive
> store operations unreliable in the presence of broadcast TLB
> invalidations.  The performance improvements shown make it compelling
> even without the erratum workaround need.

> Signed-off-by: David Daney <david.daney@cavium.com>

WBR, Sergei
