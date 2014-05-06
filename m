From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 May 2014 12:07:22 +0200
Subject: [PATCH 2/3] ARM: mm: add support for HW coherent systems in PL310
In-Reply-To: <20140409140625.GI13737@arm.com>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395677872-32741-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140408172424.GE16373@arm.com> <20140408201212.067d526d@skate>
 <20140409140625.GI13737@arm.com>
Message-ID: <20140506120722.61bef801@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin Marinas,

On Wed, 9 Apr 2014 15:06:25 +0100, Catalin Marinas wrote:

> > In fact, I'm not sure using a separate compatible string is possible,
> > because there are situations where the hardware platform may be I/O
> > coherent, and some situations where it is not the case. For example, in
> > the current kernel, the platform is I/O coherent when CONFIG_SMP is
> > enabled, but not I/O coherent when CONFIG_SMP is disabled. And it's the
> > same hardware platform, so same Device Tree in both cases.
> 
> I think Russell has a better solution in his L2 cache cleanup series.
> Patch 18/44 introduces a .fixup function which takes the outer_cache_fns
> pointer and that's a place where your code can check whether coherency
> is present or not (and turn .sync into NULL).

I had a look at the .fixup proposal, but I don't see how a .fixup
function, which is completely internal to the L2 cache driver, could
guess whether the system is coherent or not.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
