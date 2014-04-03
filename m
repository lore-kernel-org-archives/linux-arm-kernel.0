From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Apr 2014 15:15:33 +0100
Subject: [PATCH 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
In-Reply-To: <20140403160727.17b3558b@skate>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140403160727.17b3558b@skate>
Message-ID: <20140403141533.GP7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 04:07:27PM +0200, Thomas Petazzoni wrote:
> Russell, Will, Catalin,
> 
> Any comments about the proposed patches? These are important for the
> recent Armada 375/38x platforms and I'm sure will require a bit of
> discussion. Moreover, one of the patch affects the L2 cache driver that
> Russell is currently working on, so it would be nice if we could get
> the discussion going soon.

Will is away for another week and a half.

There is an important point to be made about the L2 cache though - it is
not possible to disable the "sync" at the L2 cache - any register write
automatically invokes a sync before it is actioned, so avoiding the
explicit sync doesn't stop them from happening, it just reduces the
number which occur.

Is it possible that you are hitting one of the PL310 errata?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
