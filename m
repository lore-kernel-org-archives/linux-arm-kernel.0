From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Apr 2014 11:10:02 +0200
Subject: [PATCH 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
In-Reply-To: <20140403141533.GP7528@n2100.arm.linux.org.uk>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140403160727.17b3558b@skate>
 <20140403141533.GP7528@n2100.arm.linux.org.uk>
Message-ID: <20140407111002.36488aed@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

On Thu, 3 Apr 2014 15:15:33 +0100, Russell King - ARM Linux wrote:

> > Any comments about the proposed patches? These are important for the
> > recent Armada 375/38x platforms and I'm sure will require a bit of
> > discussion. Moreover, one of the patch affects the L2 cache driver that
> > Russell is currently working on, so it would be nice if we could get
> > the discussion going soon.
> 
> Will is away for another week and a half.

Ok. However I believe Will and Catalin are the best placed to give all
the fine details about this problem.

> There is an important point to be made about the L2 cache though - it is
> not possible to disable the "sync" at the L2 cache - any register write
> automatically invokes a sync before it is actioned, so avoiding the
> explicit sync doesn't stop them from happening, it just reduces the
> number which occur.
> 
> Is it possible that you are hitting one of the PL310 errata?

As far as I'm aware, there is no PL310 errata registered for this
problem: at least I asked Will and Catalin about this, and they never
came up with a PL310 errata. My understanding is that the problem here
is not a deficiency of the PL310 itself, but rather an unfortunate
interaction between the PL310 behavior, the hardware I/O coherency and
the PCIe transactions.

The suggested fix to disable explicit outer cache sync, and map PCIe
regions are strongly ordered was proposed by ARM as a solution to the
deadlocks, and it was tested successfully.

I am hoping that Catalin and Will will enter the discussion and give
the details you need to fully understand the problem.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
