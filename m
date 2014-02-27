From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Feb 2014 13:20:21 +0900
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140226154858.GC10246@arm.com>
References: <1393302345-18253-1-git-send-email-broonie@kernel.org>
 <1393302345-18253-2-git-send-email-broonie@kernel.org>
 <20140225165411.GA3883@red-moon>
 <20140226005052.GA31120@sirena.org.uk>
 <20140226123208.GB22839@e102568-lin.cambridge.arm.com>
 <20140226144610.GA2394@sirena.org.uk>
 <20140226154858.GC10246@arm.com>
Message-ID: <20140227042021.GE9383@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 03:48:58PM +0000, Catalin Marinas wrote:

> My concern is that the MPIDR is just considered a unique ID. The ARMv8
> relaxes the requirement so that it no longer needs to start at 0 and
> increase monotonically. I checked with the architecture guys here and
> they still expect the affinity hierarchy to be described by MPIDR but we
> can have holes in the range for certain levels (i.e. an affinity level
> may not start at 0 and may not even increase monotonically for
> subsequent CPUs).

I don't think anything has a problem with holes in the number range, the
only thing I can think of which imposes that requirement is the DT
binding but obviously that's not relevant if we are using MPIDR.  The
core topology documentation explicitly says that these are physical IDs
and entirely up to the architecture/platform.  It'd seem odd given that
we have hotplug support.

What problems do you anticipate?

> So we can either add a tolerant MPIDR parsing or we simply assume that
> the topology is _flat_ when DT doesn't provide the information.

Right, that's what the current code does but I'm not sure it's the best
option.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/02fdbbc0/attachment.sig>
