From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Oct 2017 09:39:44 +0100
Subject: [PATCH 0/6] Switch arm64 over to qrwlock
In-Reply-To: <9e2468c3-894e-1204-4578-3d8266c56d6c@arm.com>
References: <1507208097-825-1-git-send-email-will.deacon@arm.com>
 <9e2468c3-894e-1204-4578-3d8266c56d6c@arm.com>
Message-ID: <20171006083944.GA10941@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Thu, Oct 05, 2017 at 05:12:44PM -0500, Jeremy Linton wrote:
> On 10/05/2017 07:54 AM, Will Deacon wrote:
> >This patch series reworks bits of the qrwlock code that it can be used
> >to replace the asm rwlocks currently implemented for arm64. The structure
> >of the series is:
> >
> >   Patches 1-3	: Work WFE into qrwlock using atomic_cond_read_acquire so
> >		  we can avoid busy-waiting.
> >
> >   Patch 4	: Enable qrwlocks for arm64
> >
> >   Patch 5-6	: Ensure writer slowpath fairness. This has a potential
> >		  performance impact on the writer unlock path, so I've
> >		  kept them at the end.
> >
> >The patches apply on top of my other locking cleanups:
> >
> >   http://lkml.kernel.org/r/1507055129-12300-1-git-send-email-will.deacon at arm.com
> >
> >although the conflict with mainline is trivial to resolve without those.
> >The full stack is also pushed here:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git qrwlock
> >
> >All comments (particularly related to testing and performance) welcome!
> 
> I haven't done any perf testing, but the machines continue to boot, and the
> stress-ng test which causes task lock problems with the normal arm64 rwlock
> now appears to run as expected. So, its a good start!

Excellent! Mind if I add your tested-by?

Will
